# Ch5. Multiple Regression
# Key message: multiple regressions reveal spurious correlations (5.1) and masked relationships (5.2)
# Key words: spurious correlations, unrevealed correlations, confounds, multiple causation, causal inference, categorical variables, graphical causal models


# 5.1 Spurious Association
# 5.2 Masked Relationship
# 5.3 Categorical Variables

rm(list = ls())
library("rethinking")
library("rstan")


# 5.1 Spurious Association ------------------------------------------------


data(WaffleDivorce)
d <- WaffleDivorce
colnames(d)

d$D <- standardize(d$Divorce)
d$M <- standardize(d$Marriage)
d$A <- standardize(d$MedianAgeMarriage)
# note: the standardize function in the rethinking package makes a variable zero-centered with standard deviation one.

# 5.1.1 Directed Acyclic Graphs
# DAGs are the "assumed" relationships between variables.

# 5.1.1 Directed Acyclic Graphs -------------------------------------------


# 5.1.2 Testable Implications ---------------------------------------------
# Conditional independencies as testable implications.
# Once you have a couple of DAGs, you can generate testable implication(s) and test the conditional independencies with statistical models. And this is where the multiple regression comes in.





# 5.1.3 Multiple Regression Notation --------------------------------------
# Just like before


# 5.1.4 Approximating the Posterior ---------------------------------------
# Effect of one variable is gone after controling for another variable.

# 5.1.5 Plotting Multivariate Posteriors
# 5.1.5.1 predictor residual plots
# 5.1.5.2 posterior prediction plots
# relational plot of the observed outcome and predicted outcome

# 5.1.5.3 counterfactual plots
# visualize the predicted effect of manipulating one variable on another




# 5.2 Masked Relationship -------------------------------------------------






# 5.3 Categorical Variables -----------------------------------------------

# 5.3.1 Binary Categories -------------------------------------------------
# Distinguish between indicator variable and index variable. Use index variable approach since none of the variables has more prior uncertainty.


# 5.3.2 Many Categories ---------------------------------------------------
# When there are more than two categories