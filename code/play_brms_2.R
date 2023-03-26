# References: https://youtu.be/-1Hob2qpyeY

rm(list = ls())
library(brms)
library(bayesplot)
# library(bayestestR)
library(ggplot2)

data("trees")
d <- trees
colnames(d)

plot(d$Height ~ d$Girth)

# frequentist methods
fit_f <- lm(Height ~ Girth, data = d)
layout(matrix(1:4, nrow=2))
plot(fit_f)
summary(fit_f)
confint(fit_f)


# bayesian framework
fit_b <- brm(Height ~ Girth, data = d)
summary(fit_b)
prior_summary(fit_b)


plot(fit_b, variable = c("b_Girth"))
plot(conditional_effects(fit_b))

# Predict future observations
newdata <- data.frame(Girth=c(30))
predict(fit_b, newdata = newdata)

# get specific estimate
fitted(fit_b, newdata = newdata)

curve(dnorm(x, mean = 1.5, sd = 0.5), -1, 5, ylab = "Prior probability on slope", xlab = "Slope", main = "Possible Current Understanding")
curve(dnorm(x, mean = 0, sd = 100), -100, 100, add = TRUE, lty=2, lwd=2)
curve(dunif(x, min = 0, max = 5), 0, 5, add = TRUE, lty=3, lwd=2, col=2)
curve(dgamma(x, scale = 1, shape = 2), 0, 5, add = TRUE, lty=3, lwd=2, col=2)


# rerun the model with prior knowledge/probability
slope.prior <- c(prior(normal(1.5, 0.5), class = b, coef = Girth))
fit_b2 <- brm(Height ~ Girth, data = d, prior = slope.prior)
prior_summary(fit_b2)

# Check MCMC chains
plot(fit_b)
plot(fit_b2)

# posterior predictive check
# Do simulated means (blue) match our observed mean (black)?
bayesplot_grid(
  pp_check(fit_b, type = "stat", stat = "mean"), 
  pp_check(fit_b2, type = "stat", stat = "mean")
)

# Do simulated distributions (blue) match the distribution of our data (black)?
bayesplot_grid(
  pp_check(fit_b, ndraws = 50), 
  pp_check(fit_b2, ndraws = 50)
)


# look at an estimate
stanplot(fit_b)
stanplot(fit_b2, pars = "Girth")

# Compare estimates
# samples from the posterior distribution
samples_1 <- as.data.frame(fit_b)
samples_2 <- as.data.frame(fit_b2)

ggplot(data = samples_1, aes(x=b_Girth)) + 
  geom_density() + 
  geom_density(data = samples_2, aes(x=b_Girth), color="red", lty=2) + 
  labs(title = "Our beliefs about the slope")

# what is the probability that the slope > 1.1?
n <- length(samples_1$b_Girth)
sum(samples_1$b_Girth > 1.1) / n

# or test whether samples_1$b_Girth - 1.1 > 0

## with probability of 0.90
test_samples_1 <- samples_1$b_Girth - 1.1

# simple quantiles
quantile(test_samples_1, c(0.05, 0.5, 0.95))

# Highest Posterior Density intervals
library(coda)
HPDinterval(as.mcmc(test_samples_1), prob=0.90)

# in brms
hypothesis(fit_b2, "Girth > 1.1")