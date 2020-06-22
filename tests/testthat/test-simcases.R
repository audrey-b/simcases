context("simcases")

test_that("test",{
  tempdir <- file.path(tempdir(), "simstest")
  unlink(tempdir, recursive = TRUE)
  dir.create(tempdir)

  constants  <- list(T = 4,                       #number of release occasions
                   R = c(192, 154, 131, 184))   #number of releases

params_M0 <- list(p   = rep(0.5, 4),            #capture probability
                  phi = c(0.8, 0.7, 0.9, 0.8))  #survival probability

params_Mt <- list(p   = c(0.8, 0.5, 0.2, 0.5),  #capture probability
                  phi = c(0.8, 0.7, 0.9, 0.8))  #survival probability

code <- "
for(i in 1:T){
 #multinomial likelihood
 m[i,(i+1):(T+2)] ~ dmulti(q[i,(i+1):(T+2)], R[i])
 #multinomial probabilities
 q[i,(i+1)] = phi[i]*p[i]                              #diagonal
 for(j in 1:i){q[i,j] = 0}                             #lower triangle
 q[i,(T+2)] = 1-sum(q[i,1:(T+1)])}                     #never recaptured
for(i in 1:(T-1)){                                     #upper triangle
 for(j in (i+2):(T+1)){q[i,j] = prod(phi[i:(j-1)])*prod(1-p[i:(j-2)])*p[j-1]}}" 

priors_M0 <- "for(j in 1:T){
                p[j] = p0              #capture probability is constant
                phi[j] ~ dunif(0,1)}   #prior on survival probability
                
              p0 ~ dunif(0,1)" #prior on capture probability

priors_Mt <- "for(j in 1:T){
                p[j] ~ dunif(0,1)      #prior on capture probability
                phi[j] ~ dunif(0,1)}"  #prior on survival probability

models_simulate <- "code constants parameters 
                    code constants params_M0        #1st simulation model (M0)
                    code constants params_Mt"       #2nd simulation model (Mt)

monitor_M0 <- c("phi", "p0")
monitor_Mt <- c("phi", "p")

models_analyse <- "code code.add  monitor
                   code priors_M0 monitor_M0        #1st simulation model (M0)
                   code priors_Mt monitor_Mt"       #2nd simulation model (Mt)


cases <- "sims analyse
          1    1             #1st scenario: simulate with M0, analyse with M0
          1    2             #2nd scenario: simulate with M0, analyse with Mt
          2    1             #3rd scenario: simulate with Mt, analyse with M0
          2    2"            #4th scenario: simulate with Mt, analyse with Mt

set.seed(20200624)

smc_simulate(models = models_simulate,
             nsims = 2,                  #number of datasets per setup
             exists = NA,                  #allow to overwrite directory
             ask = FALSE,
             path = tempdir)                  #do not ask if ok to overwrite directory 

smc_analyse(models_analyse,                            # the model setups
            cases,                                     # the scenarios
            deviance = FALSE,                          # whether to calculate deviance
            mode = simanalyse::sma_set_mode("quick"),  # the mcmc mode
            path = tempdir) 

params_M0 <- list(p0   = 0.5,            #capture probability
                  phi = c(0.8, 0.7, 0.9, 0.8))  #survival probability

smc_evaluate(cases=cases,
             setup="parameters
                    params_M0
                    params_Mt
                    params_M0
                    params_Mt",
             measures = c("rb", "rrmse", "cpQuantile", "LQuantile"), 
             alpha = 0.05,
             path = tempdir)
})
