%% ¡header!
NNClassifierDataSplit < NNDataSplit (nnds, data split for a neural network classifier) split a dataset into training set and validation set for classification.  

%% ¡description!
This NNRegressorDataSplit splits the NN group into two, one for training set,
and the other for validation set. GR_TRAIN and GR_test can be used to train
and test NN classifier. A Feature mask is generated from a feature selection
analysis on training set and applied to validation set. 

%% ¡props!
%%% ¡prop!
GR1 (data, item) is a group of NN subjects.
%%%% ¡settings!
'NNGroup'

%%% ¡prop!
GR2 (data, item) is a group of NN subjects.
%%%% ¡settings!
'NNGroup'

%%% ¡prop!
SPLIT_GR1 (data, rvector) is a ratio or a vector stating which subjects belong to the validation set.
%%%% ¡conditioning!
if length(value) == 1 & value < 1
    num_val = floor(value * nnds.get('GR1').get('SUB_DICT').length());
    num_train = nnds.get('GR1').get('SUB_DICT').length() - num_val;
    value = [ones(1, num_val), zeros(1, num_train)];
    value = value(randperm(length(value)));
    value = find(value == 1);
end

%%% ¡prop!
SPLIT_GR2 (data, rvector) is a ratio or a vector stating which subjects belong to the validation set.
%%%% ¡conditioning!
if length(value) == 1 & value < 1
    num_val = floor(value * nnds.get('GR2').get('SUB_DICT').length());
    num_train = nnds.get('GR2').get('SUB_DICT').length() - num_val;
    value = [ones(1, num_val), zeros(1, num_train)];
    value = value(randperm(length(value)));
    value = find(value == 1);
end

%% ¡props_update!

%%% ¡prop!
GR_TRAIN (result, item) is a group of NN subjects for the training set.
%%%% ¡settings!
'NNGroup'
%%%% ¡calculate!
% init a NNGroup
nnGroup = 'GR1';
train_nn_gr = NNGroup( ...
    'SUB_CLASS', nnds.get(nnGroup).get('SUB_CLASS'), ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'Subject') ...
    );

train_nn_gr.set( ...
    'ID', nnds.get(nnGroup).get('ID'), ...
    'LABEL', nnds.get(nnGroup).get('LABEL'), ...
    'NOTES', nnds.get(nnGroup).get('NOTES') ...
    );

% add subejcts from all groups
sub_dict = train_nn_gr.get('SUB_DICT');

if nnds.get('GR1').get('SUB_DICT').length() > 0
    subs = nnds.get('GR1').get('SUB_DICT').getItems();
    selected_idx = setdiff(1:length(subs), nnds.get('SPLIT_GR1'));
    selected_subs = subs(selected_idx);
    for i = 1:1:length(selected_subs)
        sub = selected_subs{i};
        sub_copy = NNSubject( ...
            'ID', sub.get('ID'), ...
            'LABEL', sub.get('LABEL'), ...
            'NOTES', sub.get('NOTES'),...
            'G', sub.get('G'),...
            'INPUT', sub.get('INPUT'),...
            'FEATURE_MASK', sub.get('FEATURE_MASK'),...
            'TARGET_NAME', sub.get('TARGET_NAME'),...
            'TARGET', sub.get('TARGET'),...
            'PREDICTION', sub.get('PREDICTION'),...
            'BA', sub.get('BA'),...
            'AGE', sub.get('AGE'),...
            'SEX', sub.get('SEX')...
            );
        sub_dict.add(sub_copy);
    end
end

if nnds.get('GR2').get('SUB_DICT').length() > 0
    subs = nnds.get('GR2').get('SUB_DICT').getItems();
    selected_idx = setdiff(1:length(subs), nnds.get('SPLIT_GR2'));
    selected_subs = subs(selected_idx);
    for i = 1:1:length(selected_subs)
        sub = selected_subs{i};
        sub_copy = NNSubject( ...
            'ID', sub.get('ID'), ...
            'LABEL', sub.get('LABEL'), ...
            'NOTES', sub.get('NOTES'),...
            'G', sub.get('G'),...
            'INPUT', sub.get('INPUT'),...
            'FEATURE_MASK', sub.get('FEATURE_MASK'),...
            'TARGET_NAME', sub.get('TARGET_NAME'),...
            'TARGET', sub.get('TARGET'),...
            'PREDICTION', sub.get('PREDICTION'),...
            'BA', sub.get('BA'),...
            'AGE', sub.get('AGE'),...
            'SEX', sub.get('SEX')...
            );
        sub_dict.add(sub_copy);
    end
end

if sub_dict.length() > 0
    target_names = cellfun(@(x) x.get('TARGET_NAME'), sub_dict.getItems(), 'UniformOutput', false);
    targets = onehotencode(categorical(target_names), 1);
    for i = 1:1:sub_dict.length()
        sub_dict.getItem(i).set('TARGET', {targets(:, i)});
    end
end

train_nn_gr.set('SUB_DICT', sub_dict);

value = train_nn_gr;

%%% ¡prop!
GR_VAL (result, item) is a group of NN subjects for the validation set.
%%%% ¡settings!
'NNGroup'
%%%% ¡calculate!
% init a NNGroup
nnGroup = 'GR1';
val_nn_gr = NNGroup( ...
    'SUB_CLASS', nnds.get(nnGroup).get('SUB_CLASS'), ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'Subject') ...
    );

val_nn_gr.set( ...
    'ID', nnds.get(nnGroup).get('ID'), ...
    'LABEL', nnds.get(nnGroup).get('LABEL'), ...
    'NOTES', nnds.get(nnGroup).get('NOTES') ...
    );

% add subejcts from all groups
sub_dict = val_nn_gr.get('SUB_DICT');

if nnds.get('GR1').get('SUB_DICT').length() > 0
    subs = nnds.get('GR1').get('SUB_DICT').getItems();
    selected_idx = nnds.get('SPLIT_GR1');
    selected_subs = subs(selected_idx);
    for i = 1:1:length(selected_subs)
        sub = selected_subs{i};
        sub_copy = NNSubject( ...
            'ID', sub.get('ID'), ...
            'LABEL', sub.get('LABEL'), ...
            'NOTES', sub.get('NOTES'),...
            'G', sub.get('G'),...
            'INPUT', sub.get('INPUT'),...
            'FEATURE_MASK', sub.get('FEATURE_MASK'),...
            'TARGET_NAME', sub.get('TARGET_NAME'),...
            'TARGET', sub.get('TARGET'),...
            'PREDICTION', sub.get('PREDICTION'),...
            'BA', sub.get('BA'),...
            'AGE', sub.get('AGE'),...
            'SEX', sub.get('SEX')...
            );
        sub_dict.add(sub_copy);
    end
end

if nnds.get('GR2').get('SUB_DICT').length() > 0
    subs = nnds.get('GR2').get('SUB_DICT').getItems();
    selected_idx = nnds.get('SPLIT_GR2');
    selected_subs = subs(selected_idx);
    for i = 1:1:length(selected_subs)
        sub = selected_subs{i};
        sub_copy = NNSubject( ...
            'ID', sub.get('ID'), ...
            'LABEL', sub.get('LABEL'), ...
            'NOTES', sub.get('NOTES'),...
            'G', sub.get('G'),...
            'INPUT', sub.get('INPUT'),...
            'FEATURE_MASK', sub.get('FEATURE_MASK'),...
            'TARGET_NAME', sub.get('TARGET_NAME'),...
            'TARGET', sub.get('TARGET'),...
            'PREDICTION', sub.get('PREDICTION'),...
            'BA', sub.get('BA'),...
            'AGE', sub.get('AGE'),...
            'SEX', sub.get('SEX')...
            );
        sub_dict.add(sub_copy);
    end
end

if sub_dict.length() > 0
    target_names = cellfun(@(x) x.get('TARGET_NAME'), sub_dict.getItems(), 'UniformOutput', false);
    targets = onehotencode(categorical(target_names), 1);
    for i = 1:1:sub_dict.length()
        sub_dict.getItem(i).set('TARGET', {targets(:, i)});
    end
end

val_nn_gr.set('SUB_DICT', sub_dict);

value = val_nn_gr;

%%% ¡prop!
FEATURE_SELECTION_ANALYSIS (result, cell) is an analysis for generating a feature mask.
%%%% ¡calculate!
percentile = cell2mat(nnds.get('FEATURE_MASK'));
data = cellfun(@(x) x.get('INPUT'), nnds.get('GR_TRAIN').get('SUB_DICT').getItems(), 'UniformOutput', false);

if nnds.get('GR_TRAIN').get('SUB_DICT').length == 0
    value = {};
else
    y = cellfun(@(x) cell2mat(x.get('TARGET')), nnds.get('GR_TRAIN').get('SUB_DICT').getItems(), 'UniformOutput', false);
    y = cell2mat(y);
    label = y(1, :);
    num_feature_cluster = length(data{1});
    value = cell(size(data{1}));
    for k = 1:1:num_feature_cluster
        data_per_cluster = cellfun(@(v)v{k}, data, 'UniformOutput', false);
        mask = zeros(size(data_per_cluster{k}));
        if ~isempty(mask)
            for i = 1:numel(mask)
                data_per_feature = cellfun(@(v)v(i), data_per_cluster);
                if(any(isinf(data_per_feature)))
                    mask(i) = 0;
                else
                    mask(i) = nnds.mutual_information_analysis(data_per_feature, label, 5);
                end
            end

            [~, idx_all] = sort(mask(:), 'descend');
            num_top_idx = ceil(percentile * numel(mask));
            mask(idx_all(1:num_top_idx)) = 1;
            mask(idx_all(num_top_idx:end)) = 0;
        end
        value{k} = mask;
    end
end

%%% ¡prop!
GR_TRAIN_FS (result, item) is a group of NN subjects with feature mask for the training set.
%%%% ¡settings!
'NNGroup'
%%%% ¡default!
NNGroup('SUB_CLASS', 'NNSubject', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'NNSubject'))
%%%% ¡calculate!
nn_gr_copy = nnds.memorize('GR_TRAIN');
feature_mask = nnds.get('FEATURE_MASK');
if length(feature_mask) == 1 && length(cell2mat(feature_mask(1))) == 1 % given percentile
    feature_mask = nnds.memorize('FEATURE_SELECTION_ANALYSIS');
end

if isempty(feature_mask)
    value = NNGroup();
else
    for i = 1:1:nn_gr_copy.get('SUB_DICT').length()
        nn_gr_copy.get('SUB_DICT').getItem(i).set('FEATURE_MASK', feature_mask);
    end
    value = nn_gr_copy;
end

%%% ¡prop!
GR_VAL_FS (result, item) is a group of NN subjects with feature mask for the validation set.
%%%% ¡settings!
'NNGroup'
%%%% ¡default!
NNGroup('SUB_CLASS', 'NNSubject', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'NNSubject'))
%%%% ¡calculate!
nn_gr_copy = nnds.memorize('GR_VAL');
feature_mask = nnds.get('FEATURE_MASK');
if length(feature_mask) == 1 && length(cell2mat(feature_mask(1))) == 1 % given percentile
    feature_mask = nnds.memorize('FEATURE_SELECTION_ANALYSIS');
end

if isempty(feature_mask)
    value = NNGroup();
else
    for i = 1:1:nn_gr_copy.get('SUB_DICT').length()
        nn_gr_copy.get('SUB_DICT').getItem(i).set('FEATURE_MASK', feature_mask);
    end
    value = nn_gr_copy;
end