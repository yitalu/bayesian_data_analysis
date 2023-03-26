## The workflow:
Estimand -> Estimator -> Estimate

- Estimand: a statistical goal
- Estimator: a statistical model (a machine)
- Estimate: statistical results (posterior distributions and related)



## Design models:
Assuming data-generating process (also causal inference, DAGs, testing causal implications), determing what paremeters to inference, their distributions (priors) and relationships to other parameters (based on scientific theory), simulating prior prediction.

## Update models:
Updating models with data. (not only) Three ways: grid approximation, quadratic approximation, MCMC (Monte Carlo Markov Chain)

## Evaluate models:
sampling from posterior (intervals, PI, HPDI, point estimates) , simulating posterior prediction (predictor residual plots, posterior prediction plots, counterfactual plots), software validation, model comparison, forecasting





## Generative simulations
Generative simulations are models that produce synthetic sample; also to define our estimand.