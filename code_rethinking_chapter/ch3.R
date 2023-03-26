# Ch3. Sampling from Probability Distributions
# 3.1 Sampling from a grid-approximate posterior
# 3.2 Sampling to summarize
# 3.3 Sampling to simulate prediction
# 3.4 Summary
# 3.5 Practice

rm(list = ls())
library(rethinking)


# 3.1 Sampling from a grid-approximate posterior --------------------------
p_grid <- seq( from=0 , to=1 , length.out=1000 )
prob_p <- rep( 1 , 1000 )
prob_data <- dbinom( 6 , size=9 , prob=p_grid )
posterior <- prob_data * prob_p
posterior <- posterior / sum(posterior) # posterior distribution

plot(posterior)

samples <- sample(p_grid, prob = posterior, size = 1e4, replace = TRUE)

plot(samples)
dens(samples) # samples from posterior distribution



# 3.2 Sampling to summarize -----------------------------------------------

sum(posterior[p_grid < 0.5]) # cumulative probability (up to 0.5) of the posterior distribution; OR proportion of posterior probability lies below 0.5

sum( samples < 0.5 ) / 1e4 # cumulative probability (up to 0.5), using the samples from the posterior distribution
sum( samples > 0.5 & samples < 0.75 ) / 1e4

quantile(samples, 0.8) # lower 80% probability mass from p = 0
quantile( samples , c( 0.1 , 0.9 ) ) # middle 80% probability mass


p_grid <- seq( from=0 , to=1 , length.out=1000 )
prior <- rep(1,1000)
likelihood <- dbinom( 3 , size=3 , prob=p_grid )
posterior <- likelihood * prior
posterior <- posterior / sum(posterior)
samples <- sample( p_grid , size=1e4 , replace=TRUE , prob=posterior )

PI(samples, prob = 0.5) # Percentile Interval: shows the central 50% probability interval
HPDI(samples, prob = 0.5) # shows the highest posterior density interval (HPDI), the narrowest interval containing the specified probability mass



# 3.3 Sampling to simulate prediction -------------------------------------




# 3.5 Practice ------------------------------------------------------------
p_grid <- seq( from = 0, to = 1, length.out = 1000 )
prior <- rep(1, 1000)
likelihood <- dbinom(6, size = 9, prob = p_grid)
posterior <- likelihood * prior
posterior <- posterior / sum(posterior)
set.seed(100)
samples <- sample(p_grid, prob = posterior, size = 1e4, replace = TRUE)

plot(posterior)

plot(samples)
dens(samples)

# 3E1. --------------------------------------------------------------------
# How much posterior probability lies below p = 0.2?
sum(samples < 0.2) / 1e4 # 4e-04

# 3E2. --------------------------------------------------------------------
# How much posterior probability lies above p = 0.8?
sum(samples > 0.8) / 1e4 # 0.1116

# 3E3. --------------------------------------------------------------------
# How much posterior probability lies between p = 0.2 and p = 0.8?
sum( samples > 0.2 & samples < 0.8) / 1e4 # 0.888

# 3E4. --------------------------------------------------------------------
# 20% of the posterior probability lies below which value of p?
quantile(samples, probs = 0.2) # 0.5185185

# to confirm:
sum( samples < 0.52 ) / 1e4


# 3E5. --------------------------------------------------------------------
# 20% of the posterior probability lies above which value of p?
quantile(samples, probs = 0.8) # 0.7557558

# to confirm
sum( samples > 0.76 ) / 1e4
