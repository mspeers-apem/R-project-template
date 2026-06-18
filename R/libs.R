#' function to install and load a list of packages

libs = function(pkg){
  #'@param pkg list of packages to install and load
  
  # type checking
  if (!is.character(pkg)) {
    stop("Input pkg must be a character vector of package names.")
  }

  new.pkg = pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}