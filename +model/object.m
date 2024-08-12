classdef object < model.interface
    properties (SetAccess = private)
        drag (1,1) model.drag = model.drag
        gravity (1,1) model.gravity.base = model.gravity.constant

        states (:,1) problemdescription.state = problemdescription.state.empty
    end

    methods
        function obj = object(config)
            if isfield(config,'gravitymodel')
                obj.gravity = model.gravity.(config.gravitymodel);
            end
        end

        function bus = run(obj, bus)
            bus = obj.drag.run(bus);
            bus = obj.gravity.run(bus);
            bus.acceleration = (bus.Fw + bus.Fd)./bus.mass;
        end

        function states = addStates(obj, states)
            states = obj.drag.addStates(states);
            states = obj.gravity.addStates(states);
        end
    end

    methods (Access = protected)
        function y = stepImpl(obj,u)
            bus = struct;
            bus.zero = zeros(1,size(u,2),size(u,3));
            for iState = 1:numel(obj.states)
                bus.(obj.states(iState).name) = u(iState,:,:);
            end
            bus = obj.run(bus);
            y = zeros(numel(obj.states),size(u,2),size(u,3));
            for iState = 1:numel(obj.states)
                y(iState,:,:) = bus.(obj.states(iState).derivativename);
            end
        end

        function setupImpl(obj)
            obj.states = obj.addStates(obj.states);
        end

        function resetImpl(obj)
            obj.states = problemdescription.state.empty;
            obj.states = obj.addStates(obj.states);
        end
    end
end

