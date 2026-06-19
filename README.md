# Guidance for using template repository for R projects. 

## Overview

This repository is intended to provide general guidance on structuring R projects. There aren't any hard rules, but I've found that organising things in this way helps to make code more maintainable and expandable. 

The generic structure of the template is
```
TEMPLATE/
├── data/
├── docs/
├── outputs/
│   ├── figures/
│   └── models/
├── R/
│   └── libs.R
├── scripts/
├── .gitignore
├── config.yaml
└── README.md
```
and all other files contain examples of what's discussed here.

## 1: Function - script structure

The main idea of this template is to split the definition and execution of functions into separate files, like you would in an R package. This makes scripts more readable and reduces the need for copy and paste, since all of the main methods will be coded in a single place separate from analyses. It's also a lot easier to then find where you've coded a particular method (i.e., in a specific function file) and then change how the method is implemented. 

Functions go in the R/ folder (like in an R package). Some function files will just have a single function, and others will have a 'main' function and a selection of 'helper' functions which are used by the main function. For example, you might have a main function which fits a custom model, and a helper function which evaluates the log-likelihood. Your file would then look like this:

```R
#' A function to fit a model using maximum likelihood estimation.
fit_model = function(data){

    # more code

    optimise(log_likelihood(data))

    # more code

}

log_likelihood = function(data){

    # code

}

```

It's good to name files in the R/ folder with the same name as the main function in the file, so the above file would be called `fit_model.R`. It's also helpful to add a short descriptive docstring at the beginning of the file which explains what the main function does.

Scripts which execute these functions go in the scripts/ folder. These are where you actually use the functions defined in R/ to perform analyses. At the top of these scripts, it's good to give a docstring which describes what the script will do and then what functions it will use. For example your script might look like this:

```R
#' A script to fit a model and evaluate its performance.
#' Requires:
#'     - R/fit_model.R

# load functions
source("R/fit_model.R")

# load data
data = read.csv("data/data.csv")

# fit model
model = fit_model(data)
```

With this structure, it is easy to go in and modify portions of the code. For example, you could make a quick change to the likelihood function without having to scroll through a long analysis script or change the likelihood in multiple places. 

## 2 - Seperating pre-processing, analysis, and plotting

Functions and scripts should be separated by purpose, such as pre-processing, analysis, and plotting. This keeps methods modular and makes it easier to modify output. For example, you might have function files:

- R/process.R
- R/model.R
- R/plot.R

to be used in their respective scripts:

- scripts/1_data_processing.R
- scripts/2_model_fitting.R
- scripts/3_model_plotting.R.

Keeping each step modular in this way makes changing individual components easier. E.g., if you want to adjust plotting parameters you can modify the `plot.R` function file and then rerun the `3_model_plotting.R` script; this avoids needing to rerun the data processing and model fitting steps, and also makes it simpler to find the part you need to modify.

Of course, running code line-by-line would allow for changes to portions of the analysis; however, I've found that it's easier to make mistakes and lose track of what variables are defined. This leads onto the next section. 

## 3 - Clearing the environment

It is good practice to run scripts in a clean working environment. This can be done by running:

```r
rm(list = ls())
```
at the start of a script to clear the working environment. This helps avoid situations where variables from other scripts or previous script versions are still defined, which can lead to errors in analysis.

## 4 - Configuration file 

Some projects will have lots of hard-coded parameters. These values are difficult to keep track of if they are scattered throughout analysis scripts. The `config.yaml` file can be used to avoid this situation.

The `config.yaml` file allows you to define parameters in a single location and then reference them throughout your scripts. For example, say you want to specify the family used when fitting a GAM. You could write

```r
family = "cnorm"
fit = gam(data, family = family)
```
but then if you want to change the family you need to scroll to that line the analysis script. Additionally, if you want to change the family for multiple models, then you will need to copy and paste this change in multiple locations. 

Instead, you can add to `config.yaml`:

```yaml
default:
    gam:
        family: "cnorm"
```

and then in your script do

```r
library(config)
cfg = config::get()
fit = gam(data, family = cfg$gam$family)
```

now, changing the line in `config.yaml` to `family: "clognorm"` will change the GAM family for all model fits, in all scripts which use the config file.

This approach makes it much easier to keep track of and change any variables that need to be changed for simulation studies.

## 5 - Loading libraries

This template repository includes the `R/libs.R` function file, containing the function:

```R
libs = function(pkg){
  if (!is.character(pkg)) {
    stop("Input pkg must be a character vector of package names.")
  }

  new.pkg = pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}
```

Providing this function with a vector of required package names will install them (if not already installed) and then load them. For this to work, the packages must be on CRAN.

This helps other people when they first run the script, so they don't need to individually install required packages.

## 6 - Git advice

For general Git advice, I've found these resources helpful:

- [Command line help](https://git-scm.com/docs/gittutorial)
- [Positron/VScode help](https://code.visualstudio.com/docs/sourcecontrol/overview)

Particularly, the sections on managing branches and stashes contain good advice for managing conflicts when working with people on the same repository.