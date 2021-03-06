%% gui_plant_createFermenterPanel
% Create panel for fermenter on <gui_plant.html |gui_plant|>
%
function handles= gui_plant_createFermenterPanel(handles)
%% Release: 1.4

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(1, 1, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '1st');

%%
%getvariables according to selected values:
% Fermenter ID
handles.f_id_active=get(handles.listDigesters,'value');
handles.f_id_select=char(handles.workspace.plant.getDigesterID( ...
    handles.f_id_active));

%%

pos_frmPlC= get(handles.frmPlantControl, 'Position');

y_offset= 11.05;

%create Frame for Fermenter variables
if ~isfield(handles, 'frame1')
  %delete(handles.frame1)
  %handles=rmfield(handles,'frame1');

  handles.frame1= uipanel('Title', 'Edit Fermenters', ...
    'units', 'characters', ...
    'Position', [57.8 pos_frmPlC(2) 76.2 pos_frmPlC(4)]);
end

set(handles.frame1,'Visible','on');

%if ~isfield(handles, 'frame1_1')
  %% 
  % OK - Gel�st
  % Achtung:
  % bei klicken auf die drei kleinen buttons, rechts, wird immer wieder die
  % gui komplett neu erstellt, damit gehen die eingaben auf einer der seiten
  % verloren, wenn man diese nicht vorher gespeichert hat
  %
  handles.frame1_1= uicontrol('Style', 'Frame',...
            'units', 'characters', ...
            'Position', [1.5 y_offset + 2 43.5 18.85], ...%17.85
            'ForegroundColor', [0.941 0.941 0.941], ...
            'parent', handles.frame1);
% else
%   set(handles.frame1_2, 'visible', 'off');
%   set(handles.frame1_3, 'visible', 'off');
% end

%%

% if ~isfield(handles, 'ftext')

%texts
handles.ftext.fID= uicontrol('Style', 'Text', 'String','Fermenter ID:',...
    'units', 'characters', ...
    'HorizontalAlignment', 'left', ...
    'Position', [1.5 18.5 + y_offset 15 1.6153],...
    'HandleVisibility','on', 'parent', handles.frame1);
handles.ftext.fname= uicontrol('Style', 'Text', 'String','Name:',...
    'units', 'characters', ...
        'HorizontalAlignment', 'left', ...
    'Position', [1.5 16.5 + y_offset 15 1.6153], ...
    'parent', handles.frame1);
handles.ftext.fVtot= uicontrol('Style', 'Text', 'String','V_tot [m�]:',...
    'units', 'characters', ...
    'HorizontalAlignment', 'left', ...
    'Position', [1.5 14.5 + y_offset 15 1.6153], ...
    'parent', handles.frame1);
handles.ftext.fVliq= uicontrol('Style', 'Text', 'String','V_liq [m�]:',...
    'units', 'characters', ...
    'HorizontalAlignment', 'left', ...
    'Position', [1.5 12.5 + y_offset 15 1.6153], ...
    'parent', handles.frame1);
handles.ftext.fVgas= uicontrol('Style', 'Text', 'String','V_gas [m�]:',...
    'units', 'characters', ...
    'HorizontalAlignment', 'left', ...
    'Position', [1.5 10.5 + y_offset 15 1.6153], ...
    'parent', handles.frame1);
handles.ftext.fT= uicontrol('Style', 'Text', 'String','Temperature [�C]:',...
    'units', 'characters', ...
    'HorizontalAlignment', 'left', ...
    'Position', [1.5 8.5 + y_offset 17 1.6153], ...
    'parent', handles.frame1);

%if isfield( handles.workspace.plant.fermenter.(...
 %       handles.f_id_select), 'Atot' )
    handles.ftext.fAtot= ...
        uicontrol('Style', 'Text', 'String','A_tot [m�]:',...
        'units', 'characters', ...
        'HorizontalAlignment', 'left', ...
        'Position', [1.5 6.5 + y_offset 15 1.6153], ...
        'parent', handles.frame1);
%end

% end

%%

% if ~isfield(handles, 'f_edit')

%Editfields for values of variables

% Fermenter ID
handles.f_edit.fid= uicontrol('Style', 'Text', ...
    'String', handles.f_id_select,...
    'units', 'characters', ...
    'Position', [20 18.5 + y_offset 25 1.6153],...
    'BackgroundColor',[0.941 0.941 0.941], ...
    'parent', handles.frame1);
  
%%
% Fermenter Name
if isfield(handles.f_edit, 'f_name')
  text= get(handles.f_edit.f_name, 'String');
else
  text= char(handles.workspace.plant.getDigesterName(handles.f_id_select));
end

handles.f_edit.f_name= uicontrol('Style', 'Edit', 'String', ...
    text,...
    'units', 'characters', ...
    'Position', [20 16.5 + y_offset 25 1.6153],'BackgroundColor','white', ...
    'parent', handles.frame1, ...
    'ToolTipString', 'Edit the name of the fermenter!');
  
%%
% Vtot
if isfield(handles.f_edit, 'f_Vtot')
  text= get(handles.f_edit.f_Vtot, 'String');
else
  text= handles.workspace.plant.getDigesterParam(handles.f_id_select, 'Vtot');
end

handles.f_edit.f_Vtot= uicontrol('Style', 'Edit', 'String', ...
    text,...
    'units', 'characters', ...
    'Position', [20 14.5 + y_offset 25 1.6153],'BackgroundColor','white', ...
    'parent', handles.frame1, ...
    'ToolTipString', 'Geben Sie hier das komplette Volumen des Fermenters ein!');
  
%%
% Vliq
if isfield(handles.f_edit, 'f_Vliq')
  text= get(handles.f_edit.f_Vliq, 'String');
else
  text= handles.workspace.plant.getDigesterParam(handles.f_id_select, 'Vliq');
end

handles.f_edit.f_Vliq= uicontrol('Style', 'Edit', 'String', ...
    text,...
    'units', 'characters', ...
    'Position', [20 12.5 + y_offset 25 1.6153],'BackgroundColor','white', ...
    'parent', handles.frame1, ...
    'ToolTipString', 'Geben Sie hier das Volumen der Fl�ssigphase des Fermenters ein!');
  
%%  
% Vgas
if isfield(handles.f_edit, 'f_Vgas')
  text= get(handles.f_edit.f_Vgas, 'String');
else
  text= handles.workspace.plant.getDigesterParam(handles.f_id_select, 'Vgas');
end

handles.f_edit.f_Vgas= uicontrol('Style', 'Edit', 'String', ...
    text,...
    'units', 'characters', ...
    'Position', [20 10.5 + y_offset 25 1.6153],'BackgroundColor','white', ...
    'parent', handles.frame1, ...
    'ToolTipString', 'Geben Sie hier das Volumen des Gasraums des Fermenters ein!');
  
%%  
% Fermenter temperature
if isfield(handles.f_edit, 'f_T')
  text= get(handles.f_edit.f_T, 'String');
else
  text= handles.workspace.plant.getDigesterParam(handles.f_id_select, 'T');
end

handles.f_edit.f_T= uicontrol('Style', 'Edit', 'String', ...
    text,...
    'units', 'characters', ...
    'Position', [20 8.5 + y_offset 25 1.6153],'BackgroundColor','white', ...
    'parent', handles.frame1, ...
    'ToolTipString', 'Geben Sie hier die Temperatur im Fermenter ein!');
  
%%  
% Fermenter Atot
if isfield(handles.f_edit, 'f_Atot')
  text= get(handles.f_edit.f_Atot, 'String');
else
  text= handles.workspace.plant.getDigesterParam(handles.f_id_select, 'Atot');
end

%if isfield( handles.workspace.plant.getDigesterParam.(handles.f_id_select), 'Atot' )
    handles.f_edit.f_Atot= uicontrol('Style', 'Edit', ...
        'String',text,...
        'units', 'characters', ...
    'Position', [20 6.5 + y_offset 25 1.6153],'BackgroundColor','white', ...
    'parent', handles.frame1, ...
    'ToolTipString', 'Geben Sie hier die Oberfl�che des Fermenters ein!');
%end

% end


%%

handles= gui_plant_createFermenterBtnGroup(handles, 1);

%%


