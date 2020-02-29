classdef Cohort < handle & matlab.mixin.Copyable
	properties (GetAccess=protected, SetAccess=protected) 
        name  % brain atlas name
        sub_class  % class of the subjects
        atlases  % cell array with brain atlases
        subdict  % dictionary with subjects
    end
    methods (Access=protected)
%         function ba_copy = copyElement(ba)
%             
%             % Make a shallow copy
%             ba_copy = copyElement@matlab.mixin.Copyable(ba);
%             
%             % Make a deep copy of brdict
%             ba_copy.subdict = containers.Map('KeyType', 'int32', 'ValueType', 'any');
%             brain_regions = values(ba.subdict);
%             for i = 1:1:length(brain_regions)
%                 br = brain_regions{i};
%                 ba_copy.subdict(i) = br.copy();
%             end
%         end        
    end        
    methods
        function cohort = Cohort(name, sub_class, atlases, subs)
            % subs must be a cell array of Subjects of class sub_class
                        
            cohort.name = name;
            
            assert(any(strcmp(Subject.getList(), sub_class)), ...
                ['BRAPH:Cohort:SubjectClassErr'], ...
                [sub_class ' is not a valid Subject class'])
            cohort.sub_class = sub_class;
            
            if ~iscell(atlases)
                atlases = {atlases};
            end
            assert(all(cellfun(@(atlas) isa(atlas, 'BrainAtlas'), atlases)) ...
                && length(atlases) == Subject.getBrainAtlasNumber(sub_class), ...
                ['BRAPH:Cohort:AtlasErr'], ...
                ['The input atlases should be a cell array with ' int2str(Subject.getBrainAtlasNumber(sub_class)) ' BrainAtlas'])
            sub.atlases = atlases;

            cohort.subdict = containers.Map('KeyType', 'int32', 'ValueType', 'any');
            for i = 1:1:length(subs)
                cohort.addSubject(subs{i}, i);
            end
        end
        function str = tostring(cohort)
            str = ['Cohort with ' int2str(cohort.subjectnumber()) ' ' cohort.getSubjectClass()];
        end
        function disp(cohort)
            disp(['<a href="matlab:help ' class(cohort) '">' class(cohort) '</a>'])
            disp([' size: ' int2str(cohort.subjectnumber()) ' <a href="matlab:help ' cohort.getSubjectClass() '">' cohort.getSubjectClass() '</a>'])
        end
        function name = getName(cohort)
            name = cohort.name;
        end
        function sub_class = getSubjectClass(cohort)
            sub_class = cohort.sub_class;
        end
        function atlases = getBrainAtlases(cohort)
            atlases = cohort.atlases;
        end
        function n = subjectnumber(cohort)
            n = length(cohort.subdict);
        end
        function bool = contains_subject(cohort, sub_index)
            bool = isKey(cohort.subdict, sub_index);
        end
        function sub = getSubject(cohort, sub_index)
            sub = cohort.subdict(sub_index);
        end
        function subs = getSubjects(cohort)
            subs = values(cohort.subdict);
        end
%         function br_labels = getBrainRegionLabels(ba)
%             br_labels = cell(1, ba.subjectnumber());
%             for i = 1:1:ba.subjectnumber()
%                 br = ba.getBrainRegion(i);
%                 br_labels{i} = br.getLabel();
%             end
%         end
%         function br_names = getBrainRegionNames(ba)
%             br_names = cell(1, ba.subjectnumber());
%             for i = 1:1:ba.subjectnumber()
%                 br = ba.getBrainRegion(i);
%                 br_names{i} = br.getName();
%             end
%         end
%         function br_xs = getBrainRegionXs(ba)
%             br_xs = cell(1, ba.subjectnumber());
%             for i = 1:1:ba.subjectnumber()
%                 br = ba.getBrainRegion(i);
%                 br_xs{i} = br.getX();
%             end
%         end
%         function br_ys = getBrainRegionYs(ba)
%             br_ys = cell(1, ba.subjectnumber());
%             for i = 1:1:ba.subjectnumber()
%                 br = ba.getBrainRegion(i);
%                 br_ys{i} = br.getY();
%             end
%         end
%         function br_zs = getBrainRegionZs(ba)
%             br_zs = cell(1, ba.subjectnumber());
%             for i = 1:1:ba.subjectnumber()
%                 br = ba.getBrainRegion(i);
%                 br_zs{i} = br.getZ();
%             end
%         end
%         function br_positions = getBrainRegionPositions(ba)
%             br_positions = cell(1, ba.subjectnumber());
%             for i = 1:1:ba.subjectnumber()
%                 br = ba.getBrainRegion(i);
%                 br_positions{i} = br.getPosition();
%             end
%         end
        function addSubject(cohort, sub, i)
            
            if nargin < 3 || i < 0 || i > cohort.subjectnumber()
                i = cohort.subjectnumber() + 1;
            end
            
            assert(isa(sub, cohort.getSubjectClass()), ...
                ['BRAPH:Cohort:SubjectClassErr'], ...
                ['All Subject classes should be ' cohort.getSubjectClass() ', but one is ' sub.getClass()])
            
            if i <= cohort.subjectnumber()
                for j = cohort.subjectnumber():-1:i
                    cohort.subdict(j+1) = cohort.subdict(j);
                end
                cohort.subdict(i) = sub;
            else
                cohort.subdict(i) = sub;
            end
        end
        function removeSubject(cohort, i)
            
            for j = i:1:cohort.subjectnumber()-1
                cohort.subdict(j) = cohort.subdict(j+1);
            end
            remove(cohort.subdict, cohort.subjectnumber());
        end
        function replaceSubject(cohort, i, sub)

            assert(isa(sub, cohort.getSubjectClass()), ...
                ['BRAPH:Cohort:SubjectClassErr'], ...
                ['All Subject classes should be ' cohort.getSubjectClass() ', but one is ' sub.getClass()])

            if i > 0 || i <= cohort.subjectnumber()
                cohort.subdict(i) = sub;
            end
            
        end
        function invertSubjects(cohort, i, j)
            
            if i > 0 && i <= cohort.subjectnumber() && j > 0 && j <= cohort.subjectnumber() && i ~= j
                sub_i = cohort.getSubject(i);
                sub_j = cohort.getSubject(j);
                cohort.replaceSubject(i, sub_j)
                cohort.replaceSubject(j, sub_i)
            end
        end
        function movetoSubject(cohort, i, j)
            
            if i > 0 && i <= cohort.subjectnumber() && j > 0 && j <= cohort.subjectnumber() && i ~= j
                sub = cohort.getSubject(i);
                if i > j
                    cohort.removeSubject(i)
                    cohort.addSubject(sub, j)
                else  % j < i
                    cohort.addSubject(sub, j+1)
                    cohort.removeSubject(i)
                end
            end            
        end
        function selected = removeSubjects(ba, selected)
            
            for i = length(selected):-1:1
                ba.removeSubject(selected(i))
            end
            selected = [];
        end
%         function [selected, added] = addaboveSubjects(cohort, selected)
%             
%             for i = length(selected):-1:1
%                 sub = Subject.getSubject();
%                 cohort.addSubject(BrainRegion(), selected(i))
%             end
%             selected = selected + reshape(1:1:numel(selected), size(selected));
%             added = selected - 1;
%         end
%         function [selected, added] = addbelowSubjects(cohort, selected)
%             
%             for i = length(selected):-1:1
%                 cohort.addSubject(BrainRegion(), selected(i) + 1)
%             end
%             selected = selected + reshape(0:1:numel(selected)-1, size(selected));
%             added = selected + 1;
%         end
%         function selected = moveupBrainRegions(ba, selected)
%             
%             if ~isempty(selected)
%                 
%                 first_index_to_process = 1;
%                 unprocessable_length = 1;
%                 while first_index_to_process <= ba.subjectnumber() ...
%                         && first_index_to_process <= numel(selected) ...
%                         && selected(first_index_to_process) == unprocessable_length
%                     first_index_to_process = first_index_to_process + 1;
%                     unprocessable_length = unprocessable_length + 1;
%                 end
% 
%                 for i = first_index_to_process:1:numel(selected)
%                     ba.invertBrainRegions(selected(i), selected(i)-1);
%                     selected(i) = selected(i) - 1;
%                 end
%             end
%         end
%         function selected = movedownBrainRegions(ba, selected)
%             
%             if ~isempty(selected)
% 
%                 last_index_to_process = numel(selected);
%                 unprocessable_length = ba.subjectnumber();
%                 while last_index_to_process > 0 ...
%                         && selected(last_index_to_process) == unprocessable_length
%                     last_index_to_process = last_index_to_process - 1;
%                     unprocessable_length = unprocessable_length - 1;
%                 end
% 
%                 for i = last_index_to_process:-1:1
%                     ba.invertBrainRegions(selected(i), selected(i) + 1);
%                     selected(i) = selected(i) + 1;
%                 end
%             end
%         end
%         function selected = move2topBrainRegions(ba, selected)
%             
%             if ~isempty(selected)
%                 for i = 1:1:numel(selected)
%                     ba.movetoBrainRegion(selected(i), i);
%                 end
%                 selected = reshape(1:1:numel(selected), size(selected));
%             end
%         end
%         function selected = move2bottomBrainRegions(ba, selected)
%             
%             if ~isempty(selected)
%                 for i = numel(selected):-1:1
%                     ba.movetoBrainRegion(selected(i), ba.subjectnumber() - (numel(selected)-i));
%                 end
%                 selected = reshape(ba.subjectnumber() - numel(selected)+1:1:ba.subjectnumber(), size(selected));
%             end
%         end
    end
end