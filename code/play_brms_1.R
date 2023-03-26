# README ------------------------------------------------------------------
# References: https://ourcodingclub.github.io/tutorials/brms/
# In this script, we try to build a model and answer the question: has the red know popoulation in France increased over time? In other word, does "time" have any effect on the population size of red know.




# Load Packages and Data --------------------------------------------------
rm(list = ls())
library(brms)
library(bayesplot)
library(data.table)
d <- fread("./data/red_knot.csv")




# Explore Data ------------------------------------------------------------
# Get a sense of how data looks like
str(d)
colnames(d)
unique(d$pop)
head(d$year)

# Distribution of population size
hist(d$pop, breaks = 50)
plot(density(d$pop))
# looks like population follows a Poisson distribution

# Distribution of year
plot(density(d$year))
unique(d$year)
range(d$year)

# Visualize population over time
plot(d$pop ~ d$year, type = "l")




# Build Model -------------------------------------------------------------

# Consider the effect of time on population
m1 <- brm(formula = pop ~ I(year - min(year)), data = d, family = poisson(), chains = 4, iter = 2000, warmup = 1000)
summary(m1)
fixef(m1)
plot(m1)

# posterior predictive checks
pp_check(m1)
pp_check(m1, type = "error_hist")
pp_check(m1, type = "scatter_avg")
pp_check(m1, type = "stat_2d")
pp_check(m1, type = "rootogram")
pp_check(m1, type = "loo_pit")
pp_check(m1, prefix = "ppd")
pp_check(m1, type = "xyz") # to check the valid types


# Including effect from previous year
m2 <- brm(formula = pop ~ I(year - min(year)) + (I(year - min(year))), data = d, family = poisson(), chains = 4, iter = 2000, warmup = 1000)
summary(m2)
fixef(m2)
plot(m2)
pp_check(m2)


# Including location of observations into model
unique(d$Location.of.population)
boxplot(d$pop ~ d$Location.of.population)

m3 <- brm(formula = pop ~ I(year - min(year)) + Location.of.population, data = d, family = poisson(), chains = 4, iter = 2000, warmup = 1000)
summary(m3)
fixef(m3)
plot(m3)
pp_check(m3)




# Evaluate Model ----------------------------------------------------------
# leave-one-out cross validation
loo(m1, m2, m3, compare = TRUE)
# elpd estimate: the higher value the better the fit

