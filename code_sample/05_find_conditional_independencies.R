rm(list = ls())
library(dagitty)
library(ggdag)

# example from page 131 of Statistical Rethinking

DMA_dag1 <- dagitty('dag{ D <- A -> M -> D }')
impliedConditionalIndependencies(DMA_dag1)

DMA_dag2 <- dagitty('dag{ D <- A -> M }')
impliedConditionalIndependencies(DMA_dag2)

DMA_dag3 <- dagify(M ~ A, D ~ A + M)
ggdag(DMA_dag3)