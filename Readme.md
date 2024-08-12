# General

The simulation and model configuration is done via json. An example is provided in `test/basic.json`.

The complexity of the simulation is reasonably limited so that no option should require extensive elaboration. The structure of the config file is

- `gravitymodel` [optional] select the gravity model in use `radial` or `constant`
- `model`
    - `drag`
        - `xyz` override the parameter of `xyz` in the active drag model
    - `gravity`
        - `xyz` override the parameter of `xyz` in the active gravitational model.
- `solver` Select one of the available integrators from matlab, see [docs](https://uk.mathworks.com/help/releases/R2024a/matlab/ref/ode.html?s_tid=doc_srchtitle) for available options
- `solverOptions` override matlab's default sovler configuration for active solver
- `exeperiment`
    - `StartTime`, `StopTime` control the integration time

The one additional note maybe required: Everything under `model` mimics the internal model component hierachy. I.e. if we had a third model such as a gas model for altitude dependent density, we might call it `fluid` and then its parameters would automatically be available for overriding under `model.fluid`. Therefore, the names of available overrides for the model can be inferred from the model properties. However, they are identical to the notation in the supplied pdf document.


# Running the simulation

The simulation takes the path to the described json and saves a csv with the solution next to the config json to be examined in the tool of choice.

```
simulation('path/to/json')
```

Any falsely set configs _should_ produce warnings and overrides should print their override.