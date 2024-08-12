function simulation(jsonpath)

if ~isfile(jsonpath)
    error('Config file %s does not exist',jsonpath);
end

config = jsondecode(fileread(jsonpath));

object = model.object(config);

if isfield(config,'model')
    fields = utilities.struct.fieldnames(config.model);
    for field = fields
        value = utilities.struct.getfield(config.model,field);
        if utilities.struct.assignIfPossible(object,field,value)
            fprintf('Set model parameter %s to %s\n',field,string(value));
        else
            warning('Did not set model parameter %s successfully.',field);
        end
    end
end

states = object.addStates(problemdescription.state.empty);

F = ode();
F.ODEFcn = @(t,u)object(u);
F.InitialValue = arrayfun(@(x)x.x0,states(:));

% Check the available solvers: web(fullfile(docroot, 'matlab/ref/ode.html?s_tid=doc_srchtitle'))
if isfield(config,'solver')
    F.Solver = config.solver;
    fprintf('Solver set to %s\n',config.solver)
end

% The available options will depend on the selected solver.
if isfield(config,'solverOptions')
    for field = fieldnames(config.solverOptions)'
        if isprop(F.SolverOptions,field{1})
            F.SolverOptions.(field{1}) = config.solverOptions.(field{1});
            fprintf('Solver option %s set to %s\n',field{1},string(config.solverOptions.(field{1})))
        else
            warning('Option %s not valid for selected solver',field{1});
        end
    end
end

StartTime = 0;
StopTime = 10;
if isfield(config,'experiment')
    if isfield(config.experiment,'StartTime')
        StartTime = config.experiment.StartTime;
    end
    if isfield(config.experiment,'StopTime')
        StopTime = config.experiment.StopTime;
    end
end

sol = solve(F,StartTime,StopTime);

bus = struct;
bus.zero = zeros(size(sol.Solution,2),1);
for iState = 1:numel(states)
    bus.(states(iState).name)(:,1) = sol.Solution(iState,:);
end
bus = object.run(bus);

[configfolder,basename,~] = fileparts(jsonpath);
resultfile = fullfile(configfolder,[basename,'.csv']);
tb = struct2table(bus);
writetable(tb,resultfile);
fprintf('Result saved to %s\n',resultfile);

end

