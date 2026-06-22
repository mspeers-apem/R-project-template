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
library(config) 
library(ggplot2)

# config -----------------------------------------------------------------
cfg = config::get(file = "config.yaml") # load config file
set.seed(cfg$SEED) 

# generate data ----------------------------------------------------------
covariate = rnorm(
  cfg$NORMAL$NSAMPLES,
  mean = cfg$NORMAL$MEAN,
  sd = cfg$NORMAL$STDDEV
)
response = rnorm(
  cfg$NORMAL$NSAMPLES,
  mean = covariate,
  sd = cfg$REGRESSION$NOISE
) +
  cfg$REGRESSION$SLOPE * covariate
data = data.frame(
  covariate = covariate,
  response = response
)

saveRDS(data, paste0(cfg$PATH$DATA, "/simulated_data.rds")) # save simulated data

# fit model ---------------------------------------------------------------
model = fit(data)
saveRDS(model, paste0(cfg$PATH$MODEL, "/fitted_model.rds")) # save fitted model object

# plot model --------------------------------------------------------------
p = plot(model)
print(p)
ggsave(
  p,
  filename = paste0(cfg$PATH$FIGURE, "/fitted_model_plot.png"),
  width = cfg$PLOT$WIDTH,
  height = cfg$PLOT$HEIGHT
) # save plot
