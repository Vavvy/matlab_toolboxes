%% Further ideas for GUIs
% # GUI zur Angabe von Datens�tzen, welche f�r eine Kalibrierung genutzt
% werden. Bspw. Angabe von Messgr��e, Datenquelle (Datenbank, Excel, ...),
% Messort, so dass automatisch die daten eingelesen werden und
% reference.mat dateien erstellt werden, welche in einem reference ordner
% abgelegt werden. f�r den Ordner wird dann automatisch ein m-skript
% erzeugt, welche die fitnessfunktion f�r die kalibrierung abbildet. s.
% Bild auf blatt papier
% # GUI um Simulationsergebnisse aus sensr objekt zu holen und zu plotten.
% s. blatt papier
% # entwicklung einer GUI f�r ein betriebstagebuch wo man probe/werte f�r
% substrate und fermenterproben eingeben kann (substrate werden hier
% ebenfalls definiert), speicherung der daten direkt 
% in postgreSQL Datenbank. export funktionen zu substrate.xml und *.mat
% Dateien f�r fitnessfunktion (kalibrierung (�berlappt sich deshalb mit 1.
% idee oben)), entwicklung der gui am einfachsten in matlab, gui kann auch
% in c# geschrieben werden, dann import in matlab. darstellung der daten
% �ber stateviewer. diese gui soll auch von BGA betrieber genutzt werden,
% dann zentrale speicherung der daten auf datenbank server. k�nnte auch in
% labview entwickelt werden.
% # gui_optimization sollte beim Start fitness_params.mat Datei auslesen
% und manurebonus checkbox, sowie max TS setzen.
% # bei gui_substrate gibt es ein Problem mit TS oTS und CSB. hier k�nnen
% alle 3 parameter angegeben werden, obwohl diese teilweise voneinander
% abh�ngig sind. CSB= f(TS, oTS)
% 
%
%%
% # To make and publish the toolbox call:
%
% |make_toolbox('biogas_gui', 'GECO-C GUI for Biogas MATLAB Tool', '1.0',
% 'H:\wissMitarbeiter\matlab_toolboxes\biogas_gui\trunk')| 
%
% and
%
% |publish_toolbox(biogas_gui)|
%


