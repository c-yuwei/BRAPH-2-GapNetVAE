%EXAMPLE_ST
% Script example workflow ST

clear variables %#ok<*NASGU>

%% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS('FILE', [fileparts(which('example_ST')) filesep 'example data ST (MRI)' filesep 'desikan_atlas.xlsx']);

ba = im_ba.get('BA');

%% Load Groups of SubjectST
im_gr1 = ImporterGroupSubjectSTXLS( ...
    'FILE', [fileparts(which('example_ST')) filesep 'example data ST (MRI)' filesep 'xls' filesep 'ST_group1.xlsx'], ...
    'BA', ba ...
    );

gr1 = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectSTXLS( ...
    'FILE', [fileparts(which('example_ST')) filesep 'example data ST (MRI)' filesep 'xls' filesep 'ST_group2.xlsx'], ...
    'BA', ba ...
    );

gr2 = im_gr2.get('GR');

%% Analysis WU
a_WU1 = AnalysisST( ...
    'G_CLASS', 'GraphWU', ...
    'GR', gr1 ...
    );

a_WU2 = AnalysisST( ...
    'G_CLASS', 'GraphWU', ...
    'GR', gr2 ...
    );

% measure calculation
g_WU1 = a_WU1.get('G');
degree_WU1 = g_WU1.getMeasure('Degree').get('M');
degree_av_WU1 = g_WU1.getMeasure('DegreeAv').get('M');
distance_WU1 = g_WU1.getMeasure('Distance').get('M');

g_WU2 = a_WU2.get('G');
degree_WU1 = g_WU2.getMeasure('Degree').get('M');
degree_av_WU1 = g_WU2.getMeasure('DegreeAv').get('M');
distance_WU1 = g_WU2.getMeasure('Distance').get('M');

% % comparison
% c_WU = Comparison( ...
%     'P', 10, ...
%     'A1', a_WU1, ...
%     'A2', a_WU2 ...
%     );
% 
% [degree_WU_p1, degree_WU_p2] = c_WU.getComparison('Degree', 'verbose', true);
% [degree_av_WU_p1, degree_av_WU_p2] = c_WU.getComparison('DegreeAv', 'verbose', true);
% [distance_WU_p1, distance_WU_p2] = c_WU.getComparison('Distance', 'verbose', true);

%% Analysis BUT
a_BUT1 = AnalysisST( ...
    'G_CLASS', 'MultigraphBUT', ...
    'THRESHOLDS', [0 .1 .5 1], ...
    'GR', gr1 ...
    );

a_BUT2 = AnalysisST( ...
    'G_CLASS', 'MultigraphBUT', ...
    'THRESHOLDS', [0 .1 .5 1], ...
    'GR', gr2 ...
    );

% measure calculation
g_BUT1 = a_BUT1.get('G');
degree_BUT1 = g_BUT1.getMeasure('Degree').get('M');
degree_av_BUT1 = g_BUT1.getMeasure('DegreeAv').get('M');
distance_BUT1 = g_BUT1.getMeasure('Distance').get('M');

g_BUT2 = a_BUT2.get('G');
degree_BUT2 = g_BUT2.getMeasure('Degree').get('M');
degree_av_BUT2 = g_BUT2.getMeasure('DegreeAv').get('M');
distance_BUT2 = g_BUT2.getMeasure('Distance').get('M');

% % comparison
% c_BUT = Comparison( ...
%     'P', 10, ...
%     'A1', a_BUT1, ...
%     'A2', a_BUT2 ...
%     );
% 
% [degree_BUT_p1, degree_BUT_p2] = c_BUT.getComparison('Degree', 'verbose', true);
% [degree_av_BUT_p1, degree_av_BUT_p2] = c_BUT.getComparison('DegreeAv', 'verbose', true);
% [distance_BUT_p1, distance_BUT_p2] = c_BUT.getComparison('Distance', 'verbose', true);

%% Analysis BUD - measure calculation
a_BUD1 = AnalysisST( ...
    'G_CLASS', 'MultigraphBUD', ...
    'DENSITIES', [0 10 50 100], ...
    'GR', gr1 ...
    );

a_BUD2 = AnalysisST( ...
    'G_CLASS', 'MultigraphBUD', ...
    'DENSITIES', [0 10 50 100], ...
    'GR', gr2 ...
    );

% measure calculation
g_BUD1 = a_BUD1.get('G');
degree_BUD1 = g_BUD1.getMeasure('Degree').get('M');
degree_av_BUD1 = g_BUD1.getMeasure('DegreeAv').get('M');
distance_BUD1 = g_BUD1.getMeasure('Distance').get('M');

g_BUD2 = a_BUD2.get('G');
degree_BUD2 = g_BUD2.getMeasure('Degree').get('M');
degree_av_BUD2 = g_BUD2.getMeasure('DegreeAv').get('M');
distance_BUD2 = g_BUD2.getMeasure('Distance').get('M');

% % comparison
% c_BUD = Comparison( ...
%     'P', 10, ...
%     'A1', a_BUD1, ...
%     'A2', a_BUD2 ...
%     );
% 
% [degree_BUD_p1, degree_BUD_p2] = c_BUD.getComparison('Degree', 'verbose', true);
% [degree_av_BUD_p1, degree_av_BUD_p2] = c_BUD.getComparison('DegreeAv', 'verbose', true);
% [distance_BUD_p1, distance_BUD_p2] = c_BUD.getComparison('Distance', 'verbose', true);