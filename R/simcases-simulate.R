#' Simulate Datasets for multiple cases/scenarios
#'
#' Simulate Datasets for multiple cases/scenarios
#' 
#' @param code A list of strings of JAGS or R code to generate the data. The code must not be in a data or model block.
#' @param constants A list of nlists objects specifying the values of nodes in code. The values are included in the output data.
#' @param parameters A list of nlist objects specifying the values of nodes in code. The values are not included in the output data.
#' @param monitor  A list of character vectors (or regular expression if a string) specifying the names of the stochastic nodes in code to include in the data. By default all stochastic nodes are included.
#' @param cases A list of strings specifying the cases for which data shall be simulated.
#' @param nsims A vector of integers specifying the number of data sets to simulate for each case. By default 100 data sets are simulated for each case.
#' @param parallel An integer specifying the number of CPU cores to use for generating the datasets in parallel. Defaul is 1 (not parallel).
#' @param path A string specifying the path to the directory to save the data sets in. By default \code{path = NULL } the data sets are not saved but are returned as an nlists object.
#' @param exists A flag specifying whether the directory should already exist. If \code{exists = NA} it doesn't matter. If the directory already exists it is overwritten if \code{exists = TRUE} or \code{exists = NA} otherwise an error is thrown.
#' @param silent A flag specifying whether to suppress warnings.

#' @return A flag.
#' @export
#'
#' @examples
#' simcases_simulate(code = list(code = "a ~ dnorm(0, 1/sigma^2)"),
#'                   constants = list(const1 = nlist(sigma=1), 
#'                                  const2 = nlist(sigma=5)),
#'                   cases = list(data1 = "code const1",
#'                              data2 = "code const2"))

simcases_simulate <- function(code, 
                              constants = list(nlist()), 
                              parameters = list(nlist()), 
                              monitor = list(".*"), 
                              cases = list(""), 
                              nsims, 
                              parallel = 1, 
                              path = NULL, 
                              exists = FALSE, 
                              silent = FALSE) {
  check_list(code)
  lapply(code, check_chr)
  check_list(constants)
  lapply(constants, check_nlist)
  check_list(parameters)
  lapply(parameters, check_nlist)
  check_list(monitor)
  lapply(monitor, check_character)
  check_list(cases)
  if(!is.null(path)) check_string(path)
  
  #if(!isFALSE(parallel)) .NotYetUsed("parallel")
  #if(!isFALSE(path)) .NotYetUsed("path")
  if(!isFALSE(exists)) .NotYetUsed("exists")
  if(!isFALSE(silent)) .NotYetUsed("silent")
  
  if(missing(nsims)) nsims = rep(getOption("sims.nsims", 100L), length(cases))
  check_numeric(nsims, coerce = TRUE)
  sapply(nsims, check_pos_int, coerce = TRUE)
  
  nsims <- sapply(nsims, as.integer)
  
  if(parallel==1){
    simulate_no_parallel(code, 
                         constants, 
                         parameters,
                         monitor,
                         cases,
                         nsims,
                         silent) %>% return()}}
