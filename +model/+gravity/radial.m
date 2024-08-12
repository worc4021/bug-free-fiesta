classdef radial < matlab.System & model.gravity.base
    
    properties (Nontunable)
        G (1,1) double {mustBePositive} = 6.6743e-11
        M (1,1) double {mustBePositive} = 5.9722e24
        R (1,1) double {mustBePositive} = 6.371e6

        height0 (1,1) double {mustBePositive} = 1200;

    end
    
    methods
        function bus = run(obj, bus)
            bus.radial_distance = obj.R + bus.height;
            bus.Fw = -obj.G*obj.M*bus.mass./(bus.radial_distance.*bus.radial_distance);
        end

        function states = addStates(obj, states)
            states = addStates@model.gravity.base(obj, states);
            states(end+1) = problemdescription.state("height","velocity",obj.height0);
        end
    end 
end

