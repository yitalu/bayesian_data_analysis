
# 11.1.1.  Logistic regression: Prosocial chimpanzees ---------------------
data("chimpanzees")
d <- chimpanzees

d$treatment <- 1 + d$prosoc_left + 2 * d$condition
xtabs( ~ treatment + prosoc_left + condition , d )


m11.1 <- quap(
  alist(
    pulled_left ~ dbinom(1, p), 
    logit(p) <- a, 
    a ~ dnorm(0, 1.5)
  ), data = d
)

set.seed(1999)
prior <- extract.prior( m11.1 , n=1e4 )
p <- inv_logit( prior$a )
dens( p , adj=0.1 )
