classdef constant < matlab.System & model.gravity.base
    
    properties (Nontunable)
        g (1,1) double {mustBePositive} = 9.81
    end
    
    methods
        
        function bus = run(obj, bus)
            bus.Fw = -obj.g*bus.mass;
        end

        function states = addStates(obj, states)
            states = addStates@model.gravity.base(obj, states);
        end
    end
end

