% test InDegree

A = rand(randi(10));

%% Test 1: InDegree calculates correctly for GraphBD

g = GraphBD(A);
in_degree = InDegree(g);
A = dediagonalize(A);
A = semipositivize(A);
A = binarize(A);
in_dA = sum(A, 1)';

assert(isequal(in_degree.getValue, in_dA), ...
    'BRAPH:InDegree:Bug', ...
    'InDegree is not beeing calculated correctly for GraphBD')

%% Test 2: InDegree calculates correctly for GraphWD

g = GraphWD(A);
in_degree = InDegree(g);
A = dediagonalize(A);
A = semipositivize(A);
in_dA = sum(A, 1)';

assert(isequal(in_degree.getValue, in_dA), ...
    'BRAPH:InDegree:Bug', ...
    'InDegree is not beeing calculated correctly for GraphWD')

%% Test 3: InDegree get Class correctly

g = GraphWD(A);
in_degree = InDegree(g);

assert(isequal(in_degree.getClass, 'InDegree'), ...
    'BRAPH:InDegree:Bug', ...
    'InDegree is not getting class correctly')

%% Test 4: InDegree get Name correctly

g = GraphWD(A);
in_degree = InDegree(g);

assert(isequal(in_degree.getName(), 'In-Degree'), ...
    'BRAPH:InDegree:Bug', ...
    'InDegree is not getting class correctly')

%% Test 5: InDegree get Description works

g = GraphWD(A);
in_degree = InDegree(g);

assert(ischar(in_degree.getDescription()), ...
    'BRAPH:InDegree:Bug', ...
    'InDegree is not getting class correctly')