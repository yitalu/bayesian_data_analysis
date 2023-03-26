# Generative simulation

# Function to toss a globe covered p by water N times
sim_globe <- function(p = 0.7, N = 9) {
   sample(c("W", "L"), size = N, prob = c(p, 1 - p), replace = TRUE)
}

sim_globe()
replicate(sim_globe(p = 0.5, N = 9), n = 10)



# Test the simulation on extreme settings
sim_globe(p = 1, N = 11)
sum(sim_globe(p = 0.5, N = 1e4) == "W") / 1e4



# Function to compute posterior distribution
compute_posterior <- function(the_sample, poss = c(0, 0.25, 0.5, 0.75, 1)) {
    W <- sum(sample == "W") # number of W observed
    L <- sum(sample == "L") # number of L observed
    ways <- sapply(poss, function(q) (q * 4)^W * ((1 - q) * 4)^L)
    post <- ways / sum(ways)
    # bars <- sapply(post, function(q) make_bar(q))
    # data.frame(poss, ways, post = round(post, 3), bars)
    data.frame(poss, ways, post = round(post, 3))
}

compute_posterior(sim_globe(p = 0.8, N = 14))