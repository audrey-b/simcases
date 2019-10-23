#' Analyse Datasets for multiple cases/scenarios using Bayesian methods
#'
#' Analyse Datasets for multiple cases/scenarios using Bayesian methods. Results are saved to disk.
#' 
#@param header A string to indicate which arguments are used to define cases
#' @param models An object that becomes a data frame when \code{fun} is applied. The first row of the data frame is a header and each subsequent row defines a case using strings. The strings must refer to objects defined within \code{environment}.
#' @param cases An object that becomes a data frame when \code{fun} is applied. The first row of the data frame is a header and each subsequent row defines a case using strings. The strings must refer to objects defined within \code{environment}.
#' @param path A string specifying the path to the directory.
#' @param environment The environment in which the objects described in \code{cases} were defined.
#' @param fun A function to convert \code{models} and \code{cases} to data frames.
# @param nsims If specified, overwrites n.sims in \code{cases}. A vector of integers specifying the number of data sets to simulate for each case. By default 100 data sets are simulated for each case.
# @param exists A flag specifying whether the directory should already exist. If \code{exists = NA} it doesn't matter. If the directory already exists it is overwritten if \code{exists = TRUE} or \code{exists = NA} otherwise an error is thrown.
# @param silent A flag specifying whether to suppress warnings.
#' @param ... Other arguments of \code{sims::sims_simulate}

#' @export
#'
# @examples
# 
# normal <- "a ~ dnorm(0, 1/sigma^2)"
# sigma1 <- nlist(sigma=1)
# sigma2 <- nlist(sigma=2)
# models_sims <- "name   code   constants
#                 sims1  normal sigma1
#                 sims2  normal sigma2"
# simcases_simulate(models = models_sims,
#                   path = tempdir(), 
#                   exists = NA, 
#                   ask = FALSE,
#                   nsims = 2)
# models_analyse <- "name   code   
#                    model1 normal
#                    model2 normal"
# cases <- "name sims model
#           case1 sims1 model1
#           case2 sims2 model2"
# smc_analyse_bayesian(models = models
#                      cases = cases,
#                      path = tempdir())

smc_analyse_bayesian <- function(models,
                                 cases, 
                              path = ".",
                              environment=parent.frame(), 
                              fun=function(x) read.table(
                                text=gsub(";|,| |:|\t|\\||&|~", "\t", 
                                          readLines(textConnection(x))),
                                header=TRUE),
                              ...) {

  # apply_to_cases(sma_fun = simanalyse::sma_analyse_bayesian,
  #                models=models,
  #                cases=cases,
  #                path=path,
  #                environment=environment,
  #                fun=fun,
  #                ...)
}
