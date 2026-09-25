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

# delete example files ---------------------------------------------------
for (file in example_files) {
  unlink(file, recursive = TRUE)
}
