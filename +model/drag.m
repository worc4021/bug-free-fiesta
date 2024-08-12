classdef drag < model.interface
    
    properties (Nontunable)
        Cd (1,1) double {mustBePositive} = 0.8;
        rho (1,1) double {mustBePositive} = 1.293;
        radius (1,1) double {mustBePositive} = 0.2;

        velocity0 (1,1) double = -200;
    end

    properties (Dependent)
        A (1,1) double
    end
    
    methods
        function obj = drag()
            obj.outputname = "Fd";
        end

        function c = get.A(obj)
            c = pi*obj.radius^2;
        end
        
        function bus = run(obj, bus)
            bus.pDyn = obj.rho*bus.velocity.*bus.velocity;
            bus.Fd = -obj.Cd*obj.A*bus.pDyn.*obj.sign(bus.velocity);
        end

        function states = addStates(obj, states)
            states(end+1) = problemdescription.state("velocity","acceleration",obj.velocity0);
        end
    end

    methods (Static)
        function y = sign(x)
            absx = sqrt(x.*x + 1e-6);
            y = x ./ absx;
        end
    end
end

