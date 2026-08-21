#' Plots the fitted model against original data.
#'
#' Requires:
#' - R/plot.R
#'
#' Relies on output from:
#' - scripts/1_model_fitting.R

# functions --------------------------------------------------------------
source("R/plot.R")

# libraries --------------------------------------------------------------
library(ggplot2)

# config -----------------------------------------------------------------
cfg <- config::get(file = "config.yml") # load config file

# loading model ----------------------------------------------------------
model <- readRDS(paste0(cfg$PATH$MODEL, "/fitted_model.rds")) # load fitted model object
message("Fitted model loaded from ", cfg$PATH$MODEL, "/fitted_model.rds")

# plot model --------------------------------------------------------------
p <- plot(model)

# save plot --------------------------------------------------------------
ggsave(
  p,
  filename = paste0(cfg$PATH$FIGURE, "/fitted_model_plot.png"),
  width = cfg$PLOT$WIDTH,
  height = cfg$PLOT$HEIGHT
)
message(
  "Fitted model plot saved to ",
  cfg$PATH$FIGURE,
  "/fitted_model_plot.png"
)
