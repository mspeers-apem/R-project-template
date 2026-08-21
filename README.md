# R Template Repository

This is a simple template repository for R projects. See `HELP.md` for advice on using the template.

## Overview

This project contains a simple example of generating synthetic data, fitting a linear model, and then plotting the result.

The workflow:

- Simulates synthetic data.
- Fits linear model.
- Plots visualisation of linear model over synthetic data.

## Project Structure

```text
TEMPLATE/
├── data/
│   └── simulated_data.rds
│
├── docs/
│   └── report.txt
│
├── logs/
│   ├── 1_model_fitting.log
│   └── 2_model_plotting.log
│
├── outputs/
│   ├── figures/
│   │   └── fitted_model_plot.png
│   │
│   └── models/
│       └── fitted_model.rds
│
├── R/
│   ├── fit.R
│   ├── libs.R
│   └── plot.R
│
├── renv/
│   ├── library/
│   └── staging/
│
├── scripts/
│   ├── 1_model_fitting.R
│   └── 2_model_plotting.R
│
├── .gitignore
├── .Rprofile
├── activate.R
├── config.yaml
├── HELP.md
├── README.md
├── renv.lock
└── settings.json
```

## Requirements

The project requires:

- R (>= 4.3.0)
- RStudio or Positron 

### Required Packages

```r
install.packages(c(
  "config",
  "ggplot2",
))

```
Or, use `renv::restore()`.

## Configuration

Project settings are stored in:

```text
config.yml
```

This file contains:

- Input data paths
- Random seed
- Random sample parameters
- Plot settings

## Input Data

The following datasets are required:

| Dataset | Description |
|----------|-------------|
| Dataset #1 | Some sample locations |
| ... | ... |


## Workflow

Run scripts in the following order:

### 1. Model Fitting

```r
source("scripts/1_model_fitting.R")
```

Simulates synthetic data and fits an example linear model. Saves model fit to an .rds file.

### 2. Model Plotting

```r
source("scripts/2_model_plotting.R")
```

Reads in the fitted model and plots output. Saves plot as a .png.



## Outputs

The workflow produces:

### Models

- Linear model fitted to synthetic data
- ...

### Figures

- Visualisation of fitted trend over synthetic data
- ...
