classdef state < matlab.mixin.Heterogeneous
    properties (SetAccess = private)
        x0 (1,1) double
        name (1,1) string
        derivativename (1,1) string
    end
    
    methods
        function s = state(name,derivativename,x0)
            s.name = name;
            s.derivativename = derivativename;
            s.x0 = x0;
        end
    end
end

