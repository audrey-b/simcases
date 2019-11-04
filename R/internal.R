list_args <- function(models,
                      cases=NA,
                      environment=parent.frame(), 
                      fun=function(x) read.table(
                        text=gsub(";|,| |:|\t|\\||&|~", "\t", 
                                  readLines(textConnection(x))),
                        header=TRUE)) {
  
  if(is.na(cases)) NULL
  
  dataframe <- fun(models)
  chk_s3_class(dataframe, "data.frame")
  model_header <- colnames(dataframe)
  model_matrix <- as.matrix(dataframe)
  list_model <- split(t(model_matrix), rep(1:nrow(model_matrix), each = ncol(model_matrix)))
  if(nrow(model_matrix)>1){
    list_model <- lapply(list_model, as.list)
    for(i in 1:length(list_model)) names(list_model[[i]]) <- model_header
  }
  if(nrow(model_matrix)==1) names(list_model) <- model_header
  return(rapply(list_model, get, how="replace", envir=environment))
}

apply_sims_to_cases <- function(sma_fun,
                                models_list,
                                path = ".",
                                ...) {
  
  if(mean(summary(models_list)[,"Mode"] == "list")==1){
    output <- list()
    for(sims.id in 1:length(models_list)){
      newpath = file.path(path, paste0("sims", sims.id))
      if(!dir.exists(newpath)) dir.create(newpath, recursive=TRUE)
      output[[sims.id]] <- do.call(sma_fun, append(models_list[[sims.id]], list(save=TRUE, path=newpath, ...)))
    }
  }else output <- do.call(sma_fun, append(models_list, list(save=TRUE, path=path, ...)))
  return(output)
}

apply_simanalyse_to_cases <- function(sma_fun,
                                      models_list,
                                      cases,
                                      path = ".",
                                      fun = fun,
                                      ...) {
  
  cases <- fun(cases)
  
  if(mean(summary(models_list)[,"Mode"] == "list")==1){
    output <- list()
    for(sims.id in cases$sims){
      for(model.id in cases$model){
        newpath = file.path(path, paste0("sims", sims.id))
        if(!dir.exists(newpath)) dir.create(newpath, recursive=TRUE)
        do.call(sma_fun, append(models_list[[model.id]], list(path=newpath, ...)))
      }}}else output <- do.call(sma_fun, append(models_list, list(path=path, ...))) #need to work this line
  return(output)
}
