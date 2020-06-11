#' Simulate Datasets for multiple cases/scenarios
#'
#' Simulate Datasets for multiple cases/scenarios. Results are saved to disk.
#' 
#@param header A string to indicate which arguments are used to define cases
#' @param models An object that becomes a data frame when \code{fun} is applied. The first row of the data frame is a header and each subsequent row defines a model using strings. The strings must refer to objects defined within \code{environment}.
# @param cases A vector of models to run based on model names. If NA all models are run.
#' @param path A string specifying the path to the directory to save the datasets.
#' @param environment The environment in which the objects described in \code{cases} were defined.
#' @param fun A function to convert \code{cases} to a data frame.
# @param nsims If specified, overwrites n.sims in \code{cases}. A vector of integers specifying the number of data sets to simulate for each case. By default 100 data sets are simulated for each case.
# @param exists A flag specifying whether the directory should already exist. If \code{exists = NA} it doesn't matter. If the directory already exists it is overwritten if \code{exists = TRUE} or \code{exists = NA} otherwise an error is thrown.
# @param silent A flag specifying whether to suppress warnings.
#' @param ... Other arguments from \code{sims::sims_simulate}

#' @export
#'
#' @examples
#' 
#' normal <- "a ~ dnorm(0, 1/sigma^2)"
#' sigma1 <- nlist(sigma=1)
#' sigma2 <- nlist(sigma=2)
#' smc_simulate("code parameters,
#'                    normal sigma1
#'                    normal sigma2",
#'                    path = tempdir(), 
#'                    exists = NA, 
#'                    ask = FALSE)
#' smc_simulate(tibble::tribble(
#'                    ~code, ~parameters,
#'                    "normal", "sigma1",
#'                    "normal", "sigma2"),
#'                    fun = identity,
#'                    path = tempdir(), 
#'                    exists = NA, 
#'                    ask = FALSE)


smc_simulate <- function(models = models, 
                              path = ".",
                              environment=parent.frame(), 
                              fun=function(x) read.table(
                                text=gsub(";|,| |:|\t|\\||&|~", "\t", 
                                          readLines(textConnection(x))),
                                header=TRUE),
                              ...) {
  
  models_list <- args_to_list(models = models,
                           environment=environment,
                           fun=fun)
  chk_list(models_list)
  for(model.id in 1:length(models_list)){
    chk_all(names(models_list[[model.id]]) %in% methods::formalArgs(sims::sims_simulate), 
            chk_true)
  }

  apply_sims_to_cases(sma_fun = sims::sims_simulate,
                 models_list = models_list,
                 path=path,
                 ...)
}
