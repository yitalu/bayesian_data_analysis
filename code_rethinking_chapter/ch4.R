# Ch4. Linear Regression
# 4.1 Normal Distribution
# 4.2 Describing Models
# 4.3 Gaussian Model of Height (Dependent Variables)
# 4.4 Predictor Variables
# 4.5 Curves from Lines
rm(list = ls())
library("rethinking")



# 4.3 Gaussian Model of Height --------------------------------------------
data(Howell1)
d <- Howell1

str(d) # structure of d
precis(d)

d$height
d2 <- d[ d$age >= 18, ]

summary(d2$height)
dens(d2$height)

# By looking at the density plot, we "guess" the variable height is normally distributed, so we assume height_i ~ Normal(mu, sigma), and proceed to estimate the values for mu and sigma.

# We need a joint prior probability for mu and sigma: Pr(mu, sigma). We assume mu and sigma are independent from each other, i.e., Pr(mu, sigma) = Pr(mu)Pr(sigma)

# We further assume the prior for mu is centered on 178 and has a standard deviation 20 (95% within 178 ± 40), and assume the sigma is uniformly distributed between 0 and 50.

# The model is then: 
# h_i ~ Normal(mu, sigma)
# mu ~ Normal(178, 20)
# sigma ~ Uniform(0, 50)

# to visualize the priors
curve( dnorm(x, mean = 178, sd = 20), from = 100, to = 250 ) # mu
curve( dunif(x, min = 0, max = 50), from = -10, to = 60 ) # sigma

# Choose your prior distributions based on physical meanings, prior knowledge, or some scientific theories.

# Prior Predictive Simulation
# After choosing the prior distributions, we can have a predictive simulation of our dependent variable (sampling from the prior)
sample_mu <- rnorm(1e4, mean = 178, sd = 20)
sample_sigma <- runif(1e4, min = 0, max = 50)
prior_h <- rnorm(1e4, mean = sample_mu, sd = sample_sigma)
dens(prior_h)


# Grid Approximation (see 2.4.3)
# Derive the posterior distribution of the parameters from our model (the combination of the assumed distributions, the chosen parameters/priors, and the collected data)
mu.list <- seq(150, 160, length.out=100)
sigma.list <- seq(7, 9, length.out=100)
post <- expand.grid(mu=mu.list, sigma=sigma.list)
post$LL <- sapply( 1:nrow(post), FUN = function(i) sum( dnorm(d2$height, post$mu[i], post$sigma[i], log = TRUE) ))
post$prod <- post$LL + dnorm( post$mu , 178 , 20 , TRUE ) + dunif( post$sigma , 0 , 50 , TRUE )
post$prob <- exp( post$prod - max(post$prod) )

contour_xyz( post$mu , post$sigma , post$prob )
image_xyz( post$mu , post$sigma , post$prob )


# Sampling from the posterior



# 4.4 Predictor Variables -------------------------------------------------

plot(d$height ~ d$weight)
