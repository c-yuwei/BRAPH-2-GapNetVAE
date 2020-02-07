classdef InDegree < Measure
    %Degree measure, mainly for BD / WD
    properties

        indeg

    end
    methods
        function ind = InDegree(g,varargin)
           ind = ind@Measure(g,varargin);
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
             if  isempty(obj.indeg) 
               %  matrix is already created with this properties check with
               %  giovanni
               %  A = double(d.g.A~=0);  % binarizes connection matrix
               %  A = Graph.removediagonal(A); 
                
                int_indeg = sum(obj.g.A,1);  %  indegree = column sum of A             
             end           
          
            obj.indeg =int_indeg;
           
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
                 bool = false; 
            else
                bool = true;
            end
            
            
        end
        function bool = compatible_graph_list()  
            bool = true;  % HUmm..... ?? Incomplete
        end
    end    
end