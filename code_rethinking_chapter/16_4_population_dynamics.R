# See also here for reference: https://bookdown.org/content/4857/generalized-linear-madness.html#population-dynamics

rm(list = ls())

library(rethinking)
data(Lynx_Hare)
View(Lynx_Hare)


# Plot Data ----
plot( 1:21 , Lynx_Hare[,3] , ylim = c(0,90) , xlab = "year", ylab="thousands of pelts" , xaxt="n" , type="l" , lwd=1.5 )
lines( 1:21 , Lynx_Hare[,2] , lwd=1.5 , col=rangi2 )

at <- c(1,11,21)
axis( 1 , at=at , labels=Lynx_Hare$Year[at] )

points( 1:21 , Lynx_Hare[,3] , bg="black" , col="white" , pch=21 , cex=1.4 )
points( 1:21 , Lynx_Hare[,2] , bg=rangi2 , col="white" , pch=21 , cex=1.4 )
text( 17 , 80 , "Lepus" , pos=2 )
text( 19 , 50 , "Lynx" , pos=2 , col=rangi2 )



# Build Scientific Model ----
sim_lynx_hare <- function( n_steps , init , theta , dt=0.002 ) {
    L <- rep(NA, n_steps)
    H <- rep(NA, n_steps)
    L[1] <- init[1]
    H[1] <- init[2]
    for ( i in 2:n_steps ) {
        H[i] <- H[i-1] + dt*H[i-1]*( theta[1] - theta[2]*L[i-1] )
        L[i] <- L[i-1] + dt*L[i-1]*( theta[3]*H[i-1] - theta[4] )
    }
    return( cbind(L,H) )
}



# Simulate from Scientific Model ----
theta <- c(0.5, 0.05, 0.025, 0.5)
z <- sim_lynx_hare(1e4, as.numeric(Lynx_Hare[1, 2:3]), theta)

plot( z[,2] , type="l" , ylim=c(0,max(z[,2])) , lwd=2 , xaxt="n" , ylab="number (thousands)" , xlab="" )
lines( z[,1] , col=rangi2 , lwd=2 )
mtext( "time" , 1 )



# Build Statistical Model ----
N <- 1e4
Ht <- 1e4 # assumed population of hares

p <- rbeta(N, 2, 18) # assumed trapping rate
dens(p) # around mean value 10%

h <- rbinom( N , size=Ht , prob=p ) # N samples of caught hares count
h <- round( h/1000 , 2 ) # approximated in pelts
dens( h , xlab="thousand of pelts" , lwd=2 )

data(Lynx_Hare_model)
cat(Lynx_Hare_model) # see the Stan code

dat_list <- list(
    N = nrow(Lynx_Hare), 
    pelts = Lynx_Hare[,2:3]
)

m16.5 <- stan( model_code=Lynx_Hare_model , data=dat_list , chains=3 , cores=3 , control=list( adapt_delta=0.95 ) )



# Posterior predictions ----

# pelt (observed) level
post <- extract.samples(m16.5)
pelts <- dat_list$pelts
plot( 1:21 , pelts[,2] , pch=16 , ylim=c(0,120) , xlab="year" , ylab="thousands of pelts" , xaxt="n" )
at <- c(1,11,21)
axis( 1 , at=at , labels=Lynx_Hare$Year[at] )
points( 1:21 , pelts[,1] , col=rangi2 , pch=16 )
# 21 time series from posterior
for ( s in 1:21 ) {
    lines( 1:21 , post$pelts_pred[s,,2] , col=col.alpha("black",0.2) , lwd=2 )
    lines( 1:21 , post$pelts_pred[s,,1] , col=col.alpha(rangi2,0.3) , lwd=2 )
}
# text labels
text( 17 , 90 , "Lepus" , pos=2 )
text( 19 , 50 , "Lynx" , pos=2 , col=rangi2 )

# population (unobserved) levels
plot( NULL , pch=16 , xlim=c(1,21) , ylim=c(0,500) , xlab="year" , ylab="thousands of animals" , xaxt="n" )
at <- c(1,11,21)
axis( 1 , at=at , labels=Lynx_Hare$Year[at] )
for ( s in 1:21 ) {
    lines( 1:21 , post$pop[s,,2] , col=col.alpha("black",0.2) , lwd=2 )
    lines( 1:21 , post$pop[s,,1] , col=col.alpha(rangi2,0.4) , lwd=2 )
}
