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
config = config::get(file = "config.yaml") # load config file

# generate data ----------------------------------------------------------
covariate = rnorm(
  config$normal$n_samples,
  mean = config$normal$mean,
  sd = config$normal$std_dev
)
response = rnorm(
  config$normal$n_samples,
  mean = covariate,
  sd = config$regression$noise
) +
  config$regression$slope * covariate
data = data.frame(
  covariate = covariate,
  response = response
)

# fit model ---------------------------------------------------------------
model = fit(data)
saveRDS(model, "outputs/models/fitted_model.rds") # save fitted model object

# plot model --------------------------------------------------------------
p = plot(model)
print(p)
ggsave(
  p,
  filename = "outputs/figures/fitted_model_plot.png",
  width = config$plot$width,
  height = config$plot$height
) # save plot
