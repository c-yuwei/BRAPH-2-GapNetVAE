%% ¡header!
MeasurePF_GS < MeasurePF (pf, panel figure global superglobal measure) is the base element to plot a global superglobal measure.

%%% ¡description!
MeasurePF_GS manages the basic functionalities to plot of a global superglobal measure.

%%% ¡seealso!
Measure

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the panel figure global superglobal measure.
%%%% ¡default!
'MeasurePF_GS'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure global superglobal measure.
%%%% ¡default!
'MeasurePF_GS manages the basic functionalities to plot of a global superglobal measure.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure global superglobal measure.

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure global superglobal measure.
%%%% ¡default!
'MeasurePF_GS ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure global superglobal measure.
%%%% ¡default!
'MeasurePF_GS label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure global superglobal measure.
%%%% ¡default!
'MeasurePF_GS notes'

%%% ¡prop!
SETUP (query, empty) calculates the measure value and stores it.
%%%% ¡calculate!
%%%__WARN_TBI__
value = [];

%% ¡tests!

%%% ¡excluded_props!
[MeasurePF_GS.PARENT MeasurePF_GS.H MeasurePF_GS.ST_POSITION MeasurePF_GS.ST_AXIS MeasurePF_GS.ST_AREA MeasurePF_GS.ST_LINE MeasurePF_GS.ST_TITLE MeasurePF_GS.ST_XLABEL MeasurePF_GS.ST_YLABEL] 

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡parallel!
false
%%%% ¡code!
warning('off', [BRAPH2.STR ':MeasurePF_GS'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':MeasurePF_GS'])