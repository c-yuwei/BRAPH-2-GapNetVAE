classdef Degree < Measure
    methods
        function m = Degree(g, varargin)
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access=protected)
        function calculate(m)
            g = m.getGraph();
            A = g.getA();
            degree = sum(A, 2);
            m.setValue(degree);
        end
    end        
    methods (Static)
        function name = getName()
            name = 'Degree';
        end
        function description = getDescription()
            description = [ ...
                'The degree of a node is ' ...
                'the number of edges connected to the node. ' ...
                'Connection weights are ignored in calculations.' ...
                ];
        end
        function bool = is_global()
                        
            bool = false;
        end
        function bool = is_nodal()
            bool = true;
        end
        function list = compatible_graph_list()  
            list = { ...
                'GraphBU', ...
                'GraphWU' ...
                };
        end
    end
end