#' Runs all scripts in order using parameters specified in config file.
#'
#' The function run_script() will run a script with optional arguments, and save the output to a log file.
#' If a script fails, the wrapper will stop execution and print an error message.
#' 
#' To modify this script for your project, you need to change the run_script() calls at the bottom of this file.

# set up and run script function -----------------------------------------
scripts_dir <- file.path(getwd(), "scripts")
logs_dir <- file.path(getwd(), "logs")

run_script <- function(script, args = character()) {
  #' Run an R script with optional arguments.
  #' @param script The name of the R script to run.
  #' @param args A character vector of arguments to pass to the script.
  #' @return None. Stops execution if the script fails.

  script_path <- file.path(scripts_dir, script)

  message("Running ", script, "...")

  result <- system2(
    command = file.path(R.home("bin"), "Rscript.exe"),
    args = c(shQuote(script_path), args),
    stdout = file.path(
      logs_dir,
      paste0(tools::file_path_sans_ext(basename(script)), ".log")
    ),
    stderr = file.path(
      logs_dir,
      paste0(tools::file_path_sans_ext(basename(script)), ".log")
    )
  )

  if (result != 0) {
    stop(
      sprintf(
        "Script failed: %s (exit code %s)",
        script,
        result
      ),
      call. = FALSE
    )
  }
}
 
# Run Scripts ------------------------------------------------------------
run_script("1_model_fitting.R") # First, generate example data and fit a linear model
run_script("2_model_plotting.R") # Second, plot the fitted model against original data

message("All scripts completed successfully.")
