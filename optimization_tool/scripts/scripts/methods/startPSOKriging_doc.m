%% Preliminaries
% # This function depends on the MATLAB PSO Toolbox
% <http://www.mathworks.com/matlabcentral/fileexchange/7506-particle-swarm-optimization-toolbox PSOt>
% so this toolbox has to be installed first. 
%
%% Syntax
%       u= startPSOKriging(ObjectiveFunction, lenIndividual)
%       u= startPSOKriging(ObjectiveFunction, lenIndividual, LB)
%       u= startPSOKriging(ObjectiveFunction, lenIndividual, LB, UB)
%       startPSOKriging(ObjectiveFunction, lenIndividual, LB, UB, popSize)
%       startPSOKriging(ObjectiveFunction, lenIndividual, LB, UB, popSize, ...
%                       noGenerations)
%       startPSOKriging(ObjectiveFunction, lenIndividual, LB, UB, popSize, ...
%                       noGenerations, timelimit)
%       startPSOKriging(ObjectiveFunction, lenIndividual, LB, UB, popSize, ...
%                       noGenerations, timelimit, tolerance)
%       [u, fitness]= startPSOKriging(...)
%       
%% Description
% |[u, fitness]= startPSOKriging(ObjectiveFunction, lenIndividual)| prepares and
% starts genetic 
% algorithms with standard settings for optimal control of biogas plants
% created with the _Biogas Plant Modeling_ toolbox. Control means finding
% the optimal operating point. 
%
%%
% @param |ObjectiveFunction| : a function handle with the objective function,
% which GA minimizes. If you don't pass a function_handle, e.g. [], then a
% warning is thrown and an default fitness function is used, which is a
% constant, so every valid individual is optimal. At the moment this
% functionality is not implemented.
%
%%
% @param |lenIndividual| : the length of the individual
%
%%
% @return |u| : optimal individual
%
%%
% @return |fitness| : fitness of the optimal individual
%
%%
% |[u, fitness]= startPSOKriging(ObjectiveFunction, lenIndividual, LB)|
%
%%
% @param |LB| : lower bound of the individual
%
%%
% |[u, fitness]= startPSOKriging(ObjectiveFunction, lenIndividual, LB, UB)|
%
%%
% @param |UB| : upper bound of the individual
%
%%
% |startPSOKriging(ObjectiveFunction, lenIndividual, LB, UB, u0, popSize)|
%
%%
% @param |popSize| : size of the wanted population of the GA algorithm
%
%%
% |startPSOKriging(ObjectiveFunction, lenIndividual, LB, UB, u0, popSize, ...
%          noGenerations)|
%
%%
% @param |noGenerations| : number of generations to run
%
%%
% |startPSOKriging(ObjectiveFunction, lenIndividual, LB, UB, u0, popSize, ...
%          noGenerations, timelimit)|
%
%%
% @param |timelimit| : time limit for the whole optimization process in
% seconds
%
%%
% |startPSOKriging(ObjectiveFunction, lenIndividual, LB, UB, u0, popSize, ...
%          noGenerations, timelimit, tolerance)|
%
%%
% @param |tolerance| : tolerance in the change of the fitness before ending
% the optimization process
%
%%
% |[u, fitness]= startPSOKriging(...)|
%
%%
% @return |fitness| : 
%
%% Example
% 
% # Solve generalized Rastrigin's Function using Particle Swarm Algorithm
% with Kriging Approximation

nvars= 2;

LB= -5.12.*ones(nvars,1);
UB=  5.12.*ones(nvars,1);

popSize= 10;
maxIter= 300;

try
[u, fitnessPSOKriging]= startPSOKriging(@fitness_rastrigin, ...
                                nvars, LB, UB, popSize, maxIter);
catch ME
  disp(ME.message)
end



%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:edit PSO_Kriging.m">
% edit PSO_Kriging</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('validateattributes')">
% doc validateattributes</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
%
% and is called by:
%
% -
%
%% See Also
%
% <html>
% <a href="startpso.html">
% startPSO</a>
% </html>
% ,
% <html>
% <a href="startpatternsearch.html">
% startPatternSearch</a>
% </html>
% ,
% <html>
% <a href="startGA_patternsearch.html">
% startGA_PatternSearch</a>
% </html>
% ,
% <html>
% <a href="startde.html">
% startDE</a>
% </html>
% ,
% <html>
% <a href="startcmaes.html">
% startCMAES</a>
% </html>
% ,
% <html>
% <a href="startisres.html">
% startISRES</a>
% </html>
%
%% TODOs
% # ALLES!!!!!!!!!!!!!!!!!!!!!!! KOMPLETTE DOKU, PSO_Kriging MUSS NOCH
% HINZUGEFÜGT WERDEN ZUR TOOLBOX
%
%% <<AuthorTag_CW/>>
%% References
%
% <html>
% <ol>
% <li> 
% Poli, R., Kennedy, J. and Blackwell, T.: 
% <a href="../pdfs/07 Particle Swarm Optimization - An Overview.pdf" target="_top">
% Particle swarm optimization - An Overview</a>, Springer, vol. 1(1):33-57,
% 2007
% </li>
% </ol>
% </html>
%


