%% ¡header!
NNRegressorData_ST < NNRegressorData (nnd, data of a neural network regressor with structural data) produces a dataset to train or test a neural netowrk regressor using structural data. 

%% ¡description!
This dataset produces NN groups with structural data.
The dataset produces NN groups for trianing or testing a neurla network
with structural data. 

%% ¡props_update!

%%% ¡prop!
GR (data, item) is a group of subjects defined as SubjectST class.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectST')

%%% ¡prop!
INPUT_TYPE (data, option) is the input type for training or testing the NN.
%%%% ¡default!
'structural_data'

%%% ¡prop!
GR_NN (result, group) is a group of NN subjects.
%%%% ¡settings!
'NNGroup'
%%%% ¡default!
NNGroup('SUB_CLASS', 'NNSubject', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'NNSubject'))
%%%% ¡calculate!
gr = nnd.get('GR1');
nn_gr = NNGroup( ...
    'SUB_CLASS', 'NNSubject', ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'NNSubject') ...
    );

nn_gr.lock('SUB_CLASS');

nn_gr.set( ...
    'ID', gr.get('ID'), ...
    'LABEL', gr.get('LABEL'), ...
    'NOTES', gr.get('NOTES') ...
    );

atlas = BrainAtlas();
if ~isempty(gr) && ~isa(gr, 'NoValue') && gr.get('SUB_DICT').length > 0 
    atlas = gr.get('SUB_DICT').getItem(1).get('BA');
end

nn_sub_dict = nn_gr.get('SUB_DICT');

for i = 1:1:gr.get('SUB_DICT').length()
	input = gr.get('SUB_DICT').getItem(i);
    nn_sub = NNSubject( ...
        'ID', [sub.get('ID') ' in ' gr.get('ID')], ...
        'BA', atlas, ...
        'age', sub.get('age'), ...
        'sex', sub.get('sex'), ...
        'G', g, ...
        'INPUT', input, ...
        'TARGET', sub.get(nnd.get('TARGET_NAME')) ...
        );
    nn_sub_dict.add(nn_sub);
end
nn_gr.set('sub_dict', nn_sub_dict);

value = nn_gr;

%% ¡tests!
%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
example_NN_ST_Regression