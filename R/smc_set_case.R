#' #' Specify cases/scenarios
#' #'
#' #' Specify cases/scenarios
#' #' 
#' #' @param header A string to indicate which arguments are used to define cases
#' #' @param cases A string that defines cases in terms of the header. Each row represents a different case. Objects must be defined within the global environment.
#' 
#' #' @export
#' #'
#' #' @examples
#' #' normal = "a ~ dnorm(0, 1/sigma^2)"
#' #' sigma1 = list(sigma=1)
#' #' sigma2 = list(sigma=2)
#' #' smc_set_cases("code    constants", 
#' #'               "normal  sigma1
#' #'                normal  sigma2")
#' 