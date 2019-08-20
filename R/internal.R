string_to_matrix <- function(str){
  as.matrix(read.table(text=gsub(";|,| |:|\t|\\||&|~", 
                                 "\t", 
                                 readLines(textConnection(str)))))
}

extract_from_case <- function(x, component){
  wch <- which(names(component) %in% x)
  if(length(wch)==0) return(nlist())
  else return(component[wch][[names(component)[wch]]])
}

extract_from_cases <- function(cases, index, component){
  
  cases_matrix <- cases %>% 
    unlist %>%  
    string_to_matrix
  
  extracted <- extract_from_case(cases_matrix[index,], component)
  
  return(extracted)
}

simulate_no_parallel <- function(code, 
                                 constants, 
                                 parameters,
                                 monitor,
                                 cases,
                                 nsims,
                                 silent){
  
  sim_data <- as.vector(NULL)
  
  for(i in 1:length(cases)){
    
    if(length(monitor)==1 & monitor[[1]][1]==".*") monitor_xtract <- ".*"
    else monitor_xtract <- extract_from_cases(cases, i, monitor)
    
    sim_data[[i]] <- sims_simulate(code = extract_from_cases(cases, i, code),
                                   constants = extract_from_cases(cases, i, constants),
                                   parameters = extract_from_cases(cases, i, parameters),
                                   monitor = monitor_xtract,
                                   nsims = nsims[i],
                                   silent=silent)}
  
  return(sim_data)
}