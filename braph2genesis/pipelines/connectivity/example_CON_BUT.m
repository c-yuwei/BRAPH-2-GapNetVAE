%EXAMPLE_CON_BUT
% Script example pipeline ST CON BUT

clear variables %#ok<*NASGU>

%% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('example_CON_BUT')) filesep 'example data CON (DTI)' filesep 'desikan_atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

%% Load Groups of SubjectCON
im_gr1 = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [fileparts(which('example_CON_BUT')) filesep 'example data CON (DTI)' filesep 'xls' filesep 'GroupName1'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr1 = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [fileparts(which('example_CON_BUT')) filesep 'example data CON (DTI)' filesep 'xls' filesep 'GroupName2'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr2 = im_gr2.get('GR');

%% Analysis CON WU
thresholds = 0:.2:1;

a_BUT1 = AnalyzeEnsemble_CON_BUT( ...
    'GR', gr1, ...
    'Thresholds', thresholds ...
    );

a_BUT2 = AnalyzeEnsemble_CON_BUT( ...
    'GR', gr2 , ...
    'Thresholds', thresholds ...
    );

% measure calculation
degree_BUT1 = a_BUT1.getMeasureEnsemble('Degree').get('M');
degree_av_BUT1 = a_BUT1.getMeasureEnsemble('DegreeAv').get('M');
distance_BUT1 = a_BUT1.getMeasureEnsemble('Distance').get('M');

degree_BUT2 = a_BUT2.getMeasureEnsemble('Degree').get('M');
degree_av_BUT2 = a_BUT2.getMeasureEnsemble('DegreeAv').get('M');
distance_BUT2 = a_BUT2.getMeasureEnsemble('Distance').get('M');

% comparison
c_BUT = CompareEnsemble( ...
    'P', 10, ...
    'A1', a_BUT1, ...
    'A2', a_BUT2, ...
    'WAITBAR', true, ...
    'VERBOSE', false, ...
    'MEMORIZE', true ...
    );

degree_BUT_diff = c_BUT.getComparison('Degree').get('DIFF');
degree_BUT_p1 = c_BUT.getComparison('Degree').get('P1');
degree_BUT_p2 = c_BUT.getComparison('Degree').get('P2');
degree_BUT_cil = c_BUT.getComparison('Degree').get('CIL');
degree_BUT_ciu = c_BUT.getComparison('Degree').get('CIU');

degree_av_BUT_diff = c_BUT.getComparison('DegreeAv').get('DIFF');
degree_av_BUT_p1 = c_BUT.getComparison('DegreeAv').get('P1');
degree_av_BUT_p2 = c_BUT.getComparison('DegreeAv').get('P2');
degree_av_BUT_cil = c_BUT.getComparison('DegreeAv').get('CIL');
degree_av_BUT_ciu = c_BUT.getComparison('DegreeAv').get('CIU');

distance_BUT_diff = c_BUT.getComparison('Distance').get('DIFF');
distance_BUT_p1 = c_BUT.getComparison('Distance').get('P1');
distance_BUT_p2 = c_BUT.getComparison('Distance').get('P2');
distance_BUT_cil = c_BUT.getComparison('Distance').get('CIL');
distance_BUT_ciu = c_BUT.getComparison('Distance').get('CIU');