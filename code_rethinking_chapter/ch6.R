# Ch6. Multi-collinearity, Post-Treatment Bias, and Collider Bias
# Discusses hazards when adding variables to a regression

# 6.1 Multicollinearity
# 6.2 Post-Treatment Bias
# 6.3 Collider Bias
# 6.4 Confronting Confounding




# 6.1 Multicollinearity ---------------------------------------------------
# Non-identifiability (omitted variable bias)

# Sometimes, two variables contain exactly the same information. Including both of them in a model may lead to confusion.

# Two examples from the text: 6.1.1 Multicollinear Legs, and 6.1.2 Multicollinear Milk.



# 6.2 Post-Treatment Bias -------------------------------------------------
# Simultaneity. One of the included variable bias.

# Considering a post-treatment variable into your model can fool you into 1) thinking the treatment doesn't work, e.g., mistakenly include fungus into your model (6.2.1), or 2) thinking the treatment does work, e.g., mistakenly include fungus when moisture is unobserved (6.2.2).



# 6.3 Collider Bias -------------------------------------------------------
# Berkson's paradox, or the selection-distortion effect.

# Mistakenly include marriage (a collider) into your model leads to the conclusion that age is positively associated with happiness. A spurious association.

# Moreover, an unobserved variable (e.g., neighborhoods in the education and achievement example) can cause collider bias.

# You have to control for the unobserved variable to avoid this. (But how do we contorl for an unobserved variable?)





# 6.4 Confronting Confounding ---------------------------------------------

