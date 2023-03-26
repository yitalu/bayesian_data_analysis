# Ch7. Information Criteria

# 7.1 The Problem with Parameters
# 7.2 Entropy and Accuracy
# 7.3 Golem Taming: Regularization
# 7.4 Predicting Predictive Accuracy
# 7.5 Model Comparison

# Ockham's razor offers no guidance when it comes to trade-off between accuracy and simplicity. To avoid overfitting, underfitting, and confounding, we need two approaches: 1) regularizing prior (pnealized likelihood), and 2) information criterias, or cross-validation. They can be used in combination.




# 7.1 The Problem with Parameters -----------------------------------------

# Overfitting: accurate within-sample but inaccurate out-of-sample
# Underfitting: inaccurate both within-sample and out-of-sample





# 7.2 Entropy and Accuracy ------------------------------------------------

# 7.2.1 Firing the Weatherperson
# 7.2.2 Information and Uncertainty
# 7.2.3 From Entropy to Accuracy
# KL divergence

# 7.2.4 Estimating Divergence
# 7.2.5 Scoring the right data
# how deviance behaves



# 7.3 Golem Taming: Regularization ----------------------------------------
# Demonstrating with a simulation that making the model worse at fitting is one way to predict better. In other words, regularizing priors reduces overfitting. Just that the drawback is, a too skeptical prior prevent the model to learn from the data.



# 7.4 Predicting Predictive Accuracy --------------------------------------

# 7.4.1 Cross-validation (and Importance Weights Approach)
# 7.4.2 Information Criteria


