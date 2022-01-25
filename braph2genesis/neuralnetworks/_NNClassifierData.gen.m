%% ¡header!
NNClassifierData < NNData (nnd, data of a neural network classifier) produces a dataset to train or test a neural netowrk classifier.  

%% ¡description!
This dataset can be used to train or test a neural network classifier. 
Feature selection procedure can be implemented.
Instances of this class should not be created. 
Use one of its subclasses instead.

%% ¡props!
%%% ¡prop!
GR_1 (data, item) is the subject group 1.
%%%% ¡settings!
'Group'

%%% ¡prop!
GR_2 (data, item) is the subject group 2.
%%%% ¡settings!
'Group'

%%% ¡prop!
TRAIN_GR_1 (result, item) is the subject group 1 for training set.
%%%% ¡settings!
'Group'
%%%% ¡calculate!
train_gr_1 = Group( ...
    'SUB_CLASS', nnd.get('GR_1').get('SUB_CLASS'), ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'Subject') ...
    );

train_gr_1.set( ...
    'ID', nnd.get('GR_1').get('ID'), ...
    'LABEL', nnd.get('GR_1').get('LABEL'), ...
    'NOTES', nnd.get('GR_1').get('NOTES') ...
    );

subdict = train_gr_1.get('SUB_DICT');
sub = nnd.get('GR_1').get('SUB_DICT').getItems();
selected_idx = setdiff(1:length(sub), nnd.get('TRAIN_VAL_INDEX_GR_1'));
selected_sub = sub(selected_idx);
for i = 1:1:length(selected_sub)
    sub = selected_sub{i};
    subdict.add(sub);
end
train_gr_1.set('SUB_DICT', subdict);

value = train_gr_1;

%%% ¡prop!
TRAIN_GR_2 (result, item) is the subject group 2 for taining set.
%%%% ¡settings!
'Group'
%%%% ¡calculate!
train_gr_2 = Group( ...
    'SUB_CLASS', nnd.get('GR_2').get('SUB_CLASS'), ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'Subject') ...
    );

train_gr_2.set( ...
    'ID', nnd.get('GR_2').get('ID'), ...
    'LABEL', nnd.get('GR_2').get('LABEL'), ...
    'NOTES', nnd.get('GR_2').get('NOTES') ...
    );

subdict = train_gr_2.get('SUB_DICT');
sub = nnd.get('GR_2').get('SUB_DICT').getItems();
selected_idx = setdiff(1:length(sub), nnd.get('TRAIN_VAL_INDEX_GR_2'));
selected_sub = sub(selected_idx);
for i = 1:1:length(selected_sub)
    sub = selected_sub{i};
    subdict.add(sub);
end
train_gr_2.set('SUB_DICT', subdict);

value = train_gr_2;

%%% ¡prop!
VAL_GR_1 (result, item) is the subject group 1 for validation set.
%%%% ¡settings!
'Group'
%%%% ¡calculate!
val_gr_1 = Group( ...
    'SUB_CLASS', nnd.get('GR_1').get('SUB_CLASS'), ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'Subject') ...
    );

val_gr_1.set( ...
    'ID', nnd.get('GR_1').get('ID'), ...
    'LABEL', nnd.get('GR_1').get('LABEL'), ...
    'NOTES', nnd.get('GR_1').get('NOTES') ...
    );

subdict = val_gr_1.get('SUB_DICT');
sub = nnd.get('GR_1').get('SUB_DICT').getItems();
selected_idx = nnd.get('TRAIN_VAL_INDEX_GR_1');
selected_sub = sub(selected_idx);
for i = 1:1:length(selected_sub)
    sub = selected_sub{i};
    subdict.add(sub);
end
val_gr_1.set('SUB_DICT', subdict);

value = val_gr_1;

%%% ¡prop!
VAL_GR_2 (result, item) is the subject group 2 for validation set.
%%%% ¡settings!
'Group'
%%%% ¡calculate!
val_gr_2 = Group( ...
    'SUB_CLASS', nnd.get('GR_2').get('SUB_CLASS'), ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'Subject') ...
    );

val_gr_2.set( ...
    'ID', nnd.get('GR_2').get('ID'), ...
    'LABEL', nnd.get('GR_2').get('LABEL'), ...
    'NOTES', nnd.get('GR_2').get('NOTES') ...
    );

subdict = val_gr_2.get('SUB_DICT');
sub = nnd.get('GR_2').get('SUB_DICT').getItems();
selected_idx = nnd.get('TRAIN_VAL_INDEX_GR_2');
selected_sub = sub(selected_idx);
for i = 1:1:length(selected_sub)
    sub = selected_sub{i};
    subdict.add(sub);
end
val_gr_2.set('SUB_DICT', subdict);

value = val_gr_2;

%%% ¡prop!
TRAIN_VAL_INDEX_GR_1 (data, rvector) is a vector stating which subjects belong to validation set.
%%%% ¡conditioning!
if isa(value, 'double')
    num_val = value * nnd.get('GR_1').get('SUB_DICT').length();
    num_train = nnd.get('GR_1').get('SUB_DICT').length() - num_val;
    value = [ones(1, num_val), zeros(1, num_train)];
    value = value(randperm(length(value)));
    value = find(value == 1);
end
%%%% ¡default!
[]


%%% ¡prop!
TRAIN_VAL_INDEX_GR_2 (data, rvector) is a vector stating which subjects belong to validation set.
%%%% ¡conditioning!
if isa(value, 'double')
    num_val = value * nnd.get('GR_2').get('SUB_DICT').length();
    num_train = nnd.get('GR_2').get('SUB_DICT').length() - num_val;
    value = [ones(1, num_val), zeros(1, num_train)];
    value = value(randperm(length(value)));
    value = find(value == 1);
end
%%%% ¡default!
[]

%%% ¡prop!
FEATURE_DENSITY (parameter, scalar) is the density of selected features.
%%%% ¡default!
0.05

%%% ¡prop!
GIVEN_FEATURE_MASK (data, cell) is a given mask for selected features.

%%% ¡prop!
CALCULATED_FEATURE_MASK (result, cell) is a mask generated with training set for selected features.
%%%% ¡calculate!
density = nnd.get('FEATURE_DENSITY');

adjs_gr_1 = nnd.get('TRAIN_G_DICT_1').getItems();
data_gr_1 = {};
for i = 1:length(adjs_gr_1)
    data_gr_1{end+1} = cell2mat(adjs_gr_1{i}.get('A'));
end

adjs_gr_2 = nnd.get('TRAIN_G_DICT_1').getItems();
data_gr_2 = {};
for i = 1:length(adjs_gr_2)
    data_gr_2{end+1} = cell2mat(adjs_gr_2{i}.get('A'));
end

data = [data_gr_1 data_gr_2];

y = nnd.get('TARGETS');
y = categorical(y{1});
for j = 1:size(data{1},2)
    for k = 1:size(data{1},2)
        data_per_feature = cellfun(@(v)v(j, k), data);
        label = onehotencode(y', 2);
        mask(j, k) = nnd.mutual_information_analysis(data_per_feature, label', 5);
    end
end
[~,idx_all] = sort(mask(:), 'descend');
num_top_idx = floor(density*size(mask,1)*size(mask,2));

value = {idx_all(1:num_top_idx)};

%%% ¡prop!
TRAIN_G_DICT_1 (result, idict) is the graph obtained from subject group 1 in training set.
%%%% ¡settings!
'Graph'

%%% ¡prop!
TRAIN_G_DICT_2 (result, idict) is the graph obtained from subject group 2 in training set.
%%%% ¡settings!
'Graph'

%%% ¡prop!
VAL_G_DICT_1 (result, idict) is the graph obtained from subject group 1 in validation set.
%%%% ¡settings!
'Graph'

%%% ¡prop!
VAL_G_DICT_2 (result, idict) is the graph obtained from subject group 2 in validation set.
%%%% ¡settings!
'Graph'

%%% ¡prop!
INPUTS (result, cell) is the inputs for training or testing a neural network.
%%%% ¡calculate!
value = nnd.input_construction(nnd.memorize('TRAIN_G_DICT_1'), nnd.memorize('TRAIN_G_DICT_2'));

%%% ¡prop!
VAL_INPUTS (result, cell) is the inputs from validation set for testing a neural network.
%%%% ¡calculate!
value = nnd.input_construction(nnd.memorize('VAL_G_DICT_1'), nnd.memorize('VAL_G_DICT_2'));

%%% ¡prop!
TARGETS (result, cell) is the label for the dataset.
%%%% ¡calculate!
y1 = repmat(string(nnd.get('TRAIN_GR_1').get('ID')), nnd.get('TRAIN_GR_1').get('SUB_DICT').length(), 1);
y2 = repmat(string(nnd.get('TRAIN_GR_2').get('ID')), nnd.get('TRAIN_GR_2').get('SUB_DICT').length(), 1);

value = {[y1; y2]'};

%%% ¡prop!
VAL_TARGETS (result, cell) is the label for the validation dataset.
%%%% ¡calculate!
y1 = repmat(string(nnd.get('VAL_GR_1').get('ID')), nnd.get('VAL_GR_1').get('SUB_DICT').length(), 1);
y2 = repmat(string(nnd.get('VAL_GR_2').get('ID')), nnd.get('VAL_GR_2').get('SUB_DICT').length(), 1);

value = {[y1; y2]'};

%%% ¡prop!
label_name (result, cell) is the label names of the classifier
%%%% ¡calculate!
value = unique(nd.get('TARGETS'));

%% ¡methods!
function inputs = input_construction(nnd, g_dict_1, g_dict_2)
    %INPUT_CONSTRUCTION constructs the inputs for neural networks.
    % 
    % INPUTS = INPUT_CONSTRUCTION(NN, G_DICT_1, G_DICT_2) constructs
    %  the input for training or testing neural networks. The connectivity
    %  matrices will firstly extracted from graph dict G_DICT_1 and
    %  G_DICT_2. Then the extracted features will be masked by the feature
    %  mask. The masked features will construct the eventual inputs INPUTS 
    %  for the neural network.
    
    % get the connectivity matrices 
    adjs_gr_1 = g_dict_1.getItems();
    data_gr_1 = {};
    for i = 1:length(adjs_gr_1)
        data_gr_1{end+1} = cell2mat(adjs_gr_1{i}.get('A'));
    end

    adjs_gr_2 = g_dict_2.getItems();
    data_gr_2 = {};
    for i = 1:length(adjs_gr_2)
        data_gr_2{end+1} = cell2mat(adjs_gr_2{i}.get('A'));
    end
    
    data = [data_gr_1 data_gr_2];
    
    % get the feature mask
    if isempty(nnd.get('GIVEN_FEATURE_MASK'))
        mask = nnd.memorize('CALCULATED_FEATURE_MASK');
    else
        mask = nnd.get('GIVEN_FEATURE_MASK');
    end
    
    % construct the input
    if nnd.get('FEATURE_DENSITY') == 1.0
        inputs = cellfun(@(v)v(:), data, 'UniformOutput', false);
    else
        inputs = cellfun(@(v)v(mask{1}), data, 'UniformOutput', false);
    end
    inputs = {cat(2, inputs{:})};
end

function [mutinf] = mutual_information_analysis(nnd, X, Y, n)
    xmin = min(X,[],2);
    xmax = max(X,[],2);
    xrange = (xmax - xmin) / n;
    if xmax - xmin < 1e-4
        mutinf = 0;
        return;
    end
    if size(Y, 1) ~= 1
        probmatr = zeros(n, size(Y, 1));
        for i = 1 : size(X,2)
            dimx = ceil((X(:,i) - xmin) / xrange);
            if dimx < 1
                dimx = 1;
            elseif dimx > n
                dimx = n;
            end
            dimy = find(Y(:,i) == 1);
            probmatr(dimx, dimy) = probmatr(dimx, dimy) + 1;
        end
    else
        ymin = min(Y,[],2);
        ymax = max(Y,[],2);
        yrange = (ymax - ymin) / n;
        probmatr = zeros(n, n);
        for i = 1 : size(X,2)
            dimx = ceil((X(:,i) - xmin) / xrange);
            if dimx < 1
                dimx = 1;
            elseif dimx > n
                dimx = n;
            end
            dimy = ceil((Y(:,i) - ymin) / yrange);
            if dimy < 1
                dimy = 1;
            elseif dimy > n
                dimy = n;
            end
            probmatr(dimx, dimy) = probmatr(dimx, dimy) + 1;
        end
    end
    p_y = sum(probmatr, 1) / size(X,2);
    p_y_x = probmatr ./ (sum(probmatr, 2) + 1e-8);
    p_y(p_y == 0) = 1e-8;
    p_y_x(p_y_x == 0) = 1e-8;
    
    mutinf = sum(sum(probmatr / size(X,2) .* log(p_y_x))) - sum(p_y .* log(p_y));
end