

MCMC convergence diagnostic
MCMC diagnostic criteria tells how well the sampling was

trace plot:

(1) stationarity, (2) good mixing, and (3) convergence


trace rank (trank) plot:

From the paper: Rank plots are histograms of the ranked posterior draws (ranked over all chains) plotted separately for each chain. If all of the chains are targeting the same posterior, we expect the ranks in each chain to be uniform, whereas if one chain has a different location or scale parameter, this will be reflected in the deviation from uniformity. If rank plots of all chains look similar, this indicates good mixing of the chains.

This plot was introduced by Aki Vehtari, Andrew Gelman, Daniel Simpson, Bob Carpenter, Paul-Christian Burkner (2019): Rank-normalization, folding, and localization: An improved R-hat for assessing convergence of MCMC. arXiv preprint https://arxiv.org/abs/1903.08008