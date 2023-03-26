library(rethinking)

# 6.1 Multicollinearity ---------------------------------------------------
# Non-identifiability (omitted variable bias)

# Sometimes, two variables contain exactly the same information. Including both of them in a model may lead to confusion.

# Two examples from the text: 6.1.1 Multicollinear Legs, and 6.1.2 Multicollinear Milk.


# 6.1.1 Multicollinear Legs ----

# Simlulate 100 individuals' heights and leg lengths
N <- 100
set.seed(909)
height <- rnorm(N, mean = 10, sd = 2)
leg_prop <- runif(N, min = 0.4, max = 0.5)
leg_left <- height * leg_prop + rnorm(N, 0, 0.02)
leg_right <- height * leg_prop + rnorm(N, 0, 0.02)
d <- data.frame(height, leg_left, leg_right)

# To predict an individual's height using the length of his/her legs
m6.1 <- quap(
    alist(
        height ~ dnorm(mu, sigma), 
        mu <- a + bl * leg_left + br * leg_right, 
        a ~ dnorm(10, 100), 
        bl ~ dnorm(2, 10), 
        br ~ dnorm(2, 10), 
        sigma ~ dexp(1)
    ), data = d
)
precis(m6.1)
plot(precis(m6.1))

post <- extract.samples(m6.1)
plot( bl ~ br , post , col=col.alpha(rangi2,0.1) , pch=16 )
dens( post$bl + post$br , col=rangi2 , lwd=2 , xlab="sum of bl and br" )

m6.2 <- quap(
    alist(
        height ~ dnorm( mu , sigma ) ,
        mu <- a + bl*leg_left,
        a ~ dnorm( 10 , 100 ) ,
        bl ~ dnorm( 2 , 10 ) ,
        sigma ~ dexp( 1 )
    ) , data=d )
precis(m6.2)
plot(precis(m6.2))
mean(post$bl + post$br)




# 6.1.2 Multicollinear Milk ----

data(milk)
d <- milk
d$K <- standardize( d$kcal.per.g )
d$F <- standardize( d$perc.fat )
d$L <- standardize( d$perc.lactose )

pairs( ~ kcal.per.g + perc.fat + perc.lactose, data = d, col = rangi2)
