#' A function to fit a linear model with one covariate

fit = function(
  data
){
  #'@param data A data frame containing the variables in the model. Must include a response column and a covariate column.
  #'@return Fitted model object.
  
  # type checking
  if (!is.data.frame(data)) {
    stop("Input data must be a data frame.")
  }

  # check if data has the required columns
  if (!all(c("response", "covariate") %in% colnames(data))) {
    stop("Data must contain 'response' and 'covariate' columns.")
  }

  # fit the linear model
  model = lm(response ~ covariate, data = data)

  return(model)
}

