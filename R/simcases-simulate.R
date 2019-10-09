#' Simulate Datasets for multiple cases/scenarios
#'
#' Simulate Datasets for multiple cases/scenarios
#' 
#' @param cases A list of cases obtained with smc_set_cases
# @param nsims If specified, overwrites n.sims in \code{cases}. A vector of integers specifying the number of data sets to simulate for each case. By default 100 data sets are simulated for each case.
# @param path A string specifying the path to the directory to save the data sets in. By default \code{path = NULL } the data sets are not saved but are returned as an nlists object.
# @param exists A flag specifying whether the directory should already exist. If \code{exists = NA} it doesn't matter. If the directory already exists it is overwritten if \code{exists = TRUE} or \code{exists = NA} otherwise an error is thrown.
# @param silent A flag specifying whether to suppress warnings.

#' @export
#'
#' @examples
#' 
#' code <- "a ~ dnorm(0, 1/sigma^2)"
#' case1 <- smc_set_case(fun=sims::sims_simulate, 
#'              code = code,
#'              constants = nlist(sigma=1))
#' case2 <- smc_set_case(fun=sims::sims_simulate, 
#'              code = code,
#'              constants = nlist(sigma=2))         
#' simcases_simulate(cases = list(case1, case2))

simcases_simulate <- function(cases) {
  
  chk_list(cases)
  for(case.id in 1:length(cases)){
    #chk_function(cases[[case.id]]$fun)
    #chk_equal(cases[[case.id]]$fun, sims::sims_simulate)
    chk_all(names(cases[[case.id]]) %in% methods::formalArgs(sims::sims_simulate), chk_true)
  }
  
  if(mean(summary(cases)[,"Mode"] == "list")==1){
  output <- list()
  for(case.id in 1:length(cases)){
    output[[case.id]] <- do.call(sims_simulate, cases[[case.id]])
  } }else output <- do.call(sims_simulate, cases)
  return(output)
}
