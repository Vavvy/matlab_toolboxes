%% getScriptFileOfFunction
% Returns the script file for the given file or function
%
function script_file= getScriptFileOfFunction(filename)
%% Release: 1.4

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% check arguments

checkArgument(filename, 'filename', 'char', '1st');


%%

% just look inside the last 6 digits
if numel(filename) > 6
  possible_doc= filename(end - 6:end);
else 
  possible_doc= filename;
end

pos= strfind(possible_doc, '_doc');

if ~isempty(pos) % doc found
  pos= strfind(possible_doc, '.m');
  
  if ~isempty(pos) % delete _doc and add file extension
    if numel(filename) > 6
      script_file= [filename(1:end - 6 + pos - 6), '.m'];
    else
      script_file= [filename(1:end - 2), '.m'];
    end
  else
    script_file= [filename(1:end - 4), '.m'];
  end
else
  pos= strfind(possible_doc, '.m');
  
  if isempty(pos) % add file extension
    script_file= [filename, '.m'];
  else % just return given filename
    script_file= filename;
  end
end

%%


