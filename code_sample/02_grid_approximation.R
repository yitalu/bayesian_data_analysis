# Let's use the globe tossing problem as an example. The example will show you the workflow of Bayesian data analysis: make assumptions, update models, evaluate model.

# Suppose we have a globe in our hand representing the Earth and we want to know the true proportion of water. We toss the globe into the air and record what's on our index finger every time the globe falls back to our hand. We collect, for example, nine data points: 

# W L W W W L W L W

# Following the workflow: make assumptions, update model, evaluate model, assuming W follows a binomial disbribution:

# W ~ Binomial(N, p), where N = num W + num L, and p is uniformly distributed p ~ Uniform(0, 1)






p_grid <- seq(from = 0, to = 1, length.out = 1000)
prob_p <- rep(1, 1000)
prob_data <- dbinom(6, size = 9, prob = p_grid)
posterior <- prob_data * prob_p
posterior <- posterior / sum(posterior)