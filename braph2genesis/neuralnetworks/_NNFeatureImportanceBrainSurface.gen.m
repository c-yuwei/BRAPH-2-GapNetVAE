%% ¡header!
NNFeatureImportanceBrainSurface < ConcreteElement (nnfib, neural network feature importace on brain surface) manages the visuazation of the feature importance on the brain surface within neural network evaluators.

%%% ¡description!
A neural network feature importace on brain surface (NNFeatureImportanceBrainSurface) 
 manages the visualization of feature importance within neural network evaluators, particularly on the brain surface.
It handles different types of neural network inputs, including graph data 
 (for visualizng the importance of connections between nodes), measures (for visualizing the importance of nodal measures),
 and the subject data (connectivity data or structural data).

%%% ¡seealso!
NNEvaluator, NNDataPoint_Graph_CLA, NNDataPoint_Measure_REG, NNDataPoint_CON_CLA, NNDataPoint_ST_CLA

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
NNFeatureImportanceBrainSurface.ID
%%%% ¡title!
Feature Importance Brain Surface ID

%%% ¡prop!
%%%% ¡id!
NNFeatureImportanceBrainSurface.LABEL
%%%% ¡title!
Feature Importance Brain Surface LABEL

%%% ¡prop!
%%%% ¡id!
NNFeatureImportanceBrainSurface.BA
%%%% ¡title!
Brain Atlas

%%% ¡prop!
%%%% ¡id!
NNFeatureImportanceBrainSurface.EVALUATOR_LIST
%%%% ¡title!
Neural Network Evaluators

%%% ¡prop!
%%%% ¡id!
NNFeatureImportanceBrainSurface.AV_FEATURE_IMPORTANCE
%%%% ¡title!
Average of Feature Importance

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the element to manage the visuazation of the neural network feature importance on the brain surface.
%%%% ¡default!
'NNFeatureImportanceBrainSurface'

%%% ¡prop!
NAME (constant, string) is the name of the element to manage the visuazation of the neural network feature importance on the brain surface.
%%%% ¡default!
'Neural Network Feature Importace on Brain Surface'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the element to manage the visuazation of the neural network feature importance on the brain surface.
%%%% ¡default!
'A neural network feature importace on brain surface (NNFeatureImportanceBrainSurface) manages the visualization of feature importance within neural network evaluators, particularly on the brain surface. It handles different types of neural network inputs, including graph data (for visualizng the importance of connections between nodes), measures (for visualizing the importance of nodal measures), and the subject data (connectivity data or structural data).'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the element to manage the visuazation of the neural network feature importance on the brain surface.
%%%% ¡settings!
'NNFeatureImportanceBrainSurface'

%%% ¡prop!
ID (data, string) is a few-letter code of the element to manage the visuazation of the neural network feature importance on the brain surface.
%%%% ¡default!
'NNFeatureImportanceBrainSurface ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the element to manage the visuazation of the neural network feature importance on the brain surface.
%%%% ¡default!
'NNFeatureImportanceBrainSurface label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about managing the visuazation of the neural network feature importance on the brain surface.
%%%% ¡default!
'NNFeatureImportanceBrainSurface notes'
    
%% ¡props!

%%% ¡prop!
BA (data, item) is a brain atlas.
%%%% ¡settings!
'BrainAtlas'

%%% ¡prop!
EVALUATOR_LIST (data, itemlist) contains the evaluators that contain feature importance values.

%%% ¡prop!
AV_FEATURE_IMPORTANCE (result, cell) gets the averaged feature importances from all evaluators.
%%%% ¡calculate!
e_list = nnfib.get('EVALUATOR_LIST');
all_fi = cellfun(@(e) cell2mat(e.get('FEATURE_IMPORTANCE')), ...
    e_list, 'UniformOutput', false);
if isempty(cell2mat(all_fi))
    value = {};
else
    average_fi = zeros(size(all_fi{1}));
    for i = 1:numel(all_fi)
        % Add the current cell contents to the averageCell
        average_fi = average_fi + all_fi{i};
    end
    average_fi = average_fi / numel(all_fi);
    value = {average_fi};
end
%%%% ¡gui!
evaluators = nnfib.get('EVALUATOR_LIST');
input_dataset = evaluators{1}.get('D');
dp_class = input_dataset.get('DP_CLASS');
graph_dp_classes = {NNDataPoint_Graph_CLA().get('NAME'), NNDataPoint_Graph_REG().get('NAME')};
measure_dp_classes = {NNDataPoint_Measure_CLA().get('NAME'), NNDataPoint_Measure_REG().get('NAME')};

if any(strcmp(dp_class, graph_dp_classes)) % GRAPH input
    pr = NNFeatureImportanceBrainSurfacePP_FI_Graph('EL', nnfib, 'D', input_dataset, 'PROP', NNFeatureImportanceBrainSurface.AV_FEATURE_IMPORTANCE, varargin{:});
elseif any(strcmp(dp_class, measure_dp_classes))% MEASURE input
    pr = NNFeatureImportanceBrainSurfacePP_FI_Measure('EL', nnfib, 'D', input_dataset, 'PROP', NNFeatureImportanceBrainSurface.AV_FEATURE_IMPORTANCE, varargin{:});
else % DATA input
    pr = NNFeatureImportanceBrainSurfacePP_FI_Data('EL', nnfib, 'D', input_dataset, 'PROP', NNFeatureImportanceBrainSurface.AV_FEATURE_IMPORTANCE, varargin{:});
end