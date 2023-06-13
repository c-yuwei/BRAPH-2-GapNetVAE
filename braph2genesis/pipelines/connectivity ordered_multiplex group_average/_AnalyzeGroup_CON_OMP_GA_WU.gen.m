%% ¡header!
AnalyzeGroup_CON_OMP_GA_WU < AnalyzeGroup (a, graph analysis with connectivity ordinal multiplex data) is a graph analysis using connectivity ordinal multiplex data.

%%% ¡description!
This graph analysis uses connectivity ordinal multiplex data and 
analyzes them using weighted undirected graphs.

%%% ¡seealso!
SubjectCON_MP, OrdMxWU

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the graph analysis with connectivity ordinal multiplex data.
%%%% ¡default!
'AnalyzeGroup_CON_OMP_GA_WU'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the graph analysis with connectivity ordinal multiplex data.
%%%% ¡default!
'This graph analysis uses connectivity ordinal multiplex data and analyzes them using weighted undirected graphs.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the graph analysis with connectivity ordinal multiplex data.

%%% ¡prop!
ID (data, string) is a few-letter code for the graph analysis with connectivity ordinal multiplex data.
%%%% ¡default!
'AnalyzeGroup_CON_OMP_GA_WU ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the graph analysis with connectivity ordinal multiplex data.
%%%% ¡default!
'AnalyzeGroup_CON_OMP_GA_WU label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the graph analysis with connectivity ordinal multiplex data.
%%%% ¡default!
'AnalyzeGroup_CON_OMP_GA_WU notes'

%%% ¡prop!
GR (data, item) is the subject group, which also defines the subject class SubjectCON_MP.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectCON_MP')

%%% ¡prop!
G (result, item) is the average graph (OrdMxWU) obtained from this analysis.
%%%% ¡settings!
'OrdMxWU'
%%%% ¡default!
OrdMxWU()
%%%% ¡calculate!
gr = a.get('GR');
subjects_number = gr.get('SUB_DICT').get('LENGTH');

A_conmp = cell(1, 2);
for i = 1:1:subjects_number
    sub = gr.get('SUB_DICT').get('IT', i);
    CON_MP = sub.getr('CON_MP');
    L = sub.get('L');
    
    for j = 1:1:L
        data = CON_MP{j};
        
        if i == 1
            A_conmp(j) = {data};
        else
            A_conmp(j) = {A_conmp{j} + data};
        end
    end
end

% % % ba = BrainAtlas();
% % % if ~isempty(gr) && ~isa(gr, 'NoValue') && subjects_number > 0
% % %     ba = gr.get('SUB_DICT').get('IT', 1).get('BA');
% % % end

L = length(A_conmp);
g = OrdMxWU( ...
    'ID', ['Graph ' gr.get('ID')], ...
    'B', cellfun(@(a) a/subjects_number, A_conmp, 'UniformOutput', false) ... % % % 'LAYERTICKS', [1:1:L], ... % % % 'LAYERLABELS', cell2str(cellfun(@(x) ['L' num2str(x)], num2cell([1:1:L]), 'UniformOutput', false)), ... % % % 'BAS', ba ...
    );

value = g;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Example
%%%% ¡probability!
.01
%%%% ¡code!
example_CON_OMP_GA_WU