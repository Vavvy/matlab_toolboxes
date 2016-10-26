%%
% # To make and publish the toolbox call:
%
% |make_toolbox('biogas_ml', 'GECO-C Machine Learning for Biogas MATLAB Tool', '1.0',
% 'H:\wissMitarbeiter\matlab_toolboxes\biogas_ml\trunk')| 
%
% and
%
% |publish_toolbox(biogas_ml)|
%
%% Further Topics
% 
%% State Estimation/Prediction
% # Mit Hilfe des State Estimators k�nnte man ein model-based outlier
% detection Algorithmus entwickeln. Wenn die Prediktion mit einem Messwert
% nicht �bereinstimmt (3 sigma Regel), dann d�rfte der aktuelle Messwert
% ein Outlier sein.
% Zwei Varianten sind m�glich:
%
% # Entweder man startet eine Simulation mit dem normalen Modell vom
% zuletzt gesch�tzten Zustand uns vergleicht dann Mess- mit
% Simulationswert. 
% # oder man sch�tzt den neuen Zustand mit dem neuen Messwert. Falls
% Komponenten im Zustandsvektor ausreissen (wiederum 3 sigma Regel zu
% fr�heren Sch�tzungen), dann ist Messwert ein Ausreisser. 
%
%%
% # Lernen des State Estimators / Abbruchkriterium
%
% Zur Bestimmung wieviele Trainings-/Test-Daten durch Simulation generiert
% werden m�ssen bevor das Modell des State Estimators genommen wird, kann
% wie folgt vorgegangen werden:
%
% * Man erzeugt Trainings-/Test-Daten mit dem kalibrierten Modell durch
% Simulation
% * Trainieren und validieren des State Estimators
% * Falls Validierungsergebnisse nicht gut sind, dann m�ssen weitere Daten
% generiert werden und Lernen/Validieren wiederholt werden.
% * Sobald Validierungsergebnisse gut sind, kann das Modell f�r die
% Zustandssch�tzung genutzt werden.
%


