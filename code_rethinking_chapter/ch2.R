# Ch2. The Basic of Bayesian Inference
# 2.1 From Counts to Probability
# 2.2 How a Bayesian Model Learns
# 2.3 The Components of a Model
# 2.4 Numerical Techniques to Fit a Model

rm(list = ls())
library(rethinking)

# 2.1 The Garden of Forking Data: From Counts to Probability --------------



# 2.2 Building a Model: How a Bayesian Model Learns -----------------------
# Three steps to design a Bayesian model: 
# 1) Data Story: narrating how the data might arise, 
# 2) Update: educate your model by feeding it the data
# 3) Evaluate: supervision and model revision


# The toy example of tossing globe
# Suppose the proportion of water on earth is p, and we observed W L W W W L W L W


# 2.3 Components of the Model ---------------------------------------------
# 1) Variables; e.g., the proportion of water on the earth p is an unobserved variable
# 2) Definitions (of variables)



# parameter, prior, plausibility/likelihood

# 2.3.1 Variables ---------------------------------------------------------



# 2.4 Making the Model Go: Numerical Techniques to Fit a Model ------------

# Three numerical techniques to compute posterior distributions: grid approximation, quadratic approximation, and Markov chain Monte Carlo (MCMC)


# 2.4.3 Grid Approximation ------------------------------------------------

# Multiply each prior probability in the grid by its likelihood and get a posterior distribution. The drawback is the number of values (posterior) to be computed explodes when the number of parameters in the model grows. (p.41)



# 2.4.4 Quadratic (Gaussian) Approximation --------------------------------
# (Also called Gaussian Approximation)
# The shape of the posterior distribution near the peak is usually Gaussian, and can be approximated by a Gaussian distribution. The advantage is that a Gaussian can always be represented by a mean and variance.

# There are many algorithms, but what they basically do is to (1) find the peak of (to climb) the posterior distribution. After the peak is found, the algorithms (2) estimate the curvature near the peak, and use it to derive the whole posteirior distribution.

library(rethinking)
globe.qa <- quap(
  alist(
    W ~ dbinom( W + L, p),
    p ~ dunif(0, 1)
  ),
  data = list(W=6, L=3)
)
precis(globe.qa)

# mean    sd    5.5%    94.5%
# p 0.67  0.16  0.42    0.92

# Using the globe tossing example, the quadratic approximation gives a posterior distribution with mean 0.67 and standard deviation 0.16.