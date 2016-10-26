%% Syntax
%       is_plant(argument, argument_number)
%
%% Description
% |is_plant(argument, argument_number)| checks if the given
% |argument| is an object of the C# class |biogas.plant|. If it is not,
% an error is thrown. The |argument| is the |argument_number| th argument
% of the calling function. 
%
% For more informations about the class |biogas.plant| see
% <matlab:docsearch('Definition,of,plant') here>. 
%
%%
% @param |argument| : The argument that will be checked. Should be an
% object of the C# class |biogas.plant|. 
%
%%
% @param |argument_number| : char with the ordinal number of the given
% argument, so its position in the calling function. Should be in between
% '1st' and '15th'. May also be a positive integer value. If it is, then
% during output a 'th' is appended after the number. 
%
%% Example
% 
% This call is ok

is_plant(biogas.plant(), 4)

%%
% The next call throws an error

try
  is_plant([0 1], '1st')
catch ME
  disp(ME.message)
end

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc script_collection/checkargument">
% script_collection/checkArgument</a>
% </html>
%
% and is called by:
%
% (all functions)
%
%% See Also
% 
% <html>
% <a href="matlab:doc biogas_scripts/is_substrate">
% biogas_scripts/is_substrate</a>
% </html>
% ,
% <html>
% <a href="matlab:doc validateattributes">
% matlab/validateattributes</a>
% </html>
%
%% TODOs
% # create documentation of script file
%
%% <<AuthorTag_DG/>>


