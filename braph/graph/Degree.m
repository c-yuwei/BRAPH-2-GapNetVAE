classdef Degree < Measure
    %Degree measure, mainly for BU / WU
    properties
        deg
        indeg
        outdeg
    end
    methods
        function d = Degree(g,varargin)
           d = d@Measure(g,varargin);
        end
    end
    methods
        function  val = getValue(obj)
             if isempty(obj.deg)
                obj.calculate();
            end
            
           val =  obj.deg;
        end
    end
    methods(Access = protected)
        
        function calculate(g)
             if isempty(obj.deg) || isempty(obj.indeg) || isempty(obj.outdeg)
               % matrix is already created with this properties check with
               % giovanni
                 % A = double(d.g.A~=0);  % binarizes connection matrix
               % A = Graph.removediagonal(A); 
                
               int_indeg = sum(obj.g.A,1);  % indegree = column sum of A
               int_outdeg = sum(obj.g.A,2)';  % outdegree = row sum of A
                int_deg = obj.g.indeg + obj.g.outdeg;  % degree = indegree + outdegree
            end
            
            obj.deg = int_deg / 2; %  As braph 1
            obj.indeg = int_indeg;
            obj.outdeg = int_outdeg;
        end
    end
    methods (Static)
        function bool = is_global()
            bool = false;
        end
        function bool = is_nodal()
            bool = true;
        end

        function bool = is_compatible_graph()
            if d.g.is_undirected()
                 bool = true; 
            else
                bool = false;
            end
            
            
        end
        function bool = compatible_graph_list()  
            bool = true;  % HUmm..... ?? Incomplete
        end
    end    
end