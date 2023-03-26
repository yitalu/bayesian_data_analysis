library(rethinking)

# simulate weight from height
sim_weight <- function(H, b, sd) {
  U <- rnorm(length(H), 0, sd)
  W = b * H + U
  return(W)
}

sim_weight(173, 0.5, 10)
H <- runif(1e4, min = 150, max = 200)
W <- sim_weight(H, 0.4, 3)
dens(W, adj = 0.1)

plot( W ~ H, col = 2, lwd = 1)



set.seed(93)
H <- runif(1, 130, 170)
W <- sim_weight( H=H , b=0.5 , sd=10 )

beta_seq <- seq( from=0 , to=1 , len=11 )
post <- compute_post(W,H,a=0,b=beta_seq,sigma=10)
