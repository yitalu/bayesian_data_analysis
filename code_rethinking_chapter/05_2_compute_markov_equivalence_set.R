# Statistical Rethinking 2E p.153
# compuate Markov Equivalence set
library(dagitty)
dag5.7 <- dagitty(
    "dag{
        M -> K <- N
        M -> N
    }"
)

coordinates(dag5.7) <- list( x=c(M=0,K=1,N=2) , y=c(M=0.5,K=1,N=0.5) )
MElist <- equivalentDAGs(dag5.7)

drawdag(MElist)