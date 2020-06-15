#' Analyse Datasets for multiple cases/scenarios using Bayesian methods
#'
#' Analyse Datasets for multiple cases/scenarios using Bayesian methods. Results are saved to disk.
#' 
#@param header A string to indicate which arguments are used to define cases
#' @param models A data frame or an object that becomes a data frame when \code{fun} is applied. The data frame contains character strings that refer to objects defined within \code{environment}. Each row is a different case/scenario. The header may contain: code, code.add, code.values, monitor, inits, mode and/or deviance.
#' @param cases A data frame or an object that becomes a data frame when \code{fun} is applied. The header must be "sims analyse" and the data frame contains integers (1,2,3,...) that refer to specific combinations of data and analyses. Each row is a different case/scenario.
#' @param code A string of code to analyse the data. JAGS code must not be in a data or model block.
#' @param code.add A string of code to add at the end of \code{code} before analysing the data. This is useful for adding priors to the likelihood.
#' @param code.values A character vector to replace all instances of "?" in the model. This is useful for varying choices of distributions, e.g. for assessing sensitivity to the choice of priors.
#' @param monitor A character vector (or regular expression if a string) specifying the names of the stochastic nodes to output from the analysis. By default all stochastic nodes are included.
#' @param inits A list or a function. Initial values for the MCMC chains. If specifying a function, it should either have no arguments, or have a single argument named chain. In the latter case, the supplied function is called with the chain number as argument. In this way, initial values may be generated that depend systematically on the chain number.
#' @param mode A list obtained from sma_set_mode which sets the parameters of the mcmc sampling.
#' @param deviance A flag. Indicates whether to monitor deviance for future DIC calculation.
# @param pD A flag. Indicates whether to monitor pD for future DIC calculation.
# @param path.save A string specifying the path to the directory to save the results. By default path = NULL the results are not saved but are returned as a list of nlists objects.
#' @param path A string specifying the path to the directory.
#' @param progress A flag specifying whether to print a progress bar.
#' @param options The future specific options to use with the workers.
#' @param environment The environment in which the objects described in \code{cases} were defined.
#' @param fun A function to convert \code{models} and \code{cases} to data frames.
# @param nsims If specified, overwrites n.sims in \code{cases}. A vector of integers specifying the number of data sets to simulate for each case. By default 100 data sets are simulated for each case.
# @param exists A flag specifying whether the directory should already exist. If \code{exists = NA} it doesn't matter. If the directory already exists it is overwritten if \code{exists = TRUE} or \code{exists = NA} otherwise an error is thrown.
# @param silent A flag specifying whether to suppress warnings.
#' @param ... Other arguments from \code{simanalyse::sma_analyse}

#' @export
#'
#' @examples
#' 
#' normal <- "a ~ dnorm(0, 1/sigma^2)"
#' sigma1 <- list(sigma=1)
#' sigma2 <- list(sigma=2)
#' all <- ".*"
#' models_sims <- "code   constants
#'                 normal sigma1
#'                 normal sigma2"
#' smc_simulate(models = models_sims,
#'                   path = tempdir(), 
#'                   exists = NA, 
#'                   ask = FALSE,
#'                   nsims = 2)
#' models_analysis <- "code   monitor  
#'                     normal all
#'                     normal all"
#' cases <- "sims analyse
#'           1    1
#'           2    2"
#' smc_analyse(models = models_analysis,
#'                      cases = cases,
#'                      path = tempdir())

smc_analyse <- function(models,
                        cases, 
                        code="",
                        code.add="",
                        code.values=NULL,
                        monitor = ".*",
                        inits=list(),
                        mode=sma_set_mode("report"),
                        deviance = TRUE,
                        path = ".",
                        progress = FALSE,
                        options = furrr::future_options(seed = TRUE),
                        environment=parent.frame(), 
                        fun=function(x) read.table(
                          text=gsub(";|,| |:|\t|\\||&|~", "\t", 
                                    readLines(textConnection(x))),
                          header=TRUE),           ...) {
  
  if(is.data.frame(models)) fun = identity

    models_list <- args_to_list(models = models,
                              environment=environment,
                              fun=fun)
  chk_list(models_list)
  for(model.id in 1:length(models_list)){
    chk_all(names(models_list[[model.id]]) %in% names(formals(simanalyse::sma_analyse)), 
            chk_true)
  }
  
  args.global <- list(code=code, code.add=code.add, code.values=code.values, monitor=monitor, inits=inits, mode=mode, deviance=deviance)
  args.global <- args.global[setdiff(names(args.global), names(models_list[[1]]))]
  models_list <- lapply(models_list, append, values=args.global)
  
  apply_simanalyse_to_cases(sma_fun = simanalyse::sma_analyse,
                            models_list = models_list,
                            cases=cases,
                            path=path,
                            fun=fun,
                            ...)
  
}
