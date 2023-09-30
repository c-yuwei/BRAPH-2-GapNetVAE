%% EXAMPLE_NNCV_CON_BUD_CLA
% Script example pipeline for NN classification cross-validation with the input of adjacency marix from GraphBUD with SubjectCON 
clear variables %#ok<*NASGU>

%% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('NNDataPoint_CON_CLA')) filesep 'Example data NN CLA CON XLS' filesep 'atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

%% Load Groups of SubjectCON
im_gr1 = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [fileparts(which('NNDataPoint_CON_CLA')) filesep 'Example data NN CLA CON XLS' filesep 'CON_Group_1_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr1 = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [fileparts(which('NNDataPoint_CON_CLA')) filesep 'Example data NN CLA CON XLS' filesep 'CON_Group_2_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr2 = im_gr2.get('GR');

im_gr3 = ImporterGroupSubjectCON_XLS( ...
    'DIRECTORY', [fileparts(which('NNDataPoint_CON_CLA')) filesep 'Example data NN CLA CON XLS' filesep 'CON_Group_3_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr3 = im_gr3.get('GR');

%% Analysis CON WU
densities = 5;
graph_temp = MultigraphBUD('DENSITIES', densities);
a_BUD1 = AnalyzeEnsemble_CON_BUD( ...
    'GRAPH_TEMPLATE', graph_temp, ...
    'GR', gr1 ...
    );

a_BUD2 = AnalyzeEnsemble_CON_BUD( ...
    'TEMPLATE', a_BUD1, ...
    'GR', gr2 ...
    );

a_BUD3 = AnalyzeEnsemble_CON_BUD( ...
    'TEMPLATE', a_BUD1, ...
    'GR', gr3 ...
    );

a_BUD1.memorize('G_DICT');
a_BUD2.memorize('G_DICT');
a_BUD3.memorize('G_DICT');

%% Create NNData composed of corresponding NNDataPoints
% create item lists of NNDataPoint_Graph_CLA
it_list1 = cellfun(@(x) NNDataPoint_Graph_CLA( ...
    'ID', x.get('ID'), ...
    'G', x, ...
    'TARGET_IDS', {gr1.get('ID')}), ...
    a_BUD1.get('G_DICT').get('IT_LIST'), ...
    'UniformOutput', false);

it_list2 = cellfun(@(x) NNDataPoint_Graph_CLA( ...
    'ID', x.get('ID'), ...
    'G', x, ...
    'TARGET_IDS', {gr2.get('ID')}), ...
    a_BUD2.get('G_DICT').get('IT_LIST'), ...
    'UniformOutput', false);

it_list3 = cellfun(@(x) NNDataPoint_Graph_CLA( ...
    'ID', x.get('ID'), ...
    'G', x, ...
    'TARGET_IDS', {gr3.get('ID')}), ...
    a_BUD3.get('G_DICT').get('IT_LIST'), ...
    'UniformOutput', false);

% create NNDataPoint_Graph_CLA DICT items
it_class = 'NNDataPoint_Graph_CLA';
dp_list1 = IndexedDictionary(...
        'IT_CLASS', it_class, ...
        'IT_LIST', it_list1 ...
        );

dp_list2 = IndexedDictionary(...
        'IT_CLASS', it_class, ...
        'IT_LIST', it_list2 ...
        );

dp_list3 = IndexedDictionary(...
        'IT_CLASS', it_class, ...
        'IT_LIST', it_list3 ...
        );

% create a NNDataset containing the NNDataPoint_CON_CLA DICT
d1 = NNDataset( ...
    'DP_CLASS', it_class, ...
    'DP_DICT', dp_list1 ...
    );

d2 = NNDataset( ...
    'DP_CLASS', it_class, ...
    'DP_DICT', dp_list2 ...
    );

d3 = NNDataset( ...
    'DP_CLASS', it_class, ...
    'DP_DICT', dp_list3 ...
    );

%% Create a classifier cross-validation
nne_template = NNClassifierMLP_Evaluator('P', 2);
nncv = NNClassifierMLP_CrossValidation('D', {d1, d2, d3}, 'KFOLDS', 2, 'NNEVALUATOR_TEMPLATE', nne_template);
nncv.get('TRAIN');

%% Evaluate the performance
confusion_matrix = nncv.get('C_MATRIX');
av_auc = nncv.get('AV_AUC');
av_macro_auc = nncv.get('AV_MACRO_AUC');
av_fi = nncv.get('AV_FEATURE_IMPORTANCE');