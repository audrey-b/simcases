apply_to_cases <- function(sma_fun,
                           models,
                           cases=NA,
                           path = ".",
                           environment=parent.frame(), 
                           fun=function(x) read.table(
                             text=gsub(";|,| |:|\t|\\||&|~", "\t", 
                                       readLines(textConnection(x))),
                             header=TRUE),
                           ...) {
  
  if(is.na(cases)) NULL
  
  dataframe <- fun(models)
  chk_s3_class(dataframe, "data.frame")
  model_header <- colnames(dataframe)
  model_matrix <- as.matrix(dataframe)
  list_model <- split(t(model_matrix), rep(1:ncol(model_matrix), each = nrow(model_matrix)))
  if(nrow(model_matrix)>1){
    list_model <- lapply(list_model, as.list)
    for(i in 1:length(list_model)) names(list_model[[i]]) <- model_header
  }
  if(nrow(model_matrix)==1) names(list_model) <- model_header
  
  model <- rapply(list_model, get, how="replace", envir=environment)
  
  chk_list(model)
  for(case.id in 1:length(model)){
    chk_all(names(model[[case.id]]) %in% methods::formalArgs(sma_fun), chk_true)
  }
  
  if(mean(summary(model)[,"Mode"] == "list")==1){
    output <- list()
    for(case.id in 1:length(model)){
      newpath = file.path(path, paste0("case", case.id), "sims")
      if(!dir.exists(newpath)) dir.create(newpath, recursive=TRUE)
      output[[case.id]] <- do.call(sma_fun, append(model[[case.id]], list(save=TRUE, path=newpath, ...)))
    } }else output <- do.call(sma_fun, append(model, list(save=TRUE, path=path, ...)))
  return(output)
}



# string_to_matrix <- function(str){
#   as.matrix(read.table(text=gsub(";|,| |:|\t|\\||&|~", 
#                                  "\t", 
#                                  readLines(textConnection(str)))))
# }
# 
# extract_from_case <- function(x, component){
#   wch <- which(names(component) %in% x)
#   if(length(wch)==0) return(nlist())
#   else return(component[wch][[names(component)[wch]]])
# }
# 
# extract_from_cases <- function(cases, index, component){
#   
#   cases_matrix <- cases %>% 
#     unlist %>%  
#     string_to_matrix
#   
#   extracted <- extract_from_case(cases_matrix[index,], component)
#   
#   return(extracted)
# }
# 
# simulate_no_parallel <- function(code, 
#                                  constants, 
#                                  parameters,
#                                  monitor,
#                                  cases,
#                                  nsims,
#                                  silent){
#   
#   sim_data <- as.vector(NULL)
#   
#   for(i in 1:length(cases)){
#     
#     if(length(monitor)==1 & monitor[[1]][1]==".*") monitor_xtract <- ".*"
#     else monitor_xtract <- extract_from_cases(cases, i, monitor)
#     
#     sim_data[[i]] <- sims_simulate(code = extract_from_cases(cases, i, code),
#                                    constants = extract_from_cases(cases, i, constants),
#                                    parameters = extract_from_cases(cases, i, parameters),
#                                    monitor = monitor_xtract,
#                                    nsims = nsims[i],
#                                    silent=silent)}
#   
#   return(sim_data)
# }