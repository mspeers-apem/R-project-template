#' This script is an example of object oriented programming (OOP) using R6 classes.
#' 
#' It first loads in the Experiment and PlotExperiment class structures
#' 
#' The Experiment class structure contains all the functions needed to generate data and fit
#' the example model. Crucially, it also contains all the structure needed to use these functions
#' together in the "run_experiment" method. Notice how arguments such as 'data' do not need to be passed around
#' to the methods inside the class, as they can all be accessed from the class instance.
#' 
#' The PlotExperiment class takes an instance of the Experiment class and plots the fitted model. Crucially,
#' it data used to fit the model and the fitted model are all already contained in the Experiment class instance,
#' so don't need to be passed individually.

# read classes -----------------------------------------------------------
source("OOP/experiment.R")

# set parameter ----------------------------------------------------------
N = 1000

# instanciate and run experiemtn -----------------------------------------
experiment1 <- Experiment$new(N)
experiment1$run_experiment()

# instanciate and run plot -----------------------------------------------
plot1 <- ExperimentPlot$new(experiment1)
plot1$plot_experiment()
plot1$plot
