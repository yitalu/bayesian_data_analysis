# Introduction to data.table
# https://github.com/Rdatatable/data.table#getting-started
# https://cran.r-project.org/web/packages/data.table/vignettes/datatable-intro.html

# Examples produced by example(data.table)
# https://rdatatable.gitlab.io/data.table/reference/data.table.html#examples

rm(list = ls())

# Load Packages and Data ----
library(data.table)
d <- fread("https://raw.githubusercontent.com/Rdatatable/data.table/master/vignettes/flights14.csv")
# d <- fread("./data/flights14.csv")

# check data
colnames(d)
str(d)
dim(d)

# 1. Basics ----
# 1.a Create data table ----
dt <- data.table(ID = 1:6, a = c("apple", "banana", "cherry", "duck", "elephant", "frog"), b = 7:12, c = 13:18)
str(dt)


# 1.c Subset rows in i ----
d[origin == "JFK" & month == 6]
d[1:2]

# sort data by column "origin" in ascending order
d[order(origin)]

# sort data by column "origin" in descending order
d[order(-origin)]

# sort data by columns "origin" in ascending and "dest" in descending order
d[order(origin, -dest)]


# 1.d Select column(s) in j

# select as a vector
d[, arr_delay]

# select as a data.table
d[, list(arr_delay)]

# .() is equivalent to list()
d[, .(arr_delay)]

# select two columns
d[, .(arr_delay, dep_delay)]

# create/rename column()




d[, .(sum(dep_delay), mean(arr_delay))]

d[arr_delay > dep_delay & origin == "JFK", month, with = FALSE]

d[, .(dep_delay, arr_delay)]
(d[, sum((dep_delay + arr_delay) < 0)])

d[, .(delay_d = dep_delay, delay_a = arr_delay)]


d[, .(.N), by = .(origin)]

