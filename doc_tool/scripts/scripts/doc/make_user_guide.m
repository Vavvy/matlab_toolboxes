%% make_user_guide
% Create the user guide for the given toolbox
%
function make_user_guide(path_doc_tool, toolbox_id, toolbox_path)
%% Release: 1.1

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%
% check arguments

checkArgument(path_doc_tool, 'path_doc_tool', 'char', '1st');
checkArgument(toolbox_id, 'toolbox_id', 'char', '2nd');
checkArgument(toolbox_path, 'toolbox_path', 'char', '3rd');


%%

find_entry= @(m_file, entry) find(~cellfun('isempty', strfind(m_file, entry)));

%%

path_help_tool= getPathToHelpFiles(toolbox_path);
path_help_template_doc= fullfile(path_doc_tool, 'templates_doc', ...
                                 'scripts', 'help_mfiles');
path_help_template= fullfile(path_doc_tool, 'templates', ...
                             'scripts', 'help_mfiles');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
% COPY user_guide_index.m

if ~exist(fullfile(path_help_tool, 'user_guide_index.m'), 'file')
  copyfile(fullfile(path_help_template_doc, 'user_guide_index.m'), ...
           fullfile(path_help_template, 'user_guide_index.m'));
end


%%
  
copyfile(fullfile(path_help_template_doc, 'publish_location.txt'), ...
         fullfile(path_help_template, 'publish_location.txt'));

copyfile(fullfile(path_help_template_doc, 'NOTinXML.txt'), ...
         fullfile(path_help_template, 'NOTinXML.txt'));       

copyfile(fullfile(path_help_template_doc, 'InPath.txt'), ...
         fullfile(path_help_template, 'InPath.txt'));

%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
% MAKE developer.m

dev_template= file2cell(fullfile(path_help_template_doc, 'user_guide', 'developer.m'));

dev_tool= file2cell(fullfile(path_help_tool, 'user_guide', 'developer.m'));
  
dev_tool= [dev_template, dev_tool]; 

if ~exist( fullfile(path_help_template, 'user_guide'), 'dir' )
  mkdir( fullfile(path_help_template, 'user_guide') );
end

cell2file(fullfile(path_help_template, 'user_guide', 'developer.m'), dev_tool);

%%
% MAKE developer_tool_template.m

dev_template= file2cell(fullfile(path_help_template_doc, 'user_guide', 'developer_tool_template.m'));

dev_tool= file2cell(fullfile(path_help_tool, 'user_guide', ...
                    sprintf('developer_%s.m', toolbox_id)));
  
dev_tool= [dev_template, dev_tool]; 

cell2file(fullfile(path_help_template, 'user_guide', 'developer_tool_template.m'), dev_tool);

%%
% MAKE enduser.m

end_template= file2cell(fullfile(path_help_template_doc, 'user_guide', 'enduser.m'));

%% Template bearbeiten, bzw. funktionen in template ausf�hren



%%

end_tool= file2cell(fullfile(path_help_tool, 'user_guide', 'enduser.m'));
  
end_tool= [end_template, end_tool]; 

cell2file(fullfile(path_help_template, 'user_guide', 'enduser.m'), end_tool);


%%
  
copyfile(fullfile(path_help_template_doc, 'user_guide', 'publish_location.txt'), ...
         fullfile(path_help_template, 'user_guide', 'publish_location.txt'));

copyfile(fullfile(path_help_template_doc, 'user_guide', 'NOTinXML.txt'), ...
         fullfile(path_help_template, 'user_guide', 'NOTinXML.txt'));       

copyfile(fullfile(path_help_template_doc, 'user_guide', 'InPath.txt'), ...
         fullfile(path_help_template, 'user_guide', 'InPath.txt'));

%%

%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
% MAKE userguide.xml

userguide= [{'<!-- this file is finished -->'}, ...
            {'<!-- it is autogenerated by the function make_user_guide.m -->'}, ...
            {'<!-- generate the file user_guide_index.html'}, ...
            {'     out of this file using the file user_guide_index.xsl -->'}, ...
            {'<!-- this file may not have more lines of comments - see make_helptoc.m -->'}, ...
            {'<toc version="2.0">'}, ...
            {'<tocitem target="user_guide_index.html"'}, ...
            {'         image= "$toolbox/matlab/icons/help_ug.png">'}, ...
            {'  User Guide'}];

%% TODO
% eigentlich m�sste hier der Ordner path_help_tool durchsucht werden
% in der schleife m�sste der ordner durchgegangen werden
% wird momentan nicht da die �berschriften in dem ordner der template
% dateien noch nicht richtig sind, diese liegen aktuell in template_doc

user_files= ls(fullfile(path_help_template_doc, 'user_guide', filesep, '*.m'));

%%

for ifile= 1:size(user_files, 1)
  
  %%
  
  myfile= regexp(user_files(ifile,:), '\.', 'split');
  myfile= myfile{1,1};
  
  %% TODO - this is temporary
  
  myfile= strrep(myfile, 'tool_template', toolbox_id);
  
  %%
  
  userguide= [userguide, ...
    {sprintf('<tocitem target="user_guide/%s.html"', myfile)}, ...
            {'         image= "$toolbox/matlab/icons/pagesicon.gif">'}, ...
            {getHeaderOfMFile(fullfile(path_help_template_doc, 'user_guide', ...
                              strtrim(user_files(ifile,:))))}, ...
            {'</tocitem>'}];
  
  %%
  
end
          
%%

userguide= [userguide, {'</tocitem>'}, ...
                       {'</toc>'}];

%%

if ~exist( fullfile(path_doc_tool, 'templates', 'help'), 'dir' )
  mkdir(fullfile(path_doc_tool, 'templates', 'help'));
end

if ~exist( fullfile(path_doc_tool, 'templates', 'help', 'tool_template'), 'dir' )
  mkdir(fullfile(path_doc_tool, 'templates', 'help', 'tool_template'));
end

cell2file(fullfile(path_doc_tool, 'templates', 'help', ...
                   'tool_template', 'userguide.xml'), userguide);

%%


