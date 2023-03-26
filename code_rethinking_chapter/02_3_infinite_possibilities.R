# Now simulate posterior predictive distribution

post_samples <- rbeta(1e4, 6 + 1, 3 + 1)
pred_post <- sapply(post_samples, function(p) sum(sim_globe(p, 10) == "W"))
tab_post <- table(pred_post)
for (i in 0:10) lines(c(i, i), c(0, tab_post[i + 1]), lwd = 4, col = 4)

post_samples <- rbeta( 1e3 , 6+1 , 3+1 )
precis(post_samples)

dens(post_samples, lwd = 4, col = 2, xlab = "proportion water", adj = 0.1)
curve(dbeta(x, 6+1, 3+1), add = TRUE, lty = 2, lwd = 3)
lines(c(0.64, 0.64), c(0, dbeta(0.64, 7, 4)), lwd = 3) # mean
lines(c(0.4, 0.4), c(0, dbeta(0.4, 7, 4)), lwd = 3) # lower
lines(c(0.84, 0.84), c(0, dbeta(0.84, 7, 4)), lwd = 3) # upper

