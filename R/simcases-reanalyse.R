#' Reanalyse some datasets (might be done through analyse?)
#'
#' Reanalyse some datasets in the case of convergence failure or unexpected errors.
#' 
#' @param data A
#' @param models A 
#' @param cases A flag specifying whether to return TRUE or FALSE.
#' @param parallel An integer specifying the number of CPU cores to use for generating the datasets in parallel. Defaul is 1 (not parallel).
#' @param path A string specifying the path to the directory to save the data sets in. By default \code{path = NULL } the data sets are not saved but are returned as an nlists object.
#' @param exists A flag specifying whether the analyses should already exist. If \code{exists = NA} it doesn't matter. If the directory already exists it is overwritten if \code{exists = TRUE} or \code{exists = NA} otherwise an error is thrown.
#' @param silent A flag specifying whether to suppress warnings.

#' @return A flag.
#' @export
#'
#' @examples
#' smc_reanalyse()
#' smc_reanalyse(FALSE)
# smc_reanalyse <- function(x = TRUE) {
#   check_flag(x)
#   x
# }
# 
