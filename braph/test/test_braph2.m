% Test BRAPH by running all unit tests

close all
clear all 
clc

dir = fileparts(which('braph2'));

results = runtests({ ...
    [dir filesep 'util'] ...
    [dir filesep 'graph'] ...
    [dir filesep 'graph' filesep 'graphs'] ...
    [dir filesep 'graph' filesep 'measures'] ...
    [dir filesep 'atlas'] ...
    [dir filesep 'data'] ...
    [dir filesep 'data' filesep 'datas'] ...
    [dir filesep 'cohort'] ...
    [dir filesep 'cohort' filesep 'subjects'] ...
    [dir filesep 'analysis'] ...
    [dir filesep 'analysis' filesep 'analyses'] ...
    [dir filesep 'analysis' filesep 'comparisons'] ...
    [dir filesep 'analysis' filesep 'measurements'] ...
    [dir filesep 'analysis' filesep 'randomcomparisons'] ...
    });


results_table = table(results)

if all([results(:).Passed])
    disp('*** All good! ***')
else
    disp('*** Something went wrong! ***')
end