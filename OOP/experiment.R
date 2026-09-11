library(R6)
library(ggplot2)

cfg <- config::get(file = "config.yml")

Experiment <- R6Class(
  "Experiment",

  public = list(
    N = NULL,
    data = NULL,
    model = NULL,

    initialize = function(N) {
      stopifnot(
        is.numeric(N),
        length(N) == 1,
        N > 0
      )

      self$N <- N
    },

    run_experiment = function() {
      set.seed(cfg$SEED)
      private$generate_data()
      private$fit_model()
    }
  ),

  private = list(
    generate_data = function() {
      covariate <- rnorm(
        self$N,
        mean = cfg$NORMAL$MEAN,
        sd = cfg$NORMAL$STDDEV
      )
      response <- rnorm(
        self$N,
        mean = covariate,
        sd = cfg$REGRESSION$NOISE
      ) +
        cfg$REGRESSION$SLOPE * covariate
      self$data <- data.frame(
        covariate = covariate,
        response = response
      )
    },

    fit_model = function() {
      self$model <- lm(response ~ covariate, data = self$data)
    }
  )
)

ExperimentPlot <- R6Class(
  "ExperimentPlot",

  public = list(
    experiment = NULL,
    plot = NULL,

    initialize = function(experiment) {
      if (!inherits(experiment, "Experiment")) {
        stop()
      }

      self$experiment <- experiment
    },

    plot_experiment = function() {
      self$plot <- ggplot(
        self$experiment$model$model,
        aes(x = covariate, y = response)
      ) +
        geom_point() +
        geom_abline(
          intercept = coef(self$experiment$model)[1],
          slope = coef(self$experiment$model)[2],
          color = "red"
        ) +
        labs(title = "Fitted Linear Model", x = "Covariate", y = "Response") +
        theme_minimal()
    }
  )
)
