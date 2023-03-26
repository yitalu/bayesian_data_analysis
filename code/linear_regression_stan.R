# Build a linear regression model with Stan
# reference: https://youtu.be/UQtFkEOg9SM


data(iris)
head(iris)

versicolor <- which(iris$Species == 'versicolor')
x <- iris$Sepal.Length[versicolor]
y <- iris$Petal.Length[versicolor]

data <- list(N = length(x), x = x, y = y)
require(rstan)

fit <- stan(file = "./code_sample/linear_regression_stan.stan", data = data)

summary(fit)

plot(y ~ x)
params <- extract(fit)
alpha <- mean(params$alpha)
beta <- mean(params$beta)
abline(a = alpha, b = beta)

xr <- seq(4, 7.5, 0.1)
ci_function <- function(k) {
    quantile(params$beta * k + params$alpha, probs = c(0.05, 0.95))
}
yCI <- sapply(xr, ci_function)

lines(xr, yCI[1, ], col="red")
lines(xr, yCI[2, ], col="red")

fit <- stan(file = "./code_sample/linear_regression_stan.stan", data = data)

plot(density(y), xlim = c(2, 6.5), ylim = c(0, 1.4))
params <- extract(fit)
for (i in 1:10) {
   lines(density(params$y_sim[i, ]), col = "red")
}

y_new <- params$y_sim[20, ]
data_new <- list(N = length(x), x=x, y=y_new)
fit_new <- stan(file  = "./code_sample/linear_regression_stan.stan", data = data_new)

params_new <- extract(fit_new)
plot(density(params$alpha))
lines(density(params_new$alpha), col = "red")
plot(density(params$beta))
lines(density(params_new$beta), col = "red")