%% Syntax
%       [init_substrate_feed]=
%       get_init_feed_oo_equilibrium_and_save_to(equilibrium, substrate,
%       plant, control_horizon)
%       [...]= get_init_feed_oo_equilibrium_and_save_to(equilibrium,
%       substrate, plant, control_horizon, delta) 
%       [...]= get_init_feed_oo_equilibrium_and_save_to(equilibrium,
%       substrate, plant, control_horizon, delta, accesstofile) 
%
%% Description
% |[init_substrate_feed]=
% get_init_feed_oo_equilibrium_and_save_to(equilibrium, substrate, plant,
% control_horizon)| gets first values of substrate feed out of equilibrium
% and saves it to volumeflow variables or saves them to const files (see parameter
% |accesstofile|). 
%
%% <<equilibrium/>>
%% <<substrate/>>
%% <<plant/>>
%%
% @param |control_horizon| : control horizon, measured in days
%
%%
% @param |delta| : sampling time, measured in days
%
%%
% @param |accesstofile| : 
%
% * 1 : if 1, then really save the data to a file. 
% * 0 : if set to 0, then the data isn't saved to a file, but is saved to
% the base workspace (better for optimization purpose -> speed) 
% * -1 : if it is -1, then save the data not to the workspace but to the
% model workspace. In the newest MATLAB versions, from 7.11 on, it is not
% allowed anymore to save into the modelworkspace while the model is
% running. So then we save to a file using <matlab:doc('save')
% matlab/save>. In case we are running the models in parallel, then to the
% filename an integer is appended, this is the integer of the currently
% load model. 
%
%%
% @return |init_substrate_feed| : total (for all digesters as a sum) volumeflow
% for each substrate. 
%
%% Example
% 
% # Example with |lenGenomSubstrate| == 1

cd( fullfile( getBiogasLibPath(), 'examples/nmpc/Gummersbach' ) );

equilibrium= load_file('equilibrium_gummersbach_optimum.mat');

[substrate, plant]= load_biogas_mat_files('gummersbach');

%%

get_init_feed_oo_equilibrium_and_save_to(equilibrium, substrate, plant, 10, 10, 0);

% display results

volumeflow_grass_const

volumeflow_maize_const

volumeflow_manure_const


%%
% # Example with |lenGenomSubstrate| == 2

equilibrium= load_file('equilibrium_sunderhook_optimum.mat');

[substrate, plant]= load_biogas_mat_files('sunderhook');

get_init_feed_oo_equilibrium_and_save_to(equilibrium, substrate, plant, 7, 3.5, 0);

% display results

volumeflow_bullmanure_const

volumeflow_grass_const

volumeflow_greenrye_const

volumeflow_maize1_const

volumeflow_oat_const

volumeflow_silojuice_const

volumeflow_stiffmanure_const



%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc biogas_scripts/is_equilibrium">
% biogas_scripts/is_equilibrium</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/is_substrate">
% biogas_scripts/is_substrate</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/is_plant">
% biogas_scripts/is_plant</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/get_init_feed_oo_equilibrium">
% biogas_scripts/get_init_feed_oo_equilibrium</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/create_volumeflow_files">
% biogas_scripts/create_volumeflow_files</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc biogas_control/nmpc_tmrfcn">
% biogas_control/NMPC_TmrFcn</a>
% </html>
% 
%% See Also
%
% <html>
% <a href="matlab:doc biogas_scripts/create_volumeflow_files">
% biogas_scripts/create_volumeflow_files</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/get_feed_oo_equilibrium">
% biogas_scripts/get_feed_oo_equilibrium</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/get_feed_oo_equilibrium_and_save_to">
% biogas_scripts/get_feed_oo_equilibrium_and_save_to</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/createvolumeflowfile">
% biogas_scripts/createvolumeflowfile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/get_initstate_dig_oo_equilibrium">
% biogas_scripts/get_initstate_dig_oo_equilibrium</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/get_sludge_oo_equilibrium">
% biogas_scripts/get_sludge_oo_equilibrium</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/get_initstate_outof_equilibrium">
% biogas_scripts/get_initstate_outof_equilibrium</a>
% </html>
%
%% TODOs
% # do documentation for script file
% # improve documentation a little
% # check appearance of documentation
%
%% <<AuthorTag_DG/>>


