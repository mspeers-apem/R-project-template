#' Script which deletes example files in the template repository, and then itself.
#' This allows creation of a new repository from the template without having to manually delete the example files.

# define example files ---------------------------------------------------
example_files <- c(
  "OOP/*",
  "logs/*",
  "docs/*",
  "data/*",
  "outputs/*",
  "scripts/*",
  "R/*"
)

# check happy to delete files in working location ------------------------
working_dir <- getwd()
cat("Current working directory is:", working_dir, "\n")
cat("Are you happy to delete the example files in this location? (yes/no): ")
response <- tolower(readLines(con = stdin(), n = 1))
if (response != "yes") {
  stop("Aborting deletion of example files.")
}

# delete example files ---------------------------------------------------
for (file in example_files) {
  unlink(file, recursive = TRUE)
}
cat("Example files deleted successfully.\n")
