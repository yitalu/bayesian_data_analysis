## Content
maximum entropy distribution
link functions
generalized linear models

binomial regression
poisson regression
multinomial and categorical models

over-dispersion
zero-inflated and zero-augmented
ordered categorical



## Maximum entropy distribution

A maximum entropy distribution means a distribution that could happen with the greatest number of ways. Given some set of constraints (e.g., continuous or discrete, count result or not, ordinal or not, bounded or not, etc.), we choose the maximum entropy distributions when modeling because they are the least informative distributions and the most likely distribution naturally.

For example, when there are only two possible outcomes of an event, the outcomes have no order (flipping a coin), and the expected number of each outcome is assumed constant, the maximum entropy distribution is the binomial distribution.


## Link functions

A link function convert a linear equation, like $\alpha + \beta X$, into a non-linear space. There are two very common link functions: logit and log.

The logit link function transform a linear equation into a parameter space between zero and one (a s-shape function). The log link function transform a linear combination into positive real values (a exponentially increasing function).

