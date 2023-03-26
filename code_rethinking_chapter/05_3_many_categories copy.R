library(rethinking)

data(milk)
d <- milk
str(d)
d$clade

d$clade_id <- as.integer(d$clade)

