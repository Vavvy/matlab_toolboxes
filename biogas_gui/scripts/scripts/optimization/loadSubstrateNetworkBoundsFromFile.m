%% loadSubstrateNetworkBoundsFromFile
% Load substrate_network_min and substrate_network_max files.
%
%% Toolbox
% |loadSubstrateNetworkBoundsFromFile| belongs to the _Biogas Plant Modeling_
% Toolbox and is an internal function.
%
%% Release
% Approval for Release 1.7, to get the approval for Release 1.8 make a
% thorough review, Daniel Gaida 
%
%% Syntax
%       handles= loadSubstrateNetworkBoundsFromFile(handles, ...
%                                           path_config_mat, model_path)
%
%% Description
% |handles= loadSubstrateNetworkBoundsFromFile(handles, path_config_mat,
% model_path)| tries to load the substrate_network_min and substrate_network_max
% *.mat files. It first looks in the folder of the biogas plant model given
% by |model_path|. On failure it tries to load the filename only using
% <matlab:doc('load') |load|>, for the folders in which this function
% searches use the MATLAB documentation. if not successfull, then it loads
% the files from the config_mat folder of the toolbox, given by
% |path_config_mat|.
%
%%
% @param |handles| : handle to a gui
%
%%
% @param |path_config_mat| : char with the path to the config_mat folder
%
%%
% @param |model_path| : char with the path to the folder containing the
% biogas plant model  
%
%%
% @return |handles| : changed handle to a gui
%
%% Example
%
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('fullfile')">
% doc fullfile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('load_file')">
% load_file</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="stream\set_input_stream.html">
% set_input_stream</a>
% </html>
% ,
% <html>
% <a href="gui_nmpc.html">
% gui_nmpc</a>
% </html>
% ,
% <html>
% <a href="gui_optimization.html">
% gui_optimization</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="loadPlantNetworkBoundsFromFile.html">
% loadPlantNetworkBoundsFromFile</a>
% </html>
%
%% TODOs
%
%
%% Author
% Daniel Gaida, M.Sc.EE.IT
%
% Cologne University of Applied Sciences (Campus Gummersbach)
%
% Department of Automation & Industrial IT
%
% GECO-C Group
%
% daniel.gaida@fh-koeln.de
%
% Copyright 2010-2011
%
% Last Update: 07.10.2011
%
%% Function
%
function handles= loadSubstrateNetworkBoundsFromFile(handles, ...
                                               path_config_mat, model_path)

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(1, 1, nargout, 'struct') );

%%

if ~isstruct(handles)
  error(['The 1st parameter handles must be of type struct, ', ...
         'but is of type ', class(handles), '!']);
end

if ~ischar(path_config_mat)
  error('The 2nd parameter path_config_mat must be a char, but is a %s!', ...
         class(path_config_mat));
end

if ~ischar(model_path)
  error('The 3rd parameter model_path must be a char, but is a %s!', ...
         class(model_path));
end

%%

substrate_network_filename= ['substrate_network_min_', ...
                             char(handles.plant.id), '.mat' ];

substrate_network_file= fullfile( ...
        model_path, substrate_network_filename ...
                  );

%%

if exist( substrate_network_file, 'file' )

  substrate_network_min= load_file(substrate_network_file);

  handles.substrate_network_min= substrate_network_min;

else

  try

    substrate_network_min= load_file(substrate_network_filename);

    handles.substrate_network_min= substrate_network_min;

catch ME

    substrate_network_file= fullfile( ...
        path_config_mat, substrate_network_filename ...
                  );

    if exist( substrate_network_file, 'file' )

      substrate_network_min= load_file(substrate_network_file);

      handles.substrate_network_min= substrate_network_min;

    else
      handles.substrate_network_min= [];

      %rethrow(ME);
    end

  end

end


%%

substrate_network_filename= ['substrate_network_max_', ...
                           char(handles.plant.id), '.mat' ];

substrate_network_file= fullfile( ...
      model_path, substrate_network_filename ...
                );

%%

if exist( substrate_network_file, 'file' )

  substrate_network_max= load_file(substrate_network_file);

  handles.substrate_network_max= substrate_network_max;

else

  try

    substrate_network_max= load_file(substrate_network_filename);

    handles.substrate_network_max= substrate_network_max;

  catch ME

    substrate_network_file= fullfile( ...
        path_config_mat, substrate_network_filename ...
                  );

    if exist( substrate_network_file, 'file' )

      substrate_network_max= load_file(substrate_network_file);

      handles.substrate_network_max= substrate_network_max;

    else
      handles.substrate_network_max= [];

      %rethrow(ME);
    end

  end

end
    
%%

  
