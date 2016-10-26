%% biogasM.optimization.popBiogas.evalIndividualForConstraints
% Evaluate individual for nonlinear and linear constraints
%
function fitness= evalIndividualForConstraints(popBiogas, u, varargin)
%% Release: 1.8

%%

error( nargchk(2, 3, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

if nargin >= 3 && ~isempty(varargin{1})
  eval_lin_constraints= varargin{1};
  is0or1(eval_lin_constraints, 'eval_lin_constraints', 3);
else
  eval_lin_constraints= 1;
end

%%
% check arguments

checkArgument(popBiogas, 'popBiogas', 'biogasM.optimization.popBiogas', '1st');

validateattributes(u, {'double'}, {'2d'}, mfilename, 'individual', 2);


%% 
% eval nonlcon on individual
% evtl. hier nicht pr�fen, falls die Pr�fung in einer anderen Form
% nicht schon in der Fitness Funktion des Modells erfolgt. Die
% Formulierung der Nebenbedingungen sind n�mlich meist ungenauer als
% wie die Pr�fung der Simulationsergebnisse
%
fitness= popBiogas.getFitnessNonlconFromIndividual(u);

if (fitness > 0)
  disp(['Warning in evalIndividualForConstraints: ', ...
        'Nonlinear inequality constraints of the substrate mix do not hold!']);
end

%% 
% if method == PSO, then also check for linear inequality constraints,
% since they are not integrated in the algorithm
% auch hier die Frage ob Randbedingungen hier gepr�ft werden sollten
% oder diese nur in der Fitnessfunktion gepr�ft werden sollten, eine
% doppelte Pr�fung sollte auf jeden Fall vermieden werden, da die
% Pr�fung hier noch ungenauer ist
%
if eval_lin_constraints
  fitness= fitness + popBiogas.getFitnessAFromIndividual(u);
end

%%



%%


