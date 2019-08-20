#' Apply R code to each element of an nlist object. This can be used to derive new variables or create some missing data in the simulated data 
#' or in the results of the analyses.
#'
#' Derive new variables from the results of analyses
#' 
#' @param code A list of strings of R codes to modify the results.
#' @param monitor  A list of character vectors (or regular expression if a string) specifying the names of the stochastic nodes in code to include in the data. By default all stochastic nodes are included.
#' @param cases A list of strings specifying the cases for which to derive new variables
#' @param parallel An integer specifying the number of CPU cores to use for generating the datasets in parallel. Defaul is 1 (not parallel).
#' @param path A string specifying the path to the directory to save the data sets in. By default \code{path = NULL } the data sets are not saved but are returned as an nlists object.
#' @param silent A flag specifying whether to suppress warnings.

#' @return A flag.
#' @export
#'
#' @examples
#' simcases_derive()
#' simcases_derive(FALSE)
# simcases_derive <- function(x = TRUE) {
#   check_flag(x)
#   x
# }

# sims_derive(code = "b <- a + 1", path=...)

# simcases_derive(code = list(code1 = "b <- a + 1",
#                             code2 = "c <- a + 2"),
#                 cases = list(derived1 = "code1",
#                              derived2 = "code2),
#                 path=...,
#                 extract = function(x) x$samples)

