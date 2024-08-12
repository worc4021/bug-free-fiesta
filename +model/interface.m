classdef (Abstract) interface < matlab.System 
    
    properties
        outputname (1,1) string
    end

    methods
        bus = run(obj, bus)
        states = addStates(obj, states)
    end

    methods (Access = protected)
        function y = stepImpl(obj,u)
            states = obj.addStates(problemdescription.state.empty);
            bus = struct;
            for iState = 1:numel(states)
                bus.(states(iState).name) = u(iState,:,:);
            end
            bus = run(obj, bus);
            y = bus.(obj.outputname);
        end
    end
end

