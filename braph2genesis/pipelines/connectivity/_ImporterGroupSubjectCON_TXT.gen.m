%% ¡header!
ImporterGroupSubjectCON_TXT < Importer (im, importer of CON subject group from TXT) imports a group of subjects with connectivity data from a series of TXT file.

%%% ¡description!
ImporterGroupSubjectCON_TXT imports a group of subjects with connectivity data from a series of TXT file and their covariates (optional) from another TXT file.
All these files must be in the same folder; also, no other files should be in the folder.
Each file contains a table of values corresponding to the adjacency matrix.
The TXT file containing the covariates must be inside another folder in the same group directory 
and consists of the following columns:
Subject ID (column 1), Subject AGE (column 2), and Subject SEX (column 3).
The first row contains the headers and each subsequent row the values for each subject.

%%% ¡seealso!
Element, Importer, ExporterGroupSubjectCON_TXT

%% ¡props!

%%% ¡prop!
DIRECTORY (data, string) is the directory containing the CON subject group files from which to load the subject group.

%%% ¡prop!
BA (data, item) is a brain atlas.
%%%% ¡settings!
'BrainAtlas'

%%% ¡prop!
GR (result, item) is a group of subjects with connectivity data.
%%%% ¡settings!
'Group'
%%%% ¡check_value!
check = any(strcmp(value.get(Group.SUB_CLASS_TAG), subclasses('SubjectCON', [], [], true))); % Format.checkFormat(Format.ITEM, value, 'Group') already checked
%%%% ¡default!
Group('SUB_CLASS', 'SubjectCON', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON'))
%%%% ¡calculate!
% creates empty Group
gr = Group( ...
    'SUB_CLASS', 'SubjectCON', ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectCON') ...
    );

gr.lock('SUB_CLASS');
directory = im.get('DIRECTORY');
if ~isfolder(directory)&& ~braph2_testing()
    im.uigetdir()
    directory = im.get('DIRECTORY');
end
if isfolder(directory)  
    wb = braph2waitbar(im.get('WAITBAR'), 0, 'Reading directory ...');
    
    % sets group props
    [~, name] = fileparts(directory);
    gr.set( ...
        'ID', name, ...
        'LABEL', name, ...
        'NOTES', ['Group loaded from ' directory] ...
    );

    try
        % analyzes file
        files = dir(fullfile(directory, '*.txt'));

        % Check if there are covariates to add (age and sex)
        cov_folder = dir(directory);
        cov_folder = cov_folder([cov_folder(:).isdir] == 1);
        cov_folder = cov_folder(~ismember({cov_folder(:).name}, {'.', '..'}));
        if ~isempty(cov_folder)
            file_cov = dir(fullfile([directory filesep() cov_folder.name], '*.txt'));
            raw_covariates = readtable([directory filesep() cov_folder.name filesep() file_cov.name], 'Delimiter', '	');
            age = raw_covariates{:, 2};
            sex = raw_covariates{:, 3};
        else
            age = ones(length(files), 1);
            unassigned =  {'unassigned'};
            sex = unassigned(ones(length(files), 1));
        end

        braph2waitbar(wb, .15, 'Loading subjecy group ...')

        if length(files) > 0
            % brain atlas
            ba = im.get('BA');
            raw = readtable(fullfile(directory, files(1).name), 'Delimiter', '	');
            br_number = size(raw, 1);  
            if ba.get('BR_DICT').length ~= br_number
                ba = BrainAtlas();
                idict = ba.get('BR_DICT');
                for j = 1:1:br_number
                    br_id = ['br' int2str(j)];
                    br = BrainRegion('ID', br_id);
                    idict.add(br)
                end
                ba.set('br_dict', idict);
            end

            subdict = gr.get('SUB_DICT');

            % adds subjects
            for i = 1:1:length(files)
                braph2waitbar(wb, .30 + .70 * i / length(files), ['Loading subject ' num2str(i) ' of ' num2str(length(files)) ' ...'])

                % read file
                CON = table2array(readtable(fullfile(directory, files(i).name), 'Delimiter', '	'));
                [~, sub_id] = fileparts(files(i).name);
                sub = SubjectCON( ...
                    'ID', sub_id, ...
                    'BA', ba, ...
                    'age', age(i), ...
                    'sex', sex{i}, ...
                    'CON', CON ...
                );
                subdict.add(sub);
            end
            gr.set('sub_dict', subdict);
        end
    catch e
        braph2waitbar(wb, 'close')
        
        rethrow(e)
    end
    
	braph2waitbar(wb, 'close')
elseif ~braph2_testing()
    error([BRAPH2.STR ':ImporterGroupSubjectCON_TXT: ' BRAPH2.BUG_IO]);
end

value = gr;

%% ¡methods!
function uigetdir(im)
    % UIGETDIR opens a dialog box to set the directory from where to load the TXT files of the CON subject group.

    directory = uigetdir('Select directory');
    if ischar(directory) && isfolder(directory)
        im.set('DIRECTORY', directory);
    end
end