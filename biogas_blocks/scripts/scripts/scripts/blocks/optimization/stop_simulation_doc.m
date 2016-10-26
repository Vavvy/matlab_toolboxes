%% Syntax
%       stop_simulation(t,x,u,flag)
%       stop_simulation(t,x,u,flag, sensors, deltatime) 
%
%% Description
% |stop_simulation(t,x,u,flag)| stops simulation if time |t| > input |u|.
% It is a
% Level-1 M-file S-function in the library represented by 'stop 
% simulation' block. 
%
% WARNING!!! NOT YET IMPLEMENTED!!!
%
%%
% @param |t| : actual simulation time
%
%%
% @param |x| : actual state vector, here the empty vector [], since the model
% does not depend on a state
%
%%
% @param |u| : The input.
%
%%
% @param |flag| : 
%
%   What is returned by SFUNC at a given point in time, T, depends on the
%   value of the FLAG, the current state vector, X, and the current
%   input vector, U.
%
%   FLAG   RESULT             DESCRIPTION
%   -----  ------             --------------------------------------------
%   0      [SIZES,X0,STR,TS]  Initialization, return system sizes in SYS,
%                             initial state in X0, state ordering strings
%                             in STR, and sample times in TS.
%   1      DX                 Return continuous state derivatives in SYS.
%   2      DS                 Update discrete states SYS = X(n+1)
%   3      Y                  Return outputs in SYS.
%   4      TNEXT              Return next time hit for variable step sample
%                             time in SYS.
%   5                         Reserved for future (root finding).
%   9      []                 Termination, perform any cleanup SYS=[].
%
%%
% @param |sensors| : object of the class |biogas.sensors|.
%
%%
% @return : see the MATLAB documentation, resp. the parameter |flag| above
% 
%% Example
% 
%
%% Dependencies
% 
% This function calls:
%
% -
%
% and is called by:
%
% (no block yet)
%
%% See Also
% 
% -
%
%% TODOs
% # not yet implemented
%
%% <<AuthorTag_DG/>>


