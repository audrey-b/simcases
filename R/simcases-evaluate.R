#' Calculates measures to evaluate the performance of the model
#'
#' Calculates measures to evaluate the performance of the model
#' The results are compared with the true parameter values by calculating performance measures 
#' such as bias, mean square error and coverage probability.
#' R code can be used to customize the performance measures
#' 
#' @param args An object that becomes a data frame when \code{fun} is applied. The first row of the data frame is a header and each subsequent row defines parameters to pass to \code{simanalyse::sma_evaluate} for each \code{case} using strings. The strings must refer to objects defined within \code{environment}.
#' @param cases An object that becomes a data frame when \code{fun} is applied. The first row of the data frame is a header and each subsequent row defines a case using strings. The strings must refer to objects defined within \code{environment}.
#' @param path A string specifying the path to the directory.
#' @param environment The environment in which the objects described in \code{cases} were defined.
#' @param fun A function to convert \code{models} and \code{cases} to data frames. Default is a function that converts a string to a data frame.
#' @param ... Other arguments from \code{simanalyse::sma_evaluate}
#' 
#' @return A flag.
#' @export
#'
#' @examples
#' normal <- "a ~ dnorm(0, 1/sigma^2)"
#' sigma1 <- nlist(sigma=1)
#' sigma2 <- nlist(sigma=2)
#' models_sims <- "code   parameters
#'                 normal sigma1
#'                 normal sigma2"
#' smc_simulate(models = models_sims,
#'                   path = tempdir(), 
#'                   exists = NA, 
#'                   ask = FALSE,
#'                   nsims = 2)
#' prior1 = "sigma ~ dunif(0, 4)"
#' prior2 = "sigma ~ dunif(0, 5)"
#' models_analysis <- "code    code.add
#'                     normal  prior1
#'                     normal  prior2"
#' cases <- "sims model
#'           1    1
#'           2    2"
#' smc_analyse(models = models_analysis,
#'                      cases = cases,
#'                      path = tempdir())
#' args = "parameters
#'         sigma1
#'         sigma2"
#' smc_evaluate(args, cases, path = tempdir(), monitor="sigma")

smc_evaluate <- function(args,
                        cases, 
                        path = ".",
                        environment=parent.frame(), 
                        fun=function(x) read.table(
                          text=gsub(";|,| |:|\t|\\||&|~", "\t", 
                                    readLines(textConnection(x))),
                          header=TRUE),
                        ...) {
  
args_list <- args_to_list(models = args,
                            environment=environment,
                            fun=fun)
chk_list(args_list)

for(model.id in 1:length(args_list)){#check that all arguments are from sma_evaluate
  chk_all(names(args_list[[model.id]]) %in% methods::formalArgs(simanalyse::sma_evaluate), 
          chk_true)
}

apply_evaluate_to_cases(sma_fun = simanalyse::sma_evaluate,
                          args = args_list,
                          cases=cases,
                          path=path,
                          fun=fun,
                          ...)

}
