library(rethinking)
library(psych)
library(data.table)
data(milk)
d <- milk
str(d)

d$kcal.per.g
d$mass
d$neocortex.perc

dens(d$kcal.per.g) # > 0
dens(d$neocortex.perc) # 0 - 100
dens(d$mass) # > 0

d$K <- standardize( d$kcal.per.g )
d$N <- standardize( d$neocortex.perc )
d$M <- standardize( log(d$mass) )

dens(d$K)
dens(d$N)
dens(d$M)


x <- seq(-10, 10, 0.1)
plot(dexp(x) ~ x)

m5.5_draft <- quap(
    alist(
        K ~ dnorm(mu, sigma), 
        mu <- a + bN * N, 
        a ~ dnorm(mean = 0, sd = 1), 
        bN ~ dnorm(mean = 0, sd = 1), 
        sigma ~ dexp(1)
    ), data = d
)

# Got error message:
# Error in quap(alist(K ~ dnorm(mu, sigma), mu <- a + bN * N, a ~ dnorm(mean = 0,  : initial value in 'vmmin' is not finite
# The start values for the parameters were invalid. This could be caused by missing values (NA) in the data or by start values outside the parameter constraints. If there are no NA values in the data, try using explicit start values.

# There is a lot of NA in d$neocortex.perc; do the complete case analysis instead:

dcc <- d[complete.cases(d$K, d$N, d$M), ]

m5.5 <- quap(
    alist(
        K ~ dnorm(mu, sigma), 
        mu <- a + bN * N, 
        a ~ dnorm(mean = 0, sd = 0.2), 
        bN ~ dnorm(mean = 0, sd = 0.5), 
        sigma ~ dexp(1)
    ), data = dcc
)

prior <- extract.prior(m5.5)
xseq <- c(-2, 2)
mu <- link(m5.5, post = prior, data = list(N = xseq))

plot(NULL, xlim = xseq, ylim = xseq, ylab = "Energy (kilocal per g, std)", xlab = "Neocortex Percentage (std)")
for (i in 1:50) {
   lines(xseq, mu[i, ], col = col.alpha("black", 0.3))
}

precis(m5.5)

xseq <- seq(min(dcc$N) - 0.15, max(dcc$N) + 0.15, length.out = 30)
mu <- link(m5.5, data = list(N = xseq))
mu_mean <- apply(mu, 2, mean)
mu_PI <- apply(mu, 2, PI)
plot(K ~ N, data = dcc)
lines(xseq, mu_mean, lwd = 2)
shade(mu_PI, xseq)


cor(d$K, d$N)
cor(dcc$K, dcc$N)
cor(dcc$K, dcc$M)
plot(dcc$K ~ dcc$N)
plot(dcc$K, dcc$M)

pairs(~ K + M + N , dcc)
pairs.panels(as.data.table(dcc)[, .(K, M, N)])


