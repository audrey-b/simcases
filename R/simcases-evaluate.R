#' Calculates measures to evaluate the performance of the model
#'
#' Calculates measures to evaluate the performance of the model
#' The results are compared with the true parameter values by calculating performance measures 
#' such as bias, mean square error and coverage probability.
#' R code can be used to customize the performance measures
#' 
#' @param cases An object that becomes a data frame when \code{fun} is applied. The first row of the data frame is a header and each subsequent row defines a case using strings. The strings must refer to objects defined within \code{environment}.
#' @param setup An object that becomes a data frame when \code{fun} is applied. 
#' The first row of the data frame is a header and each subsequent row defines parameters to pass to \code{simanalyse::sma_evaluate} for each \code{case} using strings. 
#' The strings must refer to objects defined within \code{environment}.
#' @param measures A vector of strings indicating which performance measures to calculate. Strings may include "bias", "E" (expectation), 
#' "cpQuantile" (coverage probability of quantile-based CrIs of level \code{alpha}), "LQuantile" (length of quantile-based CrIs of level \code{alpha}),
#' "Epvar" (expected posterior variance), "Epsd" (expected posterior standard deviation), "rb" (relative 
#'  bias), "br" (bias ratio), "var" (variance), "se" (standard error), "mse" (root mean square error), "rmse" (root mean square error), 
#'  "rrmse" (relative root mean square error), "cv" (coefficient of variation), "all" (all the measures)
#' @param parameters An nlist object (or list that can be coerced to nlist). 
#' True values of parameters to be used to calculate the performance measures.
#' @param estimator A function, typically mean or median, for the Bayes estimator to use to calculate the performance measures.
#' @param alpha Scalar representing the alpha level used to construct credible intervals. Default is 0.05.
#' @param monitor A character vector (or regular expression if a string) specifying the names of the stochastic nodes in code to include in the summary. By default all stochastic nodes are included.
#' @param custom_funs A named list of functions to calculate over the mcmc samples. E.g. list(posteriormedian = median).
#' @param custom_expr_before A string of R code to derive custom measures. 
#' This code is used BEFORE averaging over all simulations. 
#' E.g. "mse = (posteriormedian - parameters)^2". 
#' Functions from \code{custom_funs} may be used as well as the keywords 'parameters' (the true values of the parameters) and 'estimator' (the estimator defined in \code{estimator}).
#' @param custom_expr_after A string of R code to derive additional custom measures. 
#' This code is used AFTER averaging over all simulations. E.g. "rmse = sqrt(mse)". 
#' Measures calculated from \code{custom_expr_before} may be used as well as the keyword 'parameters' (the true values of the parameters). 
#' @param progress A flag specifying whether to print a progress bar.
#' @param options The future specific options to use with the workers.

#' @param path A string specifying the path to the directory.
#' @param environment The environment in which the objects described in \code{cases} were defined.
#' @param fun A function to convert \code{models} and \code{cases} to data frames. Default is a function that converts a string to a data frame.
#' @param ... Unused
#' @return A flag.
#' @export
#'
#' @examples
#' normal <- "a ~ dnorm(0, 1/sigma^2)"
#' sigma1 <- list(sigma=1)
#' sigma2 <- list(sigma=2)
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
#' cases <- "sims analyse
#'           1    1
#'           2    2"
#' smc_analyse(models = models_analysis,
#'                      cases = cases,
#'                      path = tempdir())
#' setup = "parameters
#'          sigma1
#'          sigma2"
#' smc_evaluate(cases, setup, path = tempdir(), monitor="sigma")

smc_evaluate <- function(cases,
                         setup = NULL,
                         measures=c("bias", "mse", "cpQuantile"), 
                         estimator=mean, 
                         alpha=0.05,
                         parameters = NULL,
                         monitor=".*",
                         custom_funs=list(),
                         custom_expr_before="",
                         custom_expr_after="",
                         path = ".",
                         progress = FALSE,
                         options = furrr::future_options(),
                         environment=parent.frame(), 
                         fun=function(x) read.table(
                           text=gsub(";|,| |:|\t|\\||&|~", "\t", 
                                     readLines(textConnection(x))),
                           header=TRUE),
                         ...) {
  
  if(!is.data.frame(cases)) cases <- fun(cases)
  
  args.global <- list(measures=measures, estimator=estimator, alpha=alpha, parameters=parameters,
                      monitor=monitor, custom_funs=custom_funs, custom_expr_before=custom_expr_before,
                      custom_expr_after=custom_expr_after, progress=progress, options=options)
  
  if(!is.null(setup)){
    args_list <- args_to_list(models = setup,
                              environment=environment,
                              fun=fun)
    chk_list(args_list)
  
  for(model.id in 1:length(args_list)){#check that all arguments are from sma_evaluate
    chk_all(names(args_list[[model.id]]) %in% names(formals(simanalyse::sma_evaluate)), 
            chk_true)
    
  args.global <- args.global[setdiff(names(args.global), names(args_list[[1]]))]
    args_list <- lapply(args_list, append, values=args.global)
  }}else{args_list <- rep(list(args.global), nrow(cases))}
  

  apply_evaluate_to_cases(sma_fun = simanalyse::sma_evaluate,
                          setup = args_list,
                          cases=cases,
                          path=path,
                          fun=fun)
  
}
