library(rethinking)

data(Howell1)
d <- Howell1
str(d)

d$sex <- ifelse(d$male == 1, 2, 1) # male: 2; female: 1
str(d$sex)

m5.8 <- quap(
    alist(
        height ~ dnorm(mu, sigma), 
        mu <- a[sex], 
        a[sex] ~ dnorm(178, 20), 
        sigma ~ dunif(0, 50)
    ), data = d
)
precis(m5.8, depth = 2)

post <- extract.samples(m5.8)
post$diff_fm <- post$a[, 1] - post$a[, 2]
precis(post, depth = 2)