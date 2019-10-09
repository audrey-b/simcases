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
#' #' sigma1 = nlist(sigma=1)
#' #' sigma2 = nlist(sigma=2)
#' #' smc_set_cases("code    constants", 
#' #'               "normal  sigma1
#' #'                normal  sigma2")
#' 
#' smc_set_cases <- function(header, cases) {
#'   chk_string(header)
#'   chk_string(cases)
#'   header_vector <- as.vector(string_to_matrix(header))
#'   chk_vector(header_vector); 
#'   cases_matrix <- string_to_matrix(cases)
#'   list_cases <- split(t(cases_matrix), rep(1:ncol(cases_matrix), each = nrow(cases_matrix)))
#'   if(nrow(cases_matrix)>1){
#'     list_cases <- lapply(list_cases, as.list)
#'     for(i in 1:length(list_cases)) names(list_cases[[i]]) <- header_vector
#'   }
#'   if(nrow(cases_matrix)==1) names(list_cases) <- header_vector
#'   
#'   #chk_all(names(list(...)) %in% methods::formalArgs(fun), chk_true)
#'   list_cases <- rapply(list_cases, get, how="replace")
#'   return(list_cases)
#' }
