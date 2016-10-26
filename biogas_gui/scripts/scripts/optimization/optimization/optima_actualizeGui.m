%% optima_actualizeGui
% Dynamically creates the fields inside the gui.
%
function handles= optima_actualizeGui(handles)
%% Release: 1.1

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(1, 1, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '1st');

%%

if isempty(handles.plantName)
  plant_id_or_name= handles.plantID;
else
  plant_id_or_name= handles.plantName;
end

%%

[handles.plant, path_config_mat]= loadPlantStructure(plant_id_or_name);

%%

if ~isempty(handles.plant)
    
  if isempty(handles.plantName)

    set(handles.lblPlant, 'String', char(handles.plant.name));
    %handles= setpopPlantToValue(handles, handles.plant.name);

    set(handles.btnChangeFlux_optima, 'Enable', 'on');
    set(handles.btnStartOptimization, 'Enable', 'on');

  end

  handles.plantID=   char(handles.plant.id);
  handles.plantName= char(handles.plant.name);

end


%%

posPanels= get(handles.panSubstrate, 'Position');
topPanels= posPanels(1,4) - 1.8 - 1.615/2.0 - 0.6;

posPanelsFlux= get(handles.panPumpFlux, 'Position');
topPanelsFlux= posPanelsFlux(1,4) - 1.8 - 1.615/2.0 - 0.6;

%%

if ~isempty(handles.plant)
    
  substrate_file= fullfile( ...
          path_config_mat, ['substrate_', char(handles.plant.id), '.xml' ] ...
                    );

  %%
  
  if exist( substrate_file, 'file' )

    %%
    
    substrate= biogas.substrates(substrate_file);
    
    handles.substrate= substrate;

    n_substrates= handles.substrate.getNumSubstratesD();

    handles.substrateflow=    zeros(n_substrates, 1);
    handles.lblSubstrateFlow= zeros(n_substrates, 1);
    
    handles.lblSubstrateFlowRange= zeros(n_substrates, 1);
    
    handles.lblSubstrateFlowUnit= zeros(n_substrates, 1);
    
    %%
    
    handles= loadPlantNetworkBoundsFromFile(handles, ...
                  path_config_mat, handles.model_path);

    %%
    
    handles= loadSubstrateNetworkBoundsFromFile(handles, ...
                  path_config_mat, handles.model_path);

    
    %%

    spacedimension= [];

    %%

    for isubstrate= 1:n_substrates

      substrateName= char(substrate.getName(isubstrate));

      handles.lblSubstrateFlow(isubstrate,1)= ...
          uicontrol('Style', 'text', 'Units', 'characters', ...
                    'Position', [1.8 topPanels - ...
                    (isubstrate - 1)*2 43.1 1.615],...
                    'String', substrateName, ...
                    'Parent', handles.panSubstrate, ...
                    'HorizontalAlignment', 'left');

      %%

      min_substrate= ...
                  sum(handles.substrate_network_min(isubstrate,:));
      max_substrate= ...
                  sum(handles.substrate_network_max(isubstrate,:));

      if (min_substrate ~= max_substrate)
          StringSubstrate= sprintf('%.2f, ..., %.2f', ...
                       min_substrate, max_substrate);      

          spacedimension= ...
              [spacedimension; max_substrate - min_substrate];
      else
          StringSubstrate= sprintf('%.2f', min_substrate);      
      end

      %%

      handles.lblSubstrateFlowRange(isubstrate,1)= ...
        uicontrol('Style', 'text', 'Units', 'characters', ...
                'Position', [44.8 topPanels - ...
                (isubstrate-1)*2 27.0 1.615],...
                'String', StringSubstrate, ...
                ...'BackgroundColor', 'white', ...
                'Parent', handles.panSubstrate, ...
                'HorizontalAlignment', 'center', ...
                'ToolTipString', ...
                sprintf(['Wertebereich f�r ', ...
                'die Substratmenge von %s!'], ...
                substrateName));%, ...
                %'KeyPressFcn', {@saveSubstrateFlow, handles, isubstrate});%, ...
                %'Callback', {@saveSubstrateFlow, handles, isubstrate});

      handles.lblSubstrateFlowUnit(isubstrate,1)= ...
          uicontrol('Style', 'text', 'Units', 'characters', ...
                    'Position', [68.6 topPanels - ...
                    (isubstrate-1)*2 8.2 1.615],...
                    ...'String', '<html>[m<sup>3</sup>/d]<html>');
                    'String', '[m�/d]', ...
                    'Parent', handles.panSubstrate, ...
                    'HorizontalAlignment', 'center');

      %%

      if (min_substrate ~= max_substrate)
          set(handles.lblSubstrateFlowRange(isubstrate,1), ...
            'BackgroundColor', 'green');
          set(handles.lblSubstrateFlow(isubstrate,1), ...
            'BackgroundColor', 'green');
          set(handles.lblSubstrateFlowUnit(isubstrate,1), ...
            'BackgroundColor', 'green');
      end

    end % for

  end % if
    
    
  %%

  plant_network_file= fullfile( ...
          path_config_mat, ['plant_network_', char(handles.plant.id), '.mat' ] ...
                    );

  %%
  
  if exist( plant_network_file, 'file' )

    load(plant_network_file);

    handles.plant_network= plant_network;

    total_number_fluxes= 0;

    for irow= 1:size(plant_network, 1)

        if sum(handles.plant_network(irow, :) > 0) > 1

            total_number_fluxes= total_number_fluxes + ...
                        sum(handles.plant_network(irow, 1:end-1) > 0);

        end

    end

    %%
    
    handles.pumpFlux=    zeros(total_number_fluxes, 1);
    handles.lblPumpFlux= zeros(total_number_fluxes, 1);

    handles.lblPumpFluxRange= zeros(total_number_fluxes, 1);

    handles.lblPumpFluxUnit= zeros(total_number_fluxes, 1);

    iPumpFlux= 0;

    %%
    
    for ifermenterOut= 1:size(handles.plant_network,1)

      fermenterOutName= char(handles.plant.getDigesterName(ifermenterOut));

      for ifermenterIn= 1:size(handles.plant_network,2) - 1

        fermenterInName= char(handles.plant.getDigesterName(ifermenterIn));
          
        if handles.plant_network(ifermenterOut, ifermenterIn) > 0 && ...
           sum(handles.plant_network(ifermenterOut, :) > 0) > 1

          %%
          
          iPumpFlux= iPumpFlux + 1;

          fermenterString= ...
              [fermenterOutName, ' -> ', fermenterInName];

          handles.lblPumpFlux(iPumpFlux,1)= ...
            uicontrol('Style', 'text', 'Units', 'characters', ...
                  'Position', [1.8 topPanelsFlux - ...
                  (iPumpFlux-1)*2 43.1 1.615],...
                  'String', fermenterString, ...
                  'Parent', handles.panPumpFlux, ...
                  'HorizontalAlignment', 'left');

          %%

          min_flux= handles.plant_network_min(ifermenterOut,ifermenterIn);
          max_flux= handles.plant_network_max(ifermenterOut,ifermenterIn);

          if (min_flux ~= max_flux)
              StringFlux= sprintf('%.2f, ..., %.2f', ...
                           min_flux, max_flux);    

              spacedimension= ...
                      [spacedimension; max_flux - min_flux];
          else
              StringFlux= sprintf('%.2f', min_flux);      
          end

          %%
          
          handles.lblPumpFluxRange(iPumpFlux... %+ ...
                             ...%(ifermenter - 1)*total_number_fluxes,1
                             )= ...
              uicontrol('Style', 'text', 'Units', 'characters', ...
                        'Position', [44.8 topPanelsFlux - ...
                        (iPumpFlux-1)*2 27.0 1.615],...
                        'String', StringFlux, ...
                        ...'BackgroundColor', 'white', ...
                        'Parent', handles.panPumpFlux, ...
                        'HorizontalAlignment', 'center', ...
                        'Tag', ...
                [char(handles.plant.getDigesterID(ifermenterOut)), '_', ...
                 char(handles.plant.getDigesterID(ifermenterIn))], ...
                        'ToolTipString', ...
                        sprintf(['Wertebereich f�r ', ...
                        'die zu pumpende Menge zwischen %s und %s!'], ...
                        fermenterOutName, fermenterInName));



          handles.lblPumpFluxUnit(iPumpFlux,1)= ...
              uicontrol('Style', 'text', 'Units', 'characters', ...
                        'Position', [68.6 topPanelsFlux - ...
                        (iPumpFlux-1)*2 8.2 1.615],...
                        ...'String', '<html>[m<sup>3</sup>/d]<html>');
                        'String', '[m�/d]', ...
                        'Parent', handles.panPumpFlux, ...
                        'HorizontalAlignment', 'center');

          %%
          
          if (min_flux ~= max_flux)
              set(handles.lblPumpFluxRange(iPumpFlux,1), ...
                    'BackgroundColor', 'green');
            set(handles.lblPumpFlux(iPumpFlux,1), ...
                    'BackgroundColor', 'green');
              set(handles.lblPumpFluxUnit(iPumpFlux,1), ...
                    'BackgroundColor', 'green');
          end     

        end % if

      end % for

    end % for

    %%

    set(handles.txtPopSize_optima, 'String', ...
        setPopSize( spacedimension ));

    set(handles.txtNoGenerationen_optima, 'String', ...
        2 * str2double( get(handles.txtPopSize_optima, 'String') ));

    %%
    % annahme 1/2 min pro simulation

    estimatedtime= str2double( get(handles.txtNoGenerationen_optima, 'String') ) * ...
           str2double( get(handles.txtPopSize_optima, 'String') ) * 0.5;

    estimatedtime_h= fix(estimatedtime / 60);
    estimatedtime_min= round(estimatedtime - estimatedtime_h * 60);

    set(handles.lblRestTime, 'String', sprintf('%i h : %i min', ...
                             estimatedtime_h, estimatedtime_min));

    %%

  end % if
    
    
    
else
  error('Could not find the selected plant!');
end


%%
% Update handles structure
%guidata(hObject, handles);

%%


