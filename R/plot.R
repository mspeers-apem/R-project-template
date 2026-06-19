#' Function to take lm object and plot using ggplot, with original points overlaid
#'
#' Requires:
#' - R/libs.R

source("R/libs.R")
required = c("ggplot2") 
libs(required)

plot = function(model){
  #'@param model A fitted linear model object (from lm function).
  #'@return A ggplot object with the fitted line and original data points.
  
  # type checking
  if (!inherits(model, "lm")) {
    stop("Input model must be a fitted linear model object.")
  }

  # extract data from the model
  data = model$model

  # create the plot
  p = ggplot(data, aes(x = covariate, y = response)) +
    geom_point() +  # original data points
    geom_abline(intercept = coef(model)[1], slope = coef(model)[2], color = "red") +  # fitted line from model
    labs(title = "Fitted Linear Model", x = "Covariate", y = "Response") +
    theme_minimal()

  return(p)
}