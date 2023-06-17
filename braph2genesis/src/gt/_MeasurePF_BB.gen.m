%% ¡header!
MeasurePF_BB < MeasurePF (pf, panel figure binodal bilayer measure) is the base element to plot a binodal bilayer measure.

%%% ¡description!
MeasurePF_BB manages the basic functionalities to plot of a binodal bilayer measure.

%%% ¡seealso!
Measure

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the panel figure binodal bilayer measure.
%%%% ¡default!
'MeasurePF_BB'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the panel figure binodal bilayer measure.
%%%% ¡default!
'MeasurePF_BB manages the basic functionalities to plot of a binodal bilayer measure.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the panel figure binodal bilayer measure.

%%% ¡prop!
ID (data, string) is a few-letter code for the panel figure binodal bilayer measure.
%%%% ¡default!
'MeasurePF_BB ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the panel figure binodal bilayer measure.
%%%% ¡default!
'MeasurePF_BB label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the panel figure binodal bilayer measure.
%%%% ¡default!
'MeasurePF_BB notes'

%%% ¡prop!
SETUP (query, empty) calculates the measure value and stores it.
%%%% ¡calculate!
%%%__WARN_TBI__
value = [];

%% ¡props!

%%% ¡prop!
NODES (figure, rvector) are the node numbers of the binodal measure.
%%%% ¡_gui!
% % % bas = pf.get('M').get('G').get('BAS');
% % % ba = bas{1};
% % % 
% % % pr = PP_BrainRegion('EL', pf, 'PROP', PFMeasureNU.BR1_ID, ...
% % %     'BA', ba, ...
% % %     varargin{:});

%% ¡tests!

%%% ¡excluded_props!
[MeasurePF_BB.PARENT MeasurePF_BB.H MeasurePF_BB.ST_POSITION MeasurePF_BB.ST_AXIS MeasurePF_BB.ST_AREA MeasurePF_BB.ST_LINE MeasurePF_BB.ST_TITLE MeasurePF_BB.ST_XLABEL MeasurePF_BB.ST_YLABEL] 

%%% ¡warning_off!
true

%%% ¡test!
%%%% ¡name!
Remove Figures
%%%% ¡parallel!
false
%%%% ¡code!
warning('off', [BRAPH2.STR ':MeasurePF_BB'])
assert(length(findall(0, 'type', 'figure')) == 1)
delete(findall(0, 'type', 'figure'))
warning('on', [BRAPH2.STR ':MeasurePF_BB'])