%% ¡header!
ClusteringAv < Clustering (m, average clustering) is the graph average clustering.

%%% ¡description!
The average clustering (ClusteringAv) of a graph is the average of the clustering 
coefficients of all nodes. Connection weights are ignored in calculations.

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
ClusteringAv.ID
%%%% ¡title!
Brain Atlas ID

%%% ¡prop!
%%%% ¡id!
ClusteringAv.LABEL
%%%% ¡title!
Brain Atlas NAME

%%% ¡prop!
%%%% ¡id!
ClusteringAv.BR_DICT
%%%% ¡title!
Brain Regions

%%% ¡prop!
%%%% ¡id!
ClusteringAv.PFBA
%%%% ¡title!
Brain Plot

%%% ¡prop!
%%%% ¡id!
ClusteringAv.NOTES
%%%% ¡title!
Brain Atlas NOTES

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the average clustering.
%%%% ¡default!
'ClusteringAv'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the average clustering.
%%%% ¡default!
'The average clustering (ClusteringAv) of a graph is the average of the clustering coefficients of all nodes. Connection weights are ignored in calculations.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the average clustering.
%%%% ¡settings!
'ClusteringAv'

%%% ¡prop!
ID (data, string) is a few-letter code of the average clustering.
%%%% ¡default!
'ClusteringAv ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the average clustering.
%%%% ¡default!
'ClusteringAv label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the average clustering.
%%%% ¡default!
'ClusteringAv notes'

%%% ¡prop!
SHAPE (constant, scalar) is the measure shape __Measure.GLOBAL__.
%%%% ¡default!
Measure.GLOBAL

%%% ¡prop!
SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.
%%%% ¡default!
Measure.UNILAYER

%%% ¡prop!
PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.
%%%% ¡default!
Measure.NONPARAMETRIC

%%% ¡prop!
COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
%%%% ¡default!
{'GraphWU' 'GraphWD' 'GraphBU' 'GraphBD' 'MultigraphBUD' 'MultigraphBUT' 'MultiplexWU' 'MultiplexWD' 'MultiplexBU' 'MultiplexBUD' 'MultiplexBUT' 'MultiplexBD'} ;%TBE % % % revise and check relative tests

%%% ¡prop!
M (result, cell) is the cell containing the average clustering.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
clustering  = calculateValue@Clustering(m, prop);
layerNumber = g.get('LAYERNUMBER');
clustering_av = cell(layerNumber, 1);
parfor li = 1:1:length(clustering)
    clustering_av(li) = {mean(clustering{li})};
end

value = clustering_av;

%% ¡tests!

%%% ¡excluded_props!
[ClusteringAv.PFM]

%%% ¡test!
%%%% ¡name!
GraphWU
%%%% ¡code!
B_WU = [
    0 .1 .2 .1; 
    1 0 .3 0; 
    .2 .3 0 .4; 
    1 0 .4 0
    ];

clustering_WU = mean([.2741 .3915 .2741 .4309]');
g = GraphWU('B', B_WU);
m_outside_g = ClusteringAv('G', g);
assert(isequal(round(cell2mat(m_outside_g.get('M')), 4), round(clustering_WU, 4)), ...
    [BRAPH2.STR ':ClusteringAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'ClusteringAv');
assert(isequal(round(cell2mat(m_inside_g.get('M')), 4), round(clustering_WU, 4)), ...
    [BRAPH2.STR ':ClusteringAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
GraphWD
%%%% ¡code!
B_WD = [
    0 .1 .2 .1; 
    1 0 .3 0; 
    .2 .4 0 .3; 
    1 0 .4 0
    ];
clustering_WD = mean([.1375 .1621 .1381 .1565]');
g = GraphWD('B', B_WD);
m_outside_g = ClusteringAv('G', g);
assert(isequal(round(cell2mat(m_outside_g.get('M')), 3), round(clustering_WD, 3)), ...
    [BRAPH2.STR ':ClusteringAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'ClusteringAv');
assert(isequal(round(cell2mat(m_inside_g.get('M')), 3), round(clustering_WD, 3)), ...
    [BRAPH2.STR ':ClusteringAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
GraphBU
%%%% ¡code!
B_BU = [
    0 1 1 1; 
    1 0 1 0; 
    1 1 0 1; 
    1 0 1 0
    ];
clustering_BU = {mean([2/3 1 2/3 1]')};
g = GraphBU('B', B_BU);
m_outside_g = ClusteringAv('G', g);
assert(isequal(m_outside_g.get('M'), clustering_BU), ...
    [BRAPH2.STR ':ClusteringAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'ClusteringAv');
assert(isequal(m_inside_g.get('M'), clustering_BU), ...
    [BRAPH2.STR ':ClusteringAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
GraphBD
%%%% ¡code!
B_BD = [
    0 0 1; 
    1 0 0; 
    0 1 0 
    ];
clustering_BD_out = {mean([0 0 0]')};  % out rule

g = GraphBD('B', B_BD);
m_outside_g = ClusteringAv('G', g, 'RULE', 'out');
assert(isequal(m_outside_g.get('M'), clustering_BD_out), ...
    [BRAPH2.STR ':ClusteringAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'ClusteringAv');
m_inside_g.set('RULE', 'out');
assert(isequal(m_inside_g.get('M'), clustering_BD_out), ...
    [BRAPH2.STR ':Clustering:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultigraphBUD
%%%% ¡code!
B = [
    0 1 1 1; 
    1 0 1 0; 
    1 1 0 1; 
    1 0 1 0
    ];

densities = [70 80 90];

known_clustering = {
    mean([0 0 0 0]')
    mean([2/3 1 2/3 1]')
    mean([2/3 1 2/3 1]')
    };

g = MultigraphBUD('B', B, 'DENSITIES', densities);

m_outside_g = ClusteringAv('G', g);
assert(isequal(m_outside_g.get('M'), known_clustering), ...
    [BRAPH2.STR ':ClusteringAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'ClusteringAv');
assert(isequal(m_inside_g.get('M'), known_clustering), ...
    [BRAPH2.STR ':ClusteringAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultigraphBUT
%%%% ¡code!
B = [
    0 1 1 1; 
    1 0 1 0; 
    1 1 0 1; 
    1 0 1 0
    ];

thresholds = [0 1];

known_clustering = {
    mean([2/3 1 2/3 1]')
    mean([0   0 0   0]')
    };

g = MultigraphBUT('B', B, 'THRESHOLDS', thresholds);

m_outside_g = ClusteringAv('G', g);
assert(isequal(m_outside_g.get('M'), known_clustering), ...
    [BRAPH2.STR ':Clustering:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'ClusteringAv');
assert(isequal(m_inside_g.get('M'), known_clustering), ...
    [BRAPH2.STR ':Clustering:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexWU
%%%% ¡code!
B11 = [
    0 .1 .2 .1;
    1 0 .3 0;
    .2 .3 0 .4;
    1 0 .4 0
    ];
B22 = [
    0 .1 .2 .1;
    1 0 .3 0;
    .2 .3 0 .4;
    1 0 .4 0
    ];
B  = {B11 B22};

known_clustering = [
    mean([.2741 .3915 .2741 .4309]')
    mean([.2741 .3915 .2741 .4309]')
    ];
		
g = MultiplexWU('B', B);
m_outside_g = ClusteringAv('G', g);
assert(isequal(round(cell2mat(m_outside_g.get('M')),4), round(known_clustering, 4)), ...
    [BRAPH2.STR ':Clustering:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'ClusteringAv');
assert(isequal(round(cell2mat(m_inside_g.get('M')),4), round(known_clustering, 4)), ...
    [BRAPH2.STR ':Clustering:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexWD
%%%% ¡code!
B11 = [
    0 .1 .2 .1;
    1 0 .3 0;
    .2 .4 0 .3;
    1 0 .4 0
    ];
B22 = [
    0 .1 .2 .1;
    1 0 .3 0;
    .2 .4 0 .3;
    1 0 .4 0
    ];
B  = {B11 B22};

clustering_WD = [ mean([.1375 .1621 .1381 .1565]) mean([.1375 .1621 .1381 .1565]')]' ;

g = MultiplexWD('B', B);
m_outside_g = ClusteringAv('G', g);
assert(isequal(round(cell2mat(m_outside_g.get('M')),2), round(clustering_WD, 2)), ...
    [BRAPH2.STR ':Clustering:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'ClusteringAv');
assert(isequal(round(cell2mat(m_inside_g.get('M')),2), round(clustering_WD, 2)), ...
    [BRAPH2.STR ':Clustering:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBU
%%%% ¡code!
B11 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];
B22 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];
B  = {B11 B22};

known_clustering = {
                 mean([2/3 1 2/3 1]')
                 mean([2/3 1 2/3 1]')
                 };      

g = MultiplexBU('B', B);
m_outside_g = ClusteringAv('G', g);
assert(isequal(m_outside_g.get('M'), known_clustering), ...
    [BRAPH2.STR ':Clustering:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'ClusteringAv');
assert(isequal(m_inside_g.get('M'), known_clustering), ...
    [BRAPH2.STR ':Clustering:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBD
%%%% ¡code!
B11 = [
      0 0 1; 
      1 0 0; 
      0 1 0 
      ];
B22 = [
      0 0 1; 
      1 0 0; 
      0 1 0 
      ];
B = {B11 B22};

% cycle rule - default
known_clustering = {
                 mean([1 1 1]')
                 mean([1 1 1]')
                 }; 

g = MultiplexBD('B', B);
m_outside_g = ClusteringAv('G', g, 'RULE', 'cycle');
assert(isequal(m_outside_g.get('M'), known_clustering), ...
    [BRAPH2.STR ':Clustering:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'ClusteringAv');
m_inside_g.set('RULE', 'cycle');
assert(isequal(m_inside_g.get('M'), known_clustering), ...
    [BRAPH2.STR ':Clustering:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBUD
%%%% ¡code!
B11 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];
B22 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];
B  = {B11 B22};

densities = [70 80 90];
known_clustering = {
    mean([0 0 0 0]')
    mean([0 0 0 0]')
    mean([2/3 1 2/3 1]')
    mean([2/3 1 2/3 1]')
    mean([2/3 1 2/3 1]')
    mean( [2/3 1 2/3 1]')
    };

g = MultiplexBUD('B', B, 'DENSITIES', densities);
m_outside_g = ClusteringAv('G', g);
assert(isequal(m_outside_g.get('M'), known_clustering), ...
    [BRAPH2.STR ':Clustering:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'ClusteringAv');
assert(isequal(m_inside_g.get('M'), known_clustering), ...
    [BRAPH2.STR ':Clustering:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBUT
%%%% ¡code!
B11 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];
B22 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];
B  = {B11 B22};

thresholds = [0 1];
known_clustering = {
                 mean([2/3 1 2/3 1]')
                 mean([2/3 1 2/3 1]')
                 mean([0 0 0 0]')
                 mean([0 0 0 0]')
                 };      

g = MultiplexBUT('B', B, 'THRESHOLDS', thresholds);
m_outside_g = ClusteringAv('G', g);
assert(isequal(m_outside_g.get('M'), known_clustering), ...
    [BRAPH2.STR ':Clustering:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'ClusteringAv');
assert(isequal(m_inside_g.get('M'), known_clustering), ...
    [BRAPH2.STR ':Clustering:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])