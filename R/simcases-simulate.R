#' Simulate Datasets for multiple cases/scenarios
#'
#' Simulate Datasets for multiple cases/scenarios
#' 
#' @param header A string to indicate which arguments are used to define cases
#' @param cases A string that defines cases in terms of the header. Each row represents a different case. Objects must be defined within the global environment.
#' @param environment The environment in which the objects were defined.
# @param nsims If specified, overwrites n.sims in \code{cases}. A vector of integers specifying the number of data sets to simulate for each case. By default 100 data sets are simulated for each case.
# @param path A string specifying the path to the directory to save the data sets in. By default \code{path = NULL } the data sets are not saved but are returned as an nlists object.
# @param exists A flag specifying whether the directory should already exist. If \code{exists = NA} it doesn't matter. If the directory already exists it is overwritten if \code{exists = TRUE} or \code{exists = NA} otherwise an error is thrown.
# @param silent A flag specifying whether to suppress warnings.

#' @export
#'
#' @examples
#' 
#' normal <- "a ~ dnorm(0, 1/sigma^2)"
#' sigma1 <- nlist(sigma=1)
#' sigma2 <- nlist(sigma=2)
#' simcases_simulate("code constants",
#'                        "normal sigma1
#'                         normal sigma2")

simcases_simulate <- function(header, cases, environment=parent.frame()) {
  
  chk_string(header)
  chk_string(cases)
  header_vector <- as.vector(string_to_matrix(header))
  chk_vector(header_vector); 
  cases_matrix <- string_to_matrix(cases)
  list_cases <- split(t(cases_matrix), rep(1:ncol(cases_matrix), each = nrow(cases_matrix)))
  if(nrow(cases_matrix)>1){
    list_cases <- lapply(list_cases, as.list)
    for(i in 1:length(list_cases)) names(list_cases[[i]]) <- header_vector
  }
  if(nrow(cases_matrix)==1) names(list_cases) <- header_vector
  
  #chk_all(names(list(...)) %in% methods::formalArgs(fun), chk_true)
  cases <- rapply(list_cases, get, how="replace", envir=environment)

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
