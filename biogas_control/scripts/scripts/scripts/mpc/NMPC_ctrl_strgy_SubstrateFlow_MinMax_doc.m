%% Syntax
%       [substrate_network_min, substrate_network_max]= 
%       NMPC_ctrl_strgy_SubstrateFlow_MinMax(substrate, plant,
%       substrate_network_min, substrate_network_max,
%       substrate_network_min_limit, substrate_network_max_limit)
%       [...]= NMPC_ctrl_strgy_SubstrateFlow_MinMax(substrate, plant,
%       substrate_network_min, substrate_network_max,
%       substrate_network_min_limit, substrate_network_max_limit,
%       change_type) 
%       [...]= NMPC_ctrl_strgy_SubstrateFlow_MinMax(substrate, plant,
%       substrate_network_min, substrate_network_max,
%       substrate_network_min_limit, substrate_network_max_limit,
%       change_type, change_substrate)
%       [...]= NMPC_ctrl_strgy_SubstrateFlow_MinMax(substrate, plant,
%       substrate_network_min, substrate_network_max,
%       substrate_network_min_limit, substrate_network_max_limit,
%       change_type, change_substrate, trg)
%       [...]= NMPC_ctrl_strgy_SubstrateFlow_MinMax(substrate, plant,
%       substrate_network_min, substrate_network_max,
%       substrate_network_min_limit, substrate_network_max_limit,
%       change_type, change_substrate, trg, trg_opt)
%       [...]= NMPC_ctrl_strgy_SubstrateFlow_MinMax(substrate, plant,
%       substrate_network_min, substrate_network_max,
%       substrate_network_min_limit, substrate_network_max_limit,
%       change_type, change_substrate, trg, trg_opt, fitness_trg)
%       [...]= NMPC_ctrl_strgy_SubstrateFlow_MinMax(substrate, plant,
%       substrate_network_min, substrate_network_max,
%       substrate_network_min_limit, substrate_network_max_limit,
%       change_type, change_substrate, trg, trg_opt, fitness_trg, wrng_msg)
%
%% Description
% |[...]= NMPC_ctrl_strgy_SubstrateFlow_MinMax(...)| creates
% |substrate_network_min| and |substrate_network_max| out ouf current
% |substrate_network_min| and |substrate_network_max|, which are identical
% when this function is called, this is due to the function
% <nmpc_save_ctrl_strgy_substrateflow.html
% NMPC_save_ctrl_strgy_SubstrateFlow>. Further checks if bounds hold and
% sets the |change_substrate| value in the workspace of the caller
% depending on the |trg| option.  
%
%% <<substrate/>>
%% <<plant/>>
%% <<substrate_network_min/>>
%% <<substrate_network_max/>>
%%
% @param |substrate_network_min_limit| :
% <matlab:doc('define_lb_ub_optim') |substrate_network_min|>,
%
%%
% @param |substrate_network_max_limit| :
% <matlab:doc('define_lb_ub_optim') |substrate_network_max|>
%
%%
% @return |substrate_network_min| : 
%
%%
% @return |substrate_network_max| : 
%
%%
% |[...]= NMPC_ctrl_strgy_SubstrateFlow_MinMax( ...
% substrate, plant, substrate_network_min, substrate_network_max, ...
% substrate_network_min_limit, substrate_network_max_limit, change_type)|
%
%%
% @param |change_type| : char 
%
% * 'percentual' : sets the stepwise control increment/decrement as a 
% percentage [100 %] value
% * 'absolute' : sets the stepwise control increment/decrement as an 
% absolute [m�/day] value
%
%%
% @param |change_substrate| : either a scalar, then change for all substrates is
% equal or a matrix with n_substrate rows and n_fermenter columns, where
% the change value is defined for each substrate and digester. The unit of
% the values is defined by the parameter |change_type|. Default: 0.05,
% meaning 5 %. 
%
%%
% @param |trg|   : If empty the standard value is 'off'.
%
% * 'on'  : activates the trigger for the fitness value; if the fitness 
% does not change in the last five NMPC interation the step size |change_substrate| 
% is increased/decreased depending on |trg_opt|. If trigger is active, then
% |change_substrate| is changed and assigned to the workspace of the
% calling function. 
% * 'off' : trigger option deactivated. 
%
%%
% @param |trg_opt|   : double, if empty the standard value is |-Inf|. This
% parameter has only effect if the parameter |trg| is 'on'. 
% 
% * Inf      : increases the step size |change_substrate| value by 10[%]
% over time. 
% * -Inf     : decreases the step size |change_substrate| value by 10[%]
% over time. 
% * some constant : the new step size |change_substrate| is changed by the
% given factor. If it is 1.1, this means an increase by 10 %, if it is 0.9
% it means a decrease by 10 %. The number must be positive. 
%
%%
% @param |fitness_trg| : row vector of fitness values gotten over the last
% iterations. At the moment does only work with SO optimization methods.
% Default: []. 
%
%%
% @param |wrng_msg| : Show a warning if min < min_limit or max > max_limit.
% If empty the standard value is 'on'. 
%
% * 'on'  : show warning
% * 'off' : do not show warning
%
%% Example
% 
%

[substrate, plant, ~, ~, ...
 substrate_network_min, substrate_network_max]= ...
 load_biogas_mat_files('gummersbach');

%%

substrate_network_min_limit= substrate_network_min;
substrate_network_max_limit= substrate_network_max;

equilibrium= load_file('equilibrium_gummersbach');

control_horizon= 3; % days

%%

[substrate_network_min, substrate_network_max]= ...
 NMPC_save_ctrl_strgy_SubstrateFlow(substrate, plant, ...
 substrate_network_min, substrate_network_max, equilibrium, control_horizon, 1);

%%

disp(substrate_network_min)
disp(substrate_network_max)

%%

[ substrate_network_min, substrate_network_max ] = ...
      NMPC_ctrl_strgy_SubstrateFlow_MinMax( ...
          substrate, plant, substrate_network_min, substrate_network_max, ...
          substrate_network_min_limit, substrate_network_max_limit);

%%

disp(substrate_network_min)
disp(substrate_network_max)

%%

substrate_network_max_limit(2)= 50;

%%
% call with change_fermenter being a matrix

[ substrate_network_min, substrate_network_max ] = ...
      NMPC_ctrl_strgy_SubstrateFlow_MinMax( ...
          substrate, plant, substrate_network_min, substrate_network_max, ...
          substrate_network_min_limit, substrate_network_max_limit, [], [0 0; 0.5 0; 0 0]);

%%

disp(substrate_network_min)
disp(substrate_network_max)


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('assignin')">
% matlab/assignin</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('validatestring')">
% matlab/validatestring</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/is_onoff')">
% script_collection/is_onoff</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_substrate')">
% biogas_scripts/is_substrate</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_plant')">
% biogas_scripts/is_plant</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_substrate_network')">
% biogas_scripts/is_substrate_network</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_control/nmpc_check_substrate_network_bounds')">
% biogas_control/NMPC_check_substrate_network_bounds</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="startnmpcatequilibrium.html">
% biogas_control/startNMPCatEquilibrium</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="startnmpc.html">
% biogas_control/startNMPC</a>
% </html>
% ,
% <html>
% <a href="nmpc_load_fermenterflow.html">
% biogas_control/NMPC_load_FermenterFlow</a>
% </html>
% ,
% <html>
% <a href="nmpc_save_ctrl_strgy_substrateflow.html">
% biogas_control/NMPC_save_ctrl_strgy_SubstrateFlow</a>
% </html>
% ,
% <html>
% <a href="nmpc_save_ctrl_strgy_fermenterflow.html">
% biogas_control/NMPC_save_ctrl_strgy_FermenterFlow</a>
% </html>
% ,
% <html>
% <a href="nmpc_ctrl_strgy_fermenterflow_minmax.html">
% biogas_control/NMPC_ctrl_strgy_FermenterFlow_MinMax</a>
% </html>
%
%% TODOs
% # improve documentation a little
% # solve TODOs inside function
% # check appearance of documentation
% # fitness_trg works only for SO optimization
%
%% <<AuthorTag_ALSB/>>


