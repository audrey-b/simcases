#' Specify a case/scenario
#'
#' Specify a case/scenario
#' 
#' @param fun A function for a case.
#' @param ... Arguments to pass to \code{function} for a case

#' @export
#'
#' @examples
#' smc_set_case(fun=sims::sims_simulate, 
#'              code = "a ~ dnorm(0, 1/sigma^2)",
#'              constants = nlist(sigma=1))

smc_set_case <- function(fun, ...) {
  chk_function(fun)
  chk_all(names(list(...)) %in% methods::formalArgs(fun), chk_true)
  
  return(list(...))
  
  }
