%% gui_plant_createFermenterBtnGroup
% Create buttongroup on panel for fermenter on <gui_plant.html |gui_plant|>
%
function handles= gui_plant_createFermenterBtnGroup(handles, hSelectedObject)
%% Release: 1.4

%%

error( nargchk(2, 2, nargin, 'struct') );
error( nargoutchk(1, 1, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '1st');

%%
%create Frame for buttons

y_offset= 11.05;

%%
% delete buttons if existent

if isfield(handles, 'f_but')
  if isfield(handles.f_but, 'fermsave')
    if ishandle(handles.f_but.fermsave)
      delete(handles.f_but.fermsave);
    end
    handles.f_but= rmfield(handles.f_but, 'fermsave');
  end

  if isfield(handles.f_but, 'fermcancel')
    if ishandle(handles.f_but.fermcancel)
      delete(handles.f_but.fermcancel);
    end
    handles.f_but= rmfield(handles.f_but, 'fermcancel');
  end

  if isfield(handles.f_but, 'fermreset')
    if ishandle(handles.f_but.fermreset)
      delete(handles.f_but.fermreset);
    end
    handles.f_but= rmfield(handles.f_but, 'fermreset');
  end

  handles= rmfield(handles, 'f_but');
end

%%

% handles.frame2= uipanel('Style', 'Frame',...
%     'Position', [320 15 200 65]);
handles.f_but.fermsave= uicontrol('Style','pushbutton', ...
    'CallBack',@gui_plant_fermsave_but_Callback,...
    'units', 'characters', ...
    ...%'Position', [60 18.5 + y_offset 13.8 1.6153], ...
    'Position', [1.5 1.7 13.8 1.6153], ...
    'String','OK', ...
    'parent', handles.frame1, ...
    'userdata', 1);

handles.f_but.fermcancel= uicontrol('Style','pushbutton', ...
    'CallBack',@gui_plant_fermsave_but_Callback,...
    'units', 'characters', ...
    ...%'Position', [60 16.5 + y_offset 13.8 1.6153],...
    'Position', [1.5 + 13.8 + 0.5 1.7 13.8 1.6153], ...
    'String','Cancel', ...
    'parent', handles.frame1, ...
    'userdata', 0);

handles.f_but.fermreset= uicontrol('Style','pushbutton', ...
    'CallBack',@gui_plant_fermsave_but_Callback,...
    'units', 'characters', ...
    ...%'Position', [60 14.5 + y_offset 13.8 1.6153],...
    'Position', [1.5 + 2*(13.8 + 0.5) 1.7 13.8 1.6153], ...
    'String','Reset', ...
    'parent', handles.frame1, ...
    'userdata', 2);


%%

% Create the button group.
handles.fbuttons = uibuttongroup('visible','off', ...
    'units', 'characters', ...
    ...'Position', [1.5 1.0 50 3.2], ...
    'Position', [60 14.6 + y_offset 13.8 6.0], ...
    'parent', handles.frame1, 'borderwidth', 0);

handles.f_but.fermgeneral= uicontrol('Style','togglebutton',...
    'units', 'characters', ...
    ...'Position', [1.0 0.75 15 1.6153], ...
    'Position', [0 4.0 13.8 1.6153], ...
    'String','general','Max',1, ...
    'Min',0,'Tag','f_general',...
    'parent',handles.fbuttons,'HandleVisibility','off');

%check if inflow variables are present for fermenter
%if isfield(handles.workspace.plant.fermenter.( ...
 %       handles.f_id_select),'inflow')
    handles.f_but.ferminflow= uicontrol('Style','togglebutton',...
        'units', 'characters', ...
    ...'Position', [17.0 0.75 15 1.6153],...
    'Position', [0 2.0 13.8 1.6153], ...
    'String','inflow','Max',1, ...
        'Min',0,'Tag','f_inflow',...
        'parent',handles.fbuttons,'HandleVisibility','off');
%end

%check if heating is present:
%if isfield(handles.workspace.plant.fermenter.( ...
 %       handles.f_id_select),'heating')
    handles.f_but.fermheating= uicontrol('Style','togglebutton',...
        'units', 'characters', ...
    ...'Position', [33.0 0.75 15 1.6153],...
    'Position', [0 0.0 13.8 1.6153], ...
    'String','heating','Max',1, ...
        'Min',0,'Tag','f_heating',...
        'parent',handles.fbuttons,'HandleVisibility','off');
%end

% Initialize some button group properties.
set(handles.fbuttons, 'SelectionChangeFcn', @gui_plant_f_buttongroup_cbk);

%%

switch hSelectedObject
  case 1
    % select general
    set(handles.f_but.fermgeneral,'Value',1);
    set(handles.fbuttons,'SelectedObject', handles.f_but.fermgeneral);  
  case 2
    set(handles.f_but.ferminflow,'Value',1);
    set(handles.fbuttons,'SelectedObject', handles.f_but.ferminflow);  
  case 3
    set(handles.f_but.fermheating,'Value',1);
    set(handles.fbuttons,'SelectedObject', handles.f_but.fermheating);  
end

%%

set(handles.fbuttons,'Visible','on');

%%


