classdef base < model.interface
    %BASE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties 
        m0 (1,1) double {mustBePositive} = 0.8;
    end
    
    methods
        function obj = base()
            obj.outputname = "Fw";
        end

        function bus = run(~, bus)
        end

        function states = addStates(obj, states)
            states(end+1) = problemdescription.state("mass","zero",obj.m0);
        end
    end
end

