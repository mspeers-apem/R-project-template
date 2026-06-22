#' Script to generate example data then fit a linear model. Plots the fitted model against original data.
#'
#' Requires:
#' - R/fit.R
#' - R/plot.R
#' - R/libs.R

rm(list = ls()) # clear workspace

# functions --------------------------------------------------------------
source("R/fit.R")
source("R/plot.R")
source("R/libs.R")

# libraries --------------------------------------------------------------
required = c("config", "ggplot2")
libs(required)

# config -----------------------------------------------------------------
cfg = config::get(file = "config.yaml") # load config file
set.seed(cfg$seed) 

# generate data ----------------------------------------------------------
covariate = rnorm(
  cfg$normal$NSAMPLES,
  mean = cfg$normal$MEAN,
  sd = cfg$normal$STDDEV
)
response = rnorm(
  cfg$normal$NSAMPLES,
  mean = covariate,
  sd = cfg$regression$NOISE
) +
  cfg$regression$SLOPE * covariate
data = data.frame(
  covariate = covariate,
  response = response
)

saveRDS(data, "data/simulated_data.rds") # save simulated data

# fit model ---------------------------------------------------------------
model = fit(data)
saveRDS(model, "outputs/models/fitted_model.rds") # save fitted model object

# plot model --------------------------------------------------------------
p = plot(model)
print(p)
ggsave(
  p,
  filename = "outputs/figures/fitted_model_plot.png",
  width = cfg$plot$WIDTH,
  height = cfg$plot$HEIGHT
) # save plot
