#' Script to generate example data then fit a linear model.
#'
#' Requires:
#' - R/fit.R

# functions --------------------------------------------------------------
source("R/fit.R")

# config -----------------------------------------------------------------
cfg <- config::get(file = "config.yml") # load config file
set.seed(cfg$SEED)

# generate data ----------------------------------------------------------
message("Generating simulated data...")
covariate <- rnorm(
  cfg$NORMAL$NSAMPLES,
  mean = cfg$NORMAL$MEAN,
  sd = cfg$NORMAL$STDDEV
)
response <- rnorm(
  cfg$NORMAL$NSAMPLES,
  mean = covariate,
  sd = cfg$REGRESSION$NOISE
) +
  cfg$REGRESSION$SLOPE * covariate
data <- data.frame(
  covariate = covariate,
  response = response
)
saveRDS(data, paste0(cfg$PATH$DATA, "/simulated_data.rds")) # save simulated data
message("Simulated data saved to ", cfg$PATH$DATA, "/simulated_data.rds")

# fit model ---------------------------------------------------------------
message("Fitting model...")
model <- fit(data)
saveRDS(model, paste0(cfg$PATH$MODEL, "/fitted_model.rds")) # save fitted model object
message("Fitted model saved to ", cfg$PATH$MODEL, "/fitted_model.rds")
