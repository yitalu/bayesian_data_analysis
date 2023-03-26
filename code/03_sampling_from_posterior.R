
# Grid approximation of the globe tossing
p_grid <- seq(from = 0, to = 1, length.out = 1000)
prob_p <- rep(1, 1000)
prob_data <- dbinom(6, size = 9, prob = p_grid)
posterior <- prob_data * prob_p
posterior <- posterior / sum(posterior)

plot(posterior)


samples <- sample(x = p_grid, size = 1e4, replace = TRUE, prob = posterior)

plot(samples)

library(rethinking)
dens(samples)
