library(rethinking)

# 6.2 Post-Treatment Bias -------------------------------------------------
# Simultaneity. One of the included variable bias.

# Considering a post-treatment variable into your model can fool you into 1) thinking the treatment doesn't work, e.g., mistakenly include fungus into your model (6.2.1), or 2) thinking the treatment does work, e.g., mistakenly include fungus when moisture is unobserved (6.2.2).