# Statistical Rethinking p.152 Overthinking

# M -> K <- N
# M -> N
n <- 100
M <- rnorm(n)
N <- rnorm(n, M)
K <- rnorm(n, N - M)
d_sim <- data.frame(K=K, M=M, N=N)

# M -> K <- N
# N -> M
n <- 100
N <- rnorm( n )
M <- rnorm( n , N )
K <- rnorm( n , N - M )
d_sim2 <- data.frame(K=K,N=N,M=M)

# M -> K <- N
# M <- U -> N
n <- 100
U <- rnorm( n )
N <- rnorm( n , U )
M <- rnorm( n , U )
K <- rnorm( n , N - M )
d_sim3 <- data.frame(K=K,N=N,M=M)