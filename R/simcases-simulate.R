#' Simulate data from various models.
#'
#' Simulate data from various models. Results are saved to disk.
#' 
#' The arguments \code{code}, \code{constants}, \code{parameters}, \code{monitor}, \code{stochastic}, \code{latent} and \code{nsims} will only be used if not specified within \code{models}.
#' 
#' @param models A data frame or an object that becomes a data frame when \code{fun} is applied. 
#' The data frame contains character strings that refer to objects defined within \code{environment}. 
#' Each row defines a model. 
#' The header may contain: code, constants, parameters, monitor, stochastic, latent and/or nsims
#' @param code A string of the JAGS or R code to generate the data.
#' The JAGS code must not be in a data or model block.
#' @param constants An nlist object (or list that can be coerced to nlist)
#' specifying the values of nodes in code.
#' The values are included in the output dataset.
#' @param parameters An nlist object (or list that can be coerced to nlist)
#' specifying the values of nodes in code.
#' The values are not included in the output dataset.
#' @param monitor A character vector (or regular expression if a string)
#' specifying the names of the nodes in code to include in the dataset.
#' By default all nodes are included.
#' @param stochastic A logical scalar specifying whether to monitor
#' deterministic and stochastic (NA), only deterministic (FALSE)
#' or only stochastic nodes (TRUE).
#' @param latent A logical scalar specifying whether to monitor
#' observed and latent (NA), only latent (TRUE)
#' or only observed nodes (FALSE).
#' @param nsims A whole number between 1 and 1,000,000 specifying
#' the number of data sets to simulate. By default 100 data sets are simulated.
#' @param path A string specifying the path to the directory to save the data sets in.
#' @param exists A flag specifying whether the `path` directory should already exist
#' (if `exists = NA` it doesn't matter).
#' @param rdists A character vector specifying the R functions to recognize as stochastic.
#' The seed should be specified using [base::set.seed()].
#' @param ask A flag specifying whether to ask before deleting sims compatible files.
#' @param silent A flag specifying whether to suppress warnings.
#' @param environment The environment in which the objects described in \code{cases} were defined.
#' @param fun A function to convert \code{cases} to a data frame.
# @param nsims If specified, overwrites n.sims in \code{cases}. A vector of integers specifying the number of data sets to simulate for each case. By default 100 data sets are simulated for each case.
# @param exists A flag specifying whether the directory should already exist. If \code{exists = NA} it doesn't matter. If the directory already exists it is overwritten if \code{exists = TRUE} or \code{exists = NA} otherwise an error is thrown.
# @param silent A flag specifying whether to suppress warnings.
#' @param ... Unused.
#' @seealso [sims::simulate()]
#' @export
#'
#' @examples
#' 
#' normal <- "a ~ dnorm(0, 1/sigma^2)"
#' sigma1 <- list(sigma=1)
#' sigma2 <- list(sigma=2)
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
                         code = "",
                         constants = nlist::nlist(),
                         parameters = nlist::nlist(),
                         monitor = ".*",
                         stochastic = TRUE,
                         latent = FALSE,
                         nsims = 1,
                         path = ".",
                         exists = FALSE,
                         rdists = sims_rdists(),
                         ask = getOption("sims.ask", TRUE),
                         silent = FALSE,
                         environment=parent.frame(), 
                         fun=function(x) read.table(
                           text=gsub(";|,| |:|\t|\\||&|~", "\t", 
                                     readLines(textConnection(x))),
                           header=TRUE),
                         ...) {
  
  if(is.data.frame(models)) fun = identity
  models_list <- args_to_list(models = models,
                           environment=environment,
                           fun=fun)
  chk_list(models_list)
  for(model.id in 1:length(models_list)){
    chk_all(names(models_list[[model.id]]) %in% names(formals(sims::sims_simulate)), 
            chk_true)
  }
  
  args.global <- list(code=code, constants=constants, parameters=parameters, monitor=monitor, 
                      stochastic=stochastic, latent=latent, nsims=nsims, exists=exists, 
                      rdists=rdists, ask=ask, silent=silent)
  args.global <- args.global[setdiff(names(args.global), names(models_list[[1]]))]
  models_list <- lapply(models_list, append, values=args.global)
  
  apply_sims_to_cases(sma_fun = sims::sims_simulate,
                 models_list = models_list,
                 path=path,
                 ...)
}
