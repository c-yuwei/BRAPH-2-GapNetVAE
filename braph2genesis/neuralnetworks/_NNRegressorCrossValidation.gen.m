%% ¡header!
NNRegressorCrossValidation < Element (nncv, cross-validation for neural network regressor) cross-validate the performance of neural network regressors with a dataset.

%% ¡description!
This cross validation perform a k-fold cross validation of neural network
regressor with desired repetitions on a dataset. The dataset is split into
k consecutive folds with shuffling by default, and each fold is then used 
once as a validation while the k-1 remaining folds from the training set. 
The root-mean square error is calculated across folds and repetitions.

%% ¡props!
%%% ¡prop!
KFOLD (data, scalar) is the number of folds.
%%%% ¡default!
5

%%% ¡prop!
REPETITION (data, scalar) is the number of repetitions.
%%%% ¡default!
1

%%% ¡prop!
GR (data, item) is is a group of subjects.
%%%% ¡settings!
'NNGroup'

%%% ¡prop!
FEATURE_MASK (data, cell) is a given mask or a percentile to select relevant features.
%%%% ¡default!
num2cell(0.05)
%%%% ¡conditioning!
if ~iscell(value) & isnumeric(value)
    value = num2cell(value);
end

%%% ¡prop!
SPLIT_KFOLD (result, cell) is a vector stating which subjects belong to each fold.
%%%% ¡calculate!
num_per_class = nncv.get('GR').get('SUB_DICT').length;
kfold = nncv.get('KFOLD');
shuffle_indexes = randperm(num_per_class, num_per_class);
num_per_fold = floor(num_per_class / kfold);
r_times = rem(num_per_class, kfold);
r = zeros(1, kfold);
r(randperm(kfold, r_times)) = 1;
jend = 0;
for j = 1:kfold
    jstart = jend + 1;
    if j == kfold
        index_kfold{j} = shuffle_indexes(jend+1:end);
    else
        jend = jend + num_per_fold + r(j);
        index_kfold{j} = shuffle_indexes(jstart:jend);
    end
end

value = index_kfold;

%%% ¡prop!
NNDS_DICT (result, idict) contains the NN data splits for k folds across repetitions.
%%%% ¡settings!
'NNRegressorDataSplit'
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'NNRegressorDataSplit')
%%%% ¡calculate!
nnds_dict = IndexedDictionary('IT_CLASS', 'NNRegressorDataSplit');
if ~isa(nncv.get('GR').getr('SUB_DICT'), 'NoValue')
    for i = 1:1:nncv.get('REPETITION')
        idx_per_fold = nncv.get('SPLIT_KFOLD');
        for j = 1:1:nncv.get('KFOLD')
            nnds = NNRegressorDataSplit( ...
                'ID', ['kfold ', num2str(j), ' repetition ', num2str(i)], ...
                'GR', nncv.get('GR'), ...
                'SPLIT', idx_per_fold{j}, ...
                'FEATURE_MASK', nncv.get('FEATURE_MASK') ...
                );

            nnds.memorize('GR_VAL_FS');
            nnds.memorize('GR_TRAIN_FS');

            nnds_dict.add(nnds)
        end
    end
end

value = nnds_dict;

%%% ¡prop!
NN_DICT (result, idict) contains the NN regressors for k folds for all repetitions.
%%%% ¡settings!
'NNRegressorDNN'
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'NNRegressorDNN')
%%%% ¡calculate!
nn_dict = IndexedDictionary('IT_CLASS', 'NNRegressorDNN');
if nncv.memorize('NNDS_DICT').length() > 0
    for i = 1:1:nncv.get('NNDS_DICT').length()
        nnds = nncv.get('NNDS_DICT').getItem(i);
        gr_train = nnds.get('GR_TRAIN_FS');

        nn = NNRegressorDNN( ...
                'ID', nnds.get('ID'), ...
                'GR', gr_train, ...
                'VERBOSE', false, ...
                'SHUFFLE', 'every-epoch' ...
                );
            
        nn_dict.add(nn)
    end
end

value = nn_dict;

%%% ¡prop!
NNE_DICT (result, idict) contains the NN evaluators for k folds for all repetitions.
%%%% ¡settings!
'NNRegressorEvaluator'
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'NNRegressorEvaluator')
%%%% ¡calculate!
nne_dict = IndexedDictionary('IT_CLASS', 'NNRegressorEvaluator');
if nncv.memorize('NN_DICT').length() > 0
    for i = 1:1:nncv.get('NN_DICT').length()
        nn = nncv.get('NN_DICT').getItem(i);
        nnds = nncv.get('NNDS_DICT').getItem(i);
        gr_val = nnds.get('GR_VAL_FS');

        nne = NNRegressorEvaluator( ...
                'ID', nn.get('ID'), ...
                'GR', gr_val, ...
                'NN', nn ...
                );
            
        nne_dict.add(nne)
    end
end

value = nne_dict;

%%% ¡prop!
GR_PREDICTION (result, item) is a group of NN subjects with prediction from NN.
%%%% ¡settings!
'NNGroup'
%%%% ¡calculate!
if nncv.memorize('NNE_DICT').length() > 0
    gr = nncv.get('NNE_DICT').getItem(1).get('GR_PREDICTION');
    gr_prediction = NNGroup( ...
        'ID', gr.get('ID'), ...
        'LABEL', gr.get('LABEL'), ...
        'NOTES', gr.get('NOTES'), ...
        'SUB_CLASS', gr.get('SUB_CLASS'), ...
        'SUB_DICT', IndexedDictionary('IT_CLASS', 'NNSubject') ...
        );

    % add subejcts from NNE_DICT
    sub_dict = gr_prediction.get('SUB_DICT');

    for i = 1:1:nncv.memorize('NNE_DICT').length()
        nne = nncv.memorize('NNE_DICT').getItem(i);
        for j = 1:1:nne.memorize('GR_PREDICTION').get('SUB_DICT').length()
            sub = nne.memorize('GR_PREDICTION').get('SUB_DICT').getItem(j);
            sub_dict.add(sub);
        end
    end

    gr_prediction.set('SUB_DICT', sub_dict);
else
    gr_prediction = NNGroup();
end

value = gr_prediction;

%%% ¡prop!
RMSE (result, scalar) is the root mean squared error between targets and predictions across k folds for all repeitions.
%%%% ¡calculate!
if nncv.memorize('GR_PREDICTION').get('SUB_DICT').length() == 0
    value = 0;
else
    preds = cellfun(@(x) cell2mat(x.get('PREDICTION'))', nncv.memorize('GR_PREDICTION').get('SUB_DICT').getItems(), 'UniformOutput', false);
    preds = cell2mat(preds);
    targets = cellfun(@(x) cell2mat(x.get('TARGET')), nncv.get('GR_PREDICTION').get('SUB_DICT').getItems(), 'UniformOutput', false);
    targets = cell2mat(targets);
    value = sqrt(mean((preds - targets).^2));
end

%%% ¡prop!
CONTRIBUTION_MAP (result, matrix) is a heat map obtained with feature selection analysis and the AUC value.
%%%% ¡calculate!
nne_dict = nncv.memorize('NNE_DICT');
heat_map = 0;
if ~isempty(nne_dict.getItems()) && ~isempty(nne_dict.getItem(1).get('VAL_AUC'))
    for i = 1:1:nne_dict.length()
        feature_map = nne_dict.getItem(i).get('GR_PREDICTION').get('SUB_DICT').getItem(1).get('FEATURE_MASK');
        auc_val = nne_dict.getItem(i).get('AUC');
        feature_map(feature_map == 1) = auc_val{1};
        heat_map = heat_map + feature_map;
    end
    heat_map = heat_map / nne_dict.length();
    if nncv.get('PLOT_MAP')
        figure
        x = [1 size(heat_map, 2)];
        y = [0 size(heat_map, 1)];
        image(x, y, heat_map, 'CDataMapping', 'scaled')
        if string(nne_dict.getItem(i).get('NNData').get('INPUT_TYPE')) == 'graph_measures'
            ticklabel = nncv.get('MEASURES');
            fontsize = 12;
        else
            ticklabel = 0:size(heat_map, 2);
            fontsize = 5;
        end
        xticks([1:size(heat_map, 2)]);
        yticks([1:size(heat_map, 1)]);
    	xticklabels(ticklabel);
        yticklabels(0:size(heat_map, 1));
        a = get(gca,'XTickLabel');
        set(gca, 'XTickLabel', a, 'fontsize', fontsize, 'FontWeight', 'bold')
        a = get(gca,'YTickLabel');
        set(gca, 'YTickLabel', a, 'fontsize', fontsize, 'FontWeight', 'bold')
        colorbar
        directory = [fileparts(which('test_braph2')) filesep 'NN_saved_figures'];
        if ~exist(directory, 'dir')
            mkdir(directory)
        end
        filename = [directory filesep 'cv_contribution_map.svg'];
        saveas(gcf, filename);
    end

    value = heat_map;
else
    value = heat_map;
end

%% ¡methods!
function [avg, CI] = get_CI(nncv, scores)
    %GET_CI calculates the 95% confidence interval.
    % 
    % [AVG, CI] = GET_CI(NNCV, SCORES) calculates the 95% confidence interval
    %  of the input scores which are in a form of rvector. AVG is the mean 
    %  value of the input scores. CI are the upper and lower boundary of
    %  the corresponding 95% confidence interval.

    avg = mean(scores);
    SEM = std(scores)/sqrt(length(scores));               
    ts = tinv([0.025  0.975],length(scores)-1);     
    CI = avg + ts*SEM;
end