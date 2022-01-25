%% ¡header!
NNClassifierEvaluator < NNEvaluator (nne, evaluator of a neural network classifier) evaluates the performance of a neural network classifier with a specific dataset.

%% ¡description!
This evaluator evaluates the performance of a neural network classifier
in terms of the receiver operating characteristic curve (ROC), the area under the
ROC curve (AUC) and the confusion matrix.

%% ¡props!
%%% ¡prop!
AUC (result, scalar) is an area under the curve score obtained from the dataset.
%%%% ¡calculate!
pred = nne.get('NN_PREDICTION');
targets = nne.get('NN_DATA').get('TARGETS');
classifier = nne.get('NN_MODEL');
net = classifier.to_net(classifier.get('TRAINED_NN'));
class_names = net.Layers(end).Classes; 
[X, Y, T, auc] = perfcurve(categorical(targets{1}), pred(:,2), class_names(2));

value = auc;

%%% ¡prop!
VAL_AUC (result, scalar) is an area under the curve score obtained from the validation set.
%%%% ¡calculate!
pred = nne.get('NN_VAL_PREDICTION');
targets = nne.get('NN_DATA').get('VAL_TARGETS');
classifier = nne.get('NN_MODEL');
net = classifier.to_net(classifier.get('TRAINED_NN'));
class_names = net.Layers(end).Classes; 
[X, Y, T, auc] = perfcurve(categorical(targets{1}), pred(:,2), class_names(2));

value = auc;

%%% ¡prop!
CONFUSION_MATRIX (result, matrix) is a confusion matrix obtained with a cut-off of 0.5.
%%%% ¡calculus!
value = 0

%% ¡props_update!
%%% ¡prop!
NN_DATA (data, item) is a dataset for testing the neural networks.
%%%% ¡settings!
'NNClassifierData'

%%% ¡prop!
NN_PREDICTION (result, matrix) is an output matrix of prediction from a neural network model.
%%%% ¡calculate!
nnd = nne.get('NN_DATA');
classifier = nne.get('NN_MODEL');
net = classifier.to_net(classifier.get('TRAINED_NN'));
inputs = nnd.get('INPUTS');
inputs = inputs{1};
inputs = reshape(inputs, [1, 1, size(inputs,1), size(inputs,2)]);

value = net.predict(inputs);

%%% ¡prop!
NN_VAL_PREDICTION (result, matrix) is an output matrix of prediction for the validation set.
%%%% ¡calculate!
nnd = nne.get('NN_DATA');
classifier = nne.get('NN_MODEL');
net = classifier.to_net(classifier.get('TRAINED_NN'));
inputs = nnd.get('VAL_INPUTS');
inputs = inputs{1};
inputs = reshape(inputs, [1, 1, size(inputs,1), size(inputs,2)]);

value = net.predict(inputs);



