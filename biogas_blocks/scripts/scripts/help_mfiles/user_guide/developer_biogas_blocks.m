%%
% # entwicklung eines bhkw blocks mit dynamischer bestimmung des
% wirkungsgrads in abh�ngigkeit der auslastung.
% # entwicklung eines blocks anmaischgrube (mit/ohne Heizung)
% # bei ADM1: reduzierung der substratzufuhr und hochskalieren der
% konzentration um massebilanz einzuhalten
% # pumpblock in substratzufuhrblock einf�gen um energieverbrauch der
% substratzufuhr berechnen zu k�nnen
% # html Ordener und unterordner m�ssen in matlab pfad sein, wg. hilfe zu
% biogas bl�cken
% # der endlager block k�nnte auch das ADM1 beinhalten, da im endlager auch
% biogas entsteht, bzw. �berdachtes/un�berdachtes endlager. Zustandsvektor
% wird dadurch allerdings gr��er. D.h. offenes endlager wie bisher,
% geschlossenes als adm1 modellieren
% # Entwicklung eines blocks silo: erh�ht den s�uregehalt des substrats
% unter beibehaltung des gesamten csbs. passiert im silo teilweise auch
% disintegration, hydrolyse? ist wichtig bei der kalibrierung, da �ber
% kalibrierungszeitraum die gef�tterte maissilage eine andere ist als wie
% am ende des zeitraums. 
%
%%
% # To make and publish the toolbox call:
%
% |make_toolbox('biogas_blocks', 'GECO-C Blocks for Biogas MATLAB Tool', '1.0',
% 'H:\wissMitarbeiter\matlab_toolboxes\biogas_blocks\trunk')| 
%
% and
%
% |publish_toolbox(biogas_blocks)|
%


