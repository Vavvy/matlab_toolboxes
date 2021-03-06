%% ekf_discrete_simon
% Discrete Extended Kalman Filter implementation out of Dan Simon's book: Optimal
% State Estimation
%
function [xp, varargout]= ekf_discrete_simon(f, h, fA, fB, fC, u, y, varargin)
%% Release: 1.0

%%

error( nargchk(7, 12, nargin, 'struct') );
error( nargoutchk(0, 5, nargout, 'struct') );

%%

checkArgument(f, 'f', 'function_handle', '1st');
checkArgument(h, 'h', 'function_handle', '2nd');

checkArgument(fA, 'fA', 'function_handle', '3rd');
checkArgument(fB, 'fB', 'function_handle', 4);
checkArgument(fC, 'fC', 'function_handle', 5);

checkArgument(u, 'u', 'double', 6);
checkArgument(y, 'y', 'double', 7);

if isvector(u)
  u= u(:);
end

if isvector(y)
  y= y(:);
end

%%
% x0 is needed for the next param

if nargin >= 10 && ~isempty(varargin{3})
  x0= varargin{3};
  isRn(x0, 'x0', 10);
  x0= x0(:);
else
  error('You must provide the initial state x0!');
end

if nargin >= 8 && ~isempty(varargin{1})
  Q= varargin{1};
  checkArgument(Q, 'Q', 'double', 8);
  
  if isvector(Q) || size(Q, 1) ~= size(Q,2)  % then the noise is given as a vector
    std_dev= std(Q)';  % returns a row vector, transposed gives a column vector
    
    Q= diag(std_dev.^2);
  end
  
else
  % Q wird folgenderma�en interpretiert:
  % x(k+1) = A * x(k) + B * ( u(k) + w(k) )
  % x(k+1) = A * x(k) + B * u(k) + B * w(k)
  % q(k) := B * w(k)
  % q(k) ist ein Zufallsprozess mit Mittelwert 0 und
  % Kovarianzmatrix Q
  
  % assuming u is given as u= [input 1, input 2, ...]
  % each input i is a column vector
  %std_dev= std(u)';  % returns a row vector, transposed gives a column vector
  
  std_dev= 0.01 .* ones(size(u, 2), 1);
  
  %% TODO
  % u darf nicht die verrauschte Gr��e sein, sondern eine deterministische
  % damit kann Q nicht �ber u gesch�tzt werden, sondern nur �ber w. D.h.
  % entweder auch w �bergeben oder direkt Q.
  
  % each column of B corresponds to one input. 
  % for a system with 3 states and 2 inputs we have
  %
  %           (std_dev1)
  %           (std_dev2)
  % (b11 b12)
  % (b21 b22)
  % (b31 b32)
  %
  % returns a column vector, which contains the diagonal elements of Q
  %
  Q= diag(std_dev.^2);
end

if nargin >= 9 && ~isempty(varargin{2})
  R= varargin{2};
  checkArgument(R, 'R', 'double', 9);
else
  % assuming y is given as y= [measurement 1, measurement 2, ...]
  % each measurement i is a column vector
  std_dev= std(y);
  
  R= diag(std_dev.^2);
end

if nargin >= 11 && ~isempty(varargin{4})
  P0= varargin{4};
  checkArgument(P0, 'P0', 'double', 11);
else
  P0= 0.000001 .* eye(size(x0, 1));
end

if nargin >= 12 && ~isempty(varargin{5})
  toiteration= varargin{5};
  isN(toiteration, 'toiteration', 12);
else
  toiteration= 10000;
end

%%
% covariance matrix of the estimation error (posteriori "+")

Pp(:,:,1)= P0;

% state x (posteriori "+")
xp(:,1)= x0(:);

% init variables

Pm(:,:,1)= zeros(size(P0));
Pm(:,:,2)= zeros(size(P0));
K(:,:,1)= zeros( size(x0,1), size(y, 2) );
K(:,:,2)= zeros( size(x0,1), size(y, 2) );
xm(:,1)= zeros(numel(x0), 1);
xm(:,2)= zeros(numel(x0), 1);

%%
% Kalman Filter 
for iter=2:toiteration
  
  %%
  % make A, B, C time dependent
  
  A= feval(fA, xp(:,iter - 1));
  B= feval(fB, xp(:,iter - 1));
  
  %%
  
  % covariance matrix P (priori "-")
  % P(k)^- = A * P(k-1)^+ * A^T + Q
  Pm(:,:,iter)= A * Pp(:,:,iter - 1) * A' + B * Q * B';

  % state x update (priori "-")
  % x(k)^- = A * x(k-1)^+ + B * u(k-1)
  xm(:,iter)= feval(f, xp(:,iter - 1), u(iter - 1,:)');

  %%
  
  C= feval(fC, xm(:,iter));
  
  %%
  % test if system is observable

  %% TODO - make dependent on a parameter
  if(0)
    
  r= rank ( obsv( A, C ) );

  if r < size(A, 1)
    warning('system:notobservable', ...
            'the system is not observable: rank (%i) < %i', r, size(A, 1));
  end
  
  end
  
  %%
  
  % Kalman Gain K
  % K(k)= P(k)^- * C^T * ( C * P(k)^- * C + R(k) )^(-1)
  % K(:,:,iter)= Pm(:,:,iter) * C' * inv( C * Pm(:,:,iter) * C' + R );
  K(:,:,iter)= Pm(:,:,iter) * C' / ( C * Pm(:,:,iter) * C' + R );

  % state x update (posteriori "+")
  % x(k)^+ = x(k)^- + K(k) * ( y(k) - C(k) * x(k)^- )
  xp(:,iter)= xm(:,iter) + K(:,:,iter) * ( y(iter,:)' - feval(h, xm(:,iter)') );

  % covariance matrix P (posteriori "+")
  % P(k)^+ = ( I - K(k) * C ) * P(k)^- * ( I - K(k) * C )^T + K(k) * R(k) *
  % K(k)^T
  Pp(:,:,iter)= ( eye(size(K(:,:,iter), 1), size(C, 2)) - K(:,:,iter) * C ) * ...
                Pm(:,:,iter) * ...
                ( eye(size(K(:,:,iter), 1), size(C, 2)) - K(:,:,iter) * C )' + ...
                K(:,:,iter) * R * K(:,:,iter)';

end

%%

if nargout >= 2
  varargout{1}= xm;
end

if nargout >= 3
  varargout{2}= Pp;
end

if nargout >= 4
  varargout{3}= Pm;
end

if nargout >= 5
  varargout{4}= K;
end

%%


