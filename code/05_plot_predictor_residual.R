rm(list = ls())
library(rethinking)

data(WaffleDivorce)
d <- WaffleDivorce
View(d)

# standardize variables
d$D <- standardize( d$Divorce )
d$M <- standardize( d$Marriage )
d$A <- standardize( d$MedianAgeMarriage )


summary(lm(d$M ~ d$A))
cor(d$M, d$A)

# from page 135
m5.4 <- quap(
    alist(
        M ~ dnorm(mu, sigma), 
        mu <- a + bAM * A, 
        a ~ dnorm(0, 0.2), 
        bAM ~ dnorm(0, 0.5), 
        sigma ~ dexp(1)
    ), data = d
)

precis(m5.4)