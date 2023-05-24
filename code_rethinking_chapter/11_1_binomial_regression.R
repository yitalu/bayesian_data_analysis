
# 11.1.1.  Logistic regression: Prosocial chimpanzees ---------------------
data("chimpanzees")
d <- chimpanzees


# Recode treatment variables
d$treatment <- 1 + d$prosoc_left + 2 * d$condition
xtabs( ~ treatment + prosoc_left + condition , d )


# Consider individual difference of chimpanzees
m11.1 <- quap(
  alist(
    pulled_left ~ dbinom(1, p), 
    logit(p) <- a, 
    a ~ dnorm(0, 1.5)
  ), data = d
)

set.seed(1999)
prior <- extract.prior( m11.1 , n = 1e4 )
p <- inv_logit( prior$a )
dens( p , adj=0.1 )


# Consider treatment as well
m11.2 <- quap(
  alist(
    pulled_left ~ dbinom(1, p), 
    logit(p) <- a + b[treatment], 
    a ~ dnorm(0, 1.5), 
    b[treatment] ~ dnorm(0, 0.5)
  ), data = d
)

set.seed(1999)
prior <- extract.prior(m11.2, n = 1e4)
p <- sapply(1:4, function(k) inv_logit(prior$a + prior$b[, k]))
dens(abs(p[, 1] - p[, 2]), adj = 0.1)


# Using HMC
dat_list <- list(
  pulled_left = d$pulled_left, 
  actor = d$actor, 
  treatment = as.integer(d$treatment)
)

m11.4 <- ulam(
  alist(
    pulled_left ~ dbinom(1, p), 
    logit(p) <- a[actor] + b[treatment], 
    a[actor] ~ dnorm(0, 1.5), 
    b[treatment] ~ dnorm(0, 0.5)
  ), data = dat_list, chains = 4, log_lik = TRUE
)
precis(m11.4, depth = 2)

post <- extract.samples(m11.4)


# Individual tendency to pull left
p_left <- inv_logit(post$a)
precis( as.data.frame(p_left) )
plot( precis( as.data.frame(p_left) ), xlim = c(0, 1))


# Treatment effects
labs <- c("R/N", "L/N", "R/P", "L/P")
precis( m11.4 , depth=2 , pars="b" )
plot( precis( m11.4 , depth=2 , pars="b" ) , labels=labs )


# See contrasts
diffs <- list(
  db13 = post$b[,1] - post$b[,3],
  db24 = post$b[,2] - post$b[,4] 
  )
plot( precis(diffs) )


# Posterior prediction check


