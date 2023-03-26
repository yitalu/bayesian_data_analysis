library(rethinking)

# 6.3 Collider Bias -------------------------------------------------------
# Berkson's paradox, or the selection-distortion effect.

# Mistakenly include marriage (a collider) into your model leads to the conclusion that age is positively associated with happiness. A spurious association.

# Moreover, an unobserved variable (e.g., neighborhoods in the education and achievement example) can cause collider bias.

# You have to control for the unobserved variable to avoid this. (But how do we contorl for an unobserved variable?)