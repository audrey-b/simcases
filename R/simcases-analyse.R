#' Analyse data across multiple case/scenario
#'
#' Analyse data across multiple case/scenario
#' 
#' @param code A list of strings of JAGS or R code to analyse the data. The code must not be in a data or model block.
#' @param append A list of strings of JAGS or R code to append at the end of CODE before analysing the data. This is useful for specifying priors seperately from the likelihood in JAGS.
#' @param sprintf_args A list of list of arguments to pass to sprintf to be applied to the appended code
#' @param funs A character vector of R functions to analyse the data.
#' @param args A list of list of arguments to be passed to the functions in funs.
#' @param monitor  A list of character vectors (or regular expression if a string) specifying the names of the stochastic nodes in code to include in the data. By default all stochastic nodes are included.
#' @param models A list of strings defining the models.
#' @param cases A list of strings defining the cases/scenarios to run. Each case is defined by a dataset and a model.
#' @param path A string specifying the path to the directory to save the data sets in. By default \code{path = NULL } the data sets are not saved but are returned as an nlists object.
#' @param exists A flag specifying whether the directory should already exist. If \code{exists = NA} it doesn't matter. If the directory already exists it is overwritten if \code{exists = TRUE} or \code{exists = NA} otherwise an error is thrown.
#' @param silent A flag specifying whether to suppress warnings.

#' @return A flag.
#' @export
#'
#' @examples
#' smc_analyse()
#' smc_analyse(FALSE)
# smc_analyse <- function(x = TRUE) {
#   check_flag(x)
#   x
# }
# 
