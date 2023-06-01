%% ¡header!
DegreeInAv < DegreeIn (m, degreeinav) is the graph degreeinav.

%%% ¡description!
The average degreeinav of a graph is the average of all number of inward edges connected to a node within a layer. 

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the degreeinav.
%%%% ¡default!
'DegreeInAv'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the degreeinav.
%%%% ¡default!
'The average degreeinav of a graph is the average of all number of inward edges connected to a node within a layer.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the degreeinav.

%%% ¡prop!
ID (data, string) is a few-letter code of the degreeinav.
%%%% ¡default!
'DegreeInAv ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the degreeinav.
%%%% ¡default!
'DegreeInAv label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the degreeinav.
%%%% ¡default!
'DegreeInAv notes'

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
{'GraphWD' 'GraphBD' 'MultiplexWD' 'MultiplexBD'}

%%% ¡prop!
M (result, cell) is the degreeinav.
%%%% ¡calculate!
in_degree = calculateValue@DegreeIn(m, prop);	
g = m.get('G'); % graph from measure class
layerNumber = g.get('LAYERNUMBER');
in_degree_av = cell(layerNumber, 1);

parfor li = 1:1:layerNumber
    in_degree_av(li) = {mean(in_degree{li})};
end

value = in_degree_av;

%% ¡tests!

%%% ¡excluded_props!
[DegreeInAv.PFM]

%%% ¡test!
%%%% ¡name!
GraphWD
%%%% ¡code!
B = [
    0   .2  1
    0   0   .8
    1   0   0
    ];

known_in_degree_av = {mean([1 1 2]')};

g = GraphBD('B', B);

m_outside_g = DegreeInAv('G', g);
assert(isequal(m_outside_g.get('M'), known_in_degree_av), ...
   [BRAPH2.STR ':DegreeInAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeInAv');
assert(isequal(m_inside_g.get('M'), known_in_degree_av), ...
    [BRAPH2.STR ':DegreeInAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])


%%% ¡test!
%%%% ¡name!
MultiplexBD
%%%% ¡code!
B11 = [
      0  1  1
      0  0  0
      1  0  0
      ];
B22 = [
       0  1  0
       1  0  1
       1  1  0
       ];
B = {B11 B22};

known_in_degree = { 
                  mean([1 1 1]')
                  mean([2 2 1]')
                  };

g = MultiplexBD('B', B);

m_outside_g = DegreeInAv('G', g);
assert(isequal(m_outside_g.get('M'), known_in_degree), ...
   [BRAPH2.STR ':DegreeInAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeInAv');
assert(isequal(m_inside_g.get('M'), known_in_degree), ...
    [BRAPH2.STR ':DegreeInAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexWD
%%%% ¡code!
B11 = [
      0   .2  1
      0   0   .8
      1   0   0
      ];
B22 = [
      0  1   .6
      1  0   .4
      0  .4  0
      ];
B = {B11 B22};

known_in_degree = {
    mean([1 1 2]')
    mean([1 2 2]')
    };

g = MultiplexWD('B', B);

m_outside_g = DegreeInAv('G', g);
assert(isequal(m_outside_g.get('M'), known_in_degree), ...
   [BRAPH2.STR ':DegreeInAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeInAv');
assert(isequal(m_inside_g.get('M'), known_in_degree), ...
    [BRAPH2.STR ':DegreeInAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])