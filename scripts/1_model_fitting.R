#' Script to generate example data then fit a linear model. Plots the fitted model against original data.
#' 
#' Requires:
#' - R/fit.R
#' - R/plot.R

rm(list = ls())  # clear workspace

# functions --------------------------------------------------------------
source("R/fit.R")
source("R/plot.R")

# generate data ----------------------------------------------------------
covariate = rnorm(100, mean = 5, sd = 2)
response = rnorm(100, mean = 0, sd = 1) + 0.5 * covariate
data = data.frame(
  covariate = covariate,
  response = response
)

# fit model ---------------------------------------------------------------
model = fit(data)
saveRDS(model, "outputs/models/fitted_model.rds")  # save fitted model object

# plot model --------------------------------------------------------------
p = plot(model)
print(p)
ggsave(p, filename = "outputs/figures/fitted_model_plot.png", width = 6, height = 4)  # save plot



