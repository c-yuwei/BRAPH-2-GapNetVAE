%EXAMPLE_ST_WU
% Script example pipeline ST WU

clear variables %#ok<*NASGU>

%% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('example_ST_WU')) filesep 'example data ST (MRI)' filesep 'destrieux_atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

%% Load Groups of SubjectST
im_gr1 = ImporterGroupSubjectST_XLS( ...
    'FILE', [fileparts(which('example_ST_WU')) filesep 'example data ST (MRI)' filesep 'xls' filesep 'ST_group1.xlsx'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr1 = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectST_XLS( ...
    'FILE', [fileparts(which('example_ST_WU')) filesep 'example data ST (MRI)' filesep 'xls' filesep 'ST_group2.xlsx'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr2 = im_gr2.get('GR');

%% Analysis ST WU
a_PREV1 = AnalyzeGroup_ST_Preview('GR', gr1);
a_PREV2 = AnalyzeGroup_ST_Preview('GR', gr2);

% measure calculation
g_WU1 = a_PREV1.get('G');
preview_WU1 = g_WU1.getMeasure('Preview').get('M');
mean_prev_1 = a_PREV1.get('AVERAGE');
std_preve_1 = a_PREV1.get('STD');

g_WU2 = a_PREV2.get('G');
preview_WU2 = g_WU2.getMeasure('Preview').get('M');
mean_prev_2 = a_PREV2.get('AVERAGE');
std_preve_2 = a_PREV2.get('STD');

% comparison
c_WU = CompareGroup( ...
    'P', 10, ...
    'A1', a_PREV1, ...
    'A2', a_PREV2, ...
    'WAITBAR', true, ...
    'VERBOSE', false, ...
    'MEMORIZE', true ...
    );

preview_WU_diff = c_WU.getComparison('Preview').get('DIFF');
preview_WU_p1 = c_WU.getComparison('Preview').get('P1');
preview_WU_p2 = c_WU.getComparison('Preview').get('P2');
preview_WU_cil = c_WU.getComparison('Preview').get('CIL');
preview_WU_ciu = c_WU.getComparison('Preview').get('CIU');