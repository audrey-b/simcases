
<!-- README.md is generated from README.Rmd. Please edit that file -->

# simcases

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![Travis build
Status](https://www.travis-ci.com/audrey-b/simcases.svg?token=LCuTqqVUfUECxm1xTQLb&branch=master)](https://www.travis-ci.com/audrey-b/simcases)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/r36uoa15oab7fofd/branch/master?svg=true)](https://ci.appveyor.com/project/audrey-b/simcases/branch/master)
[![Codecov test
coverage](https://codecov.io/gh/audrey-b/simcases/branch/master/graph/badge.svg?token=BsckUvkTy8)](https://codecov.io/gh/audrey-b/simcases)
[![License:
GPL3](https://img.shields.io/badge/License-GPL3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.html)
[![CRAN
status](https://www.r-pkg.org/badges/version/simcases)](https://cran.r-project.org/package=simcases)
![CRAN downloads](http://cranlogs.r-pkg.org/badges/simcases)
<!-- badges: end -->

simcases is an R package to simplify the conduct of simulation studies
across multiple cases/scenarios.

## Installation

To install the latest release version from
[CRAN](https://cran.r-project.org)

``` r
install.packages("simcases")
```

To install the latest development version from
[GitHub](https://github.com/audrey-b/simcases)

``` r
# install.packages("remotes")
remotes::install_github("audrey-b/simcases")
```

## Demonstration

First, define the likelihood, constants, parameters and other
characteristics of the models to use for the simulations.

``` r
library(simcases)
#> Registered S3 method overwritten by 'rjags':
#>   method               from 
#>   as.mcmc.list.mcarray mcmcr
lik = "for(i in 1:10){
          a[i] ~ dnorm(mu, 1/sigma^2)}"
const = list(mu=0)
sigma1 = list(sigma=1)
sigma2 = list(sigma=2)
all = ".*"
a = "a"
```

Specify the models to use. The first row is a header and the following
rows each describe a model.

``` r
models = "code constants parameters monitor
          lik  const     sigma1     a
          lik  const     sigma2     a
          lik  const     sigma1     all
          lik  const     sigma2     all"
```

Simulate data. The results are written to files.

``` r
set.seed(10)
smc_simulate(models = models,
                  nsims = 3,
                  exists = NA,
                  ask = FALSE)
#> [[1]]
#> [1] TRUE
#> 
#> [[2]]
#> [1] TRUE
#> 
#> [[3]]
#> [1] TRUE
#> 
#> [[4]]
#> [1] TRUE
```

Analyse data according to specific cases (scenarios).

``` r
prior <- "sigma ~ dunif(0, 6)"
sigma <- "sigma"
models_analysis <- "code code.add monitor
                    lik  prior    sigma
                    lik  prior    sigma"
cases <- "sims models
           1    1
           2    1
           3    2
           4    2"
smc_analyse(models = models_analysis,
                     cases = cases,
                     mode = simanalyse::sma_set_mode("quick"))
#> module dic loaded
#> Compiling model graph
#>    Resolving undeclared variables
#>    Allocating nodes
#> Graph information:
#>    Observed stochastic nodes: 10
#>    Unobserved stochastic nodes: 1
#>    Total graph size: 18
#> 
#> Initializing model
#> 
#> Compiling model graph
#>    Resolving undeclared variables
#>    Allocating nodes
#> Graph information:
#>    Observed stochastic nodes: 10
#>    Unobserved stochastic nodes: 1
#>    Total graph size: 18
#> 
#> Initializing model
#> 
#> Compiling model graph
#>    Resolving undeclared variables
#>    Allocating nodes
#> Graph information:
#>    Observed stochastic nodes: 10
#>    Unobserved stochastic nodes: 1
#>    Total graph size: 18
#> 
#> Initializing model
#> v data0000001.rds [00:00:00.047]
#> v data0000002.rds [00:00:00.028]
#> v data0000003.rds [00:00:00.019]
#> Success: 3
#> Failure: 0
#> Remaining: 0
#> 
#> Module dic unloaded
#> module dic loaded
#> Compiling model graph
#>    Resolving undeclared variables
#>    Allocating nodes
#> Graph information:
#>    Observed stochastic nodes: 10
#>    Unobserved stochastic nodes: 1
#>    Total graph size: 18
#> 
#> Initializing model
#> 
#> Compiling model graph
#>    Resolving undeclared variables
#>    Allocating nodes
#> Graph information:
#>    Observed stochastic nodes: 10
#>    Unobserved stochastic nodes: 1
#>    Total graph size: 18
#> 
#> Initializing model
#> 
#> Compiling model graph
#>    Resolving undeclared variables
#>    Allocating nodes
#> Graph information:
#>    Observed stochastic nodes: 10
#>    Unobserved stochastic nodes: 1
#>    Total graph size: 18
#> 
#> Initializing model
#> v data0000001.rds [00:00:00.016]
#> v data0000002.rds [00:00:00.034]
#> v data0000003.rds [00:00:00.001]
#> Success: 3
#> Failure: 0
#> Remaining: 0
#> 
#> Module dic unloaded
#> module dic loaded
#> Compiling model graph
#>    Resolving undeclared variables
#>    Allocating nodes
#> Graph information:
#>    Observed stochastic nodes: 10
#>    Unobserved stochastic nodes: 1
#>    Total graph size: 18
#> 
#> Initializing model
#> 
#> Compiling model graph
#>    Resolving undeclared variables
#>    Allocating nodes
#> Graph information:
#>    Observed stochastic nodes: 10
#>    Unobserved stochastic nodes: 1
#>    Total graph size: 18
#> 
#> Initializing model
#> 
#> Compiling model graph
#>    Resolving undeclared variables
#>    Allocating nodes
#> Graph information:
#>    Observed stochastic nodes: 10
#>    Unobserved stochastic nodes: 1
#>    Total graph size: 18
#> 
#> Initializing model
#> v data0000001.rds [00:00:00.010]
#> v data0000002.rds [00:00:00.018]
#> v data0000003.rds [00:00:00.016]
#> Success: 3
#> Failure: 0
#> Remaining: 0
#> 
#> Module dic unloaded
#> module dic loaded
#> Compiling model graph
#>    Resolving undeclared variables
#>    Allocating nodes
#> Graph information:
#>    Observed stochastic nodes: 10
#>    Unobserved stochastic nodes: 1
#>    Total graph size: 18
#> 
#> Initializing model
#> 
#> Compiling model graph
#>    Resolving undeclared variables
#>    Allocating nodes
#> Graph information:
#>    Observed stochastic nodes: 10
#>    Unobserved stochastic nodes: 1
#>    Total graph size: 18
#> 
#> Initializing model
#> 
#> Compiling model graph
#>    Resolving undeclared variables
#>    Allocating nodes
#> Graph information:
#>    Observed stochastic nodes: 10
#>    Unobserved stochastic nodes: 1
#>    Total graph size: 18
#> 
#> Initializing model
#> v data0000001.rds [00:00:00.024]
#> v data0000002.rds [00:00:00.023]
#> v data0000003.rds [00:00:00.016]
#> Success: 3
#> Failure: 0
#> Remaining: 0
#> 
#> Module dic unloaded
#> module dic loaded
#> Compiling model graph
#>    Resolving undeclared variables
#>    Allocating nodes
#> Graph information:
#>    Observed stochastic nodes: 10
#>    Unobserved stochastic nodes: 1
#>    Total graph size: 18
#> 
#> Initializing model
#> 
#> Compiling model graph
#>    Resolving undeclared variables
#>    Allocating nodes
#> Graph information:
#>    Observed stochastic nodes: 10
#>    Unobserved stochastic nodes: 1
#>    Total graph size: 18
#> 
#> Initializing model
#> 
#> Compiling model graph
#>    Resolving undeclared variables
#>    Allocating nodes
#> Graph information:
#>    Observed stochastic nodes: 10
#>    Unobserved stochastic nodes: 1
#>    Total graph size: 18
#> 
#> Initializing model
#> v data0000001.rds [00:00:00.029]
#> v data0000002.rds [00:00:00.021]
#> v data0000003.rds [00:00:00.025]
#> Success: 3
#> Failure: 0
#> Remaining: 0
#> 
#> Module dic unloaded
#> module dic loaded
#> Compiling model graph
#>    Resolving undeclared variables
#>    Allocating nodes
#> Graph information:
#>    Observed stochastic nodes: 10
#>    Unobserved stochastic nodes: 1
#>    Total graph size: 18
#> 
#> Initializing model
#> 
#> Compiling model graph
#>    Resolving undeclared variables
#>    Allocating nodes
#> Graph information:
#>    Observed stochastic nodes: 10
#>    Unobserved stochastic nodes: 1
#>    Total graph size: 18
#> 
#> Initializing model
#> 
#> Compiling model graph
#>    Resolving undeclared variables
#>    Allocating nodes
#> Graph information:
#>    Observed stochastic nodes: 10
#>    Unobserved stochastic nodes: 1
#>    Total graph size: 18
#> 
#> Initializing model
#> v data0000001.rds [00:00:00.010]
#> v data0000002.rds [00:00:00.026]
#> v data0000003.rds [00:00:00.021]
#> Success: 3
#> Failure: 0
#> Remaining: 0
#> 
#> Module dic unloaded
#> module dic loaded
#> Compiling model graph
#>    Resolving undeclared variables
#>    Allocating nodes
#> Graph information:
#>    Observed stochastic nodes: 10
#>    Unobserved stochastic nodes: 1
#>    Total graph size: 18
#> 
#> Initializing model
#> 
#> Compiling model graph
#>    Resolving undeclared variables
#>    Allocating nodes
#> Graph information:
#>    Observed stochastic nodes: 10
#>    Unobserved stochastic nodes: 1
#>    Total graph size: 18
#> 
#> Initializing model
#> 
#> Compiling model graph
#>    Resolving undeclared variables
#>    Allocating nodes
#> Graph information:
#>    Observed stochastic nodes: 10
#>    Unobserved stochastic nodes: 1
#>    Total graph size: 18
#> 
#> Initializing model
#> v data0000001.rds [00:00:00.010]
#> v data0000002.rds [00:00:00.016]
#> v data0000003.rds [00:00:00.019]
#> Success: 3
#> Failure: 0
#> Remaining: 0
#> 
#> Module dic unloaded
#> module dic loaded
#> Compiling model graph
#>    Resolving undeclared variables
#>    Allocating nodes
#> Graph information:
#>    Observed stochastic nodes: 10
#>    Unobserved stochastic nodes: 1
#>    Total graph size: 18
#> 
#> Initializing model
#> 
#> Compiling model graph
#>    Resolving undeclared variables
#>    Allocating nodes
#> Graph information:
#>    Observed stochastic nodes: 10
#>    Unobserved stochastic nodes: 1
#>    Total graph size: 18
#> 
#> Initializing model
#> 
#> Compiling model graph
#>    Resolving undeclared variables
#>    Allocating nodes
#> Graph information:
#>    Observed stochastic nodes: 10
#>    Unobserved stochastic nodes: 1
#>    Total graph size: 18
#> 
#> Initializing model
#> v data0000001.rds [00:00:00.043]
#> v data0000002.rds [00:00:00.016]
#> v data0000003.rds [00:00:00.036]
#> Success: 3
#> Failure: 0
#> Remaining: 0
#> 
#> Module dic unloaded
#> module dic loaded
#> Compiling model graph
#>    Resolving undeclared variables
#>    Allocating nodes
#> Graph information:
#>    Observed stochastic nodes: 10
#>    Unobserved stochastic nodes: 1
#>    Total graph size: 18
#> 
#> Initializing model
#> 
#> Compiling model graph
#>    Resolving undeclared variables
#>    Allocating nodes
#> Graph information:
#>    Observed stochastic nodes: 10
#>    Unobserved stochastic nodes: 1
#>    Total graph size: 18
#> 
#> Initializing model
#> 
#> Compiling model graph
#>    Resolving undeclared variables
#>    Allocating nodes
#> Graph information:
#>    Observed stochastic nodes: 10
#>    Unobserved stochastic nodes: 1
#>    Total graph size: 18
#> 
#> Initializing model
#> v data0000001.rds [00:00:00.018]
#> v data0000002.rds [00:00:00.014]
#> v data0000003.rds [00:00:00.016]
#> Success: 3
#> Failure: 0
#> Remaining: 0
#> 
#> Module dic unloaded
#> module dic loaded
#> Compiling model graph
#>    Resolving undeclared variables
#>    Allocating nodes
#> Graph information:
#>    Observed stochastic nodes: 10
#>    Unobserved stochastic nodes: 1
#>    Total graph size: 18
#> 
#> Initializing model
#> 
#> Compiling model graph
#>    Resolving undeclared variables
#>    Allocating nodes
#> Graph information:
#>    Observed stochastic nodes: 10
#>    Unobserved stochastic nodes: 1
#>    Total graph size: 18
#> 
#> Initializing model
#> 
#> Compiling model graph
#>    Resolving undeclared variables
#>    Allocating nodes
#> Graph information:
#>    Observed stochastic nodes: 10
#>    Unobserved stochastic nodes: 1
#>    Total graph size: 18
#> 
#> Initializing model
#> v data0000001.rds [00:00:00.016]
#> v data0000002.rds [00:00:00.020]
#> v data0000003.rds [00:00:00.024]
#> Success: 3
#> Failure: 0
#> Remaining: 0
#> 
#> Module dic unloaded
#> module dic loaded
#> Compiling model graph
#>    Resolving undeclared variables
#>    Allocating nodes
#> Graph information:
#>    Observed stochastic nodes: 10
#>    Unobserved stochastic nodes: 1
#>    Total graph size: 18
#> 
#> Initializing model
#> 
#> Compiling model graph
#>    Resolving undeclared variables
#>    Allocating nodes
#> Graph information:
#>    Observed stochastic nodes: 10
#>    Unobserved stochastic nodes: 1
#>    Total graph size: 18
#> 
#> Initializing model
#> 
#> Compiling model graph
#>    Resolving undeclared variables
#>    Allocating nodes
#> Graph information:
#>    Observed stochastic nodes: 10
#>    Unobserved stochastic nodes: 1
#>    Total graph size: 18
#> 
#> Initializing model
#> v data0000001.rds [00:00:00.043]
#> v data0000002.rds [00:00:00.017]
#> v data0000003.rds [00:00:00.043]
#> Success: 3
#> Failure: 0
#> Remaining: 0
#> 
#> Module dic unloaded
#> module dic loaded
#> Compiling model graph
#>    Resolving undeclared variables
#>    Allocating nodes
#> Graph information:
#>    Observed stochastic nodes: 10
#>    Unobserved stochastic nodes: 1
#>    Total graph size: 18
#> 
#> Initializing model
#> 
#> Compiling model graph
#>    Resolving undeclared variables
#>    Allocating nodes
#> Graph information:
#>    Observed stochastic nodes: 10
#>    Unobserved stochastic nodes: 1
#>    Total graph size: 18
#> 
#> Initializing model
#> 
#> Compiling model graph
#>    Resolving undeclared variables
#>    Allocating nodes
#> Graph information:
#>    Observed stochastic nodes: 10
#>    Unobserved stochastic nodes: 1
#>    Total graph size: 18
#> 
#> Initializing model
#> v data0000001.rds [00:00:00.014]
#> v data0000002.rds [00:00:00.029]
#> v data0000003.rds [00:00:00.031]
#> Success: 3
#> Failure: 0
#> Remaining: 0
#> 
#> Module dic unloaded
#> module dic loaded
#> Compiling model graph
#>    Resolving undeclared variables
#>    Allocating nodes
#> Graph information:
#>    Observed stochastic nodes: 10
#>    Unobserved stochastic nodes: 1
#>    Total graph size: 18
#> 
#> Initializing model
#> 
#> Compiling model graph
#>    Resolving undeclared variables
#>    Allocating nodes
#> Graph information:
#>    Observed stochastic nodes: 10
#>    Unobserved stochastic nodes: 1
#>    Total graph size: 18
#> 
#> Initializing model
#> 
#> Compiling model graph
#>    Resolving undeclared variables
#>    Allocating nodes
#> Graph information:
#>    Observed stochastic nodes: 10
#>    Unobserved stochastic nodes: 1
#>    Total graph size: 18
#> 
#> Initializing model
#> v data0000001.rds [00:00:00.020]
#> v data0000002.rds [00:00:00.016]
#> v data0000003.rds [00:00:00.016]
#> Success: 3
#> Failure: 0
#> Remaining: 0
#> 
#> Module dic unloaded
#> module dic loaded
#> Compiling model graph
#>    Resolving undeclared variables
#>    Allocating nodes
#> Graph information:
#>    Observed stochastic nodes: 10
#>    Unobserved stochastic nodes: 1
#>    Total graph size: 18
#> 
#> Initializing model
#> 
#> Compiling model graph
#>    Resolving undeclared variables
#>    Allocating nodes
#> Graph information:
#>    Observed stochastic nodes: 10
#>    Unobserved stochastic nodes: 1
#>    Total graph size: 18
#> 
#> Initializing model
#> 
#> Compiling model graph
#>    Resolving undeclared variables
#>    Allocating nodes
#> Graph information:
#>    Observed stochastic nodes: 10
#>    Unobserved stochastic nodes: 1
#>    Total graph size: 18
#> 
#> Initializing model
#> v data0000001.rds [00:00:00.031]
#> v data0000002.rds [00:00:00.043]
#> v data0000003.rds [00:00:00.012]
#> Success: 3
#> Failure: 0
#> Remaining: 0
#> 
#> Module dic unloaded
#> module dic loaded
#> Compiling model graph
#>    Resolving undeclared variables
#>    Allocating nodes
#> Graph information:
#>    Observed stochastic nodes: 10
#>    Unobserved stochastic nodes: 1
#>    Total graph size: 18
#> 
#> Initializing model
#> 
#> Compiling model graph
#>    Resolving undeclared variables
#>    Allocating nodes
#> Graph information:
#>    Observed stochastic nodes: 10
#>    Unobserved stochastic nodes: 1
#>    Total graph size: 18
#> 
#> Initializing model
#> 
#> Compiling model graph
#>    Resolving undeclared variables
#>    Allocating nodes
#> Graph information:
#>    Observed stochastic nodes: 10
#>    Unobserved stochastic nodes: 1
#>    Total graph size: 18
#> 
#> Initializing model
#> v data0000001.rds [00:00:00.017]
#> v data0000002.rds [00:00:00.025]
#> v data0000003.rds [00:00:00.004]
#> Success: 3
#> Failure: 0
#> Remaining: 0
#> 
#> Module dic unloaded
#> module dic loaded
#> Compiling model graph
#>    Resolving undeclared variables
#>    Allocating nodes
#> Graph information:
#>    Observed stochastic nodes: 10
#>    Unobserved stochastic nodes: 1
#>    Total graph size: 18
#> 
#> Initializing model
#> 
#> Compiling model graph
#>    Resolving undeclared variables
#>    Allocating nodes
#> Graph information:
#>    Observed stochastic nodes: 10
#>    Unobserved stochastic nodes: 1
#>    Total graph size: 18
#> 
#> Initializing model
#> 
#> Compiling model graph
#>    Resolving undeclared variables
#>    Allocating nodes
#> Graph information:
#>    Observed stochastic nodes: 10
#>    Unobserved stochastic nodes: 1
#>    Total graph size: 18
#> 
#> Initializing model
#> v data0000001.rds [00:00:00.021]
#> v data0000002.rds [00:00:00.009]
#> v data0000003.rds [00:00:00.000]
#> Success: 3
#> Failure: 0
#> Remaining: 0
#> 
#> Module dic unloaded
#> list()
```

Evaluate the performance of the models across the cases (scenarios)

``` r
args = "parameters
         sigma1
         sigma1
         sigma2
         sigma2"
smc_evaluate(args, cases, monitor="sigma")
#> list()
```

Have a look at the files created.

``` r
files <- list.files(getwd(), recursive=TRUE, all.files=TRUE)
print(files)
#>  [1] "sims1/.sims.rds"                                 
#>  [2] "sims1/analysis0000001/.seeds.rds"                
#>  [3] "sims1/analysis0000001/results/results0000001.rds"
#>  [4] "sims1/analysis0000001/results/results0000002.rds"
#>  [5] "sims1/analysis0000001/results/results0000003.rds"
#>  [6] "sims1/data0000001.rds"                           
#>  [7] "sims1/data0000002.rds"                           
#>  [8] "sims1/data0000003.rds"                           
#>  [9] "sims1/performance/performance.rds"               
#> [10] "sims2/.sims.rds"                                 
#> [11] "sims2/analysis0000001/.seeds.rds"                
#> [12] "sims2/analysis0000001/results/results0000001.rds"
#> [13] "sims2/analysis0000001/results/results0000002.rds"
#> [14] "sims2/analysis0000001/results/results0000003.rds"
#> [15] "sims2/data0000001.rds"                           
#> [16] "sims2/data0000002.rds"                           
#> [17] "sims2/data0000003.rds"                           
#> [18] "sims2/performance/performance.rds"               
#> [19] "sims3/.sims.rds"                                 
#> [20] "sims3/analysis0000001/.seeds.rds"                
#> [21] "sims3/analysis0000001/results/results0000001.rds"
#> [22] "sims3/analysis0000001/results/results0000002.rds"
#> [23] "sims3/analysis0000001/results/results0000003.rds"
#> [24] "sims3/data0000001.rds"                           
#> [25] "sims3/data0000002.rds"                           
#> [26] "sims3/data0000003.rds"                           
#> [27] "sims3/performance/performance.rds"               
#> [28] "sims4/.sims.rds"                                 
#> [29] "sims4/analysis0000001/.seeds.rds"                
#> [30] "sims4/analysis0000001/results/results0000001.rds"
#> [31] "sims4/analysis0000001/results/results0000002.rds"
#> [32] "sims4/analysis0000001/results/results0000003.rds"
#> [33] "sims4/data0000001.rds"                           
#> [34] "sims4/data0000002.rds"                           
#> [35] "sims4/data0000003.rds"
```

Load one file.

``` r
readRDS(file.path(getwd(), files[9]))
#>    term        bias cpQuantile        mse
#> 1 sigma -0.02045487  0.6666667 0.06586816
```

## Additional features

When a large number of models is used, it can be more convenient to
specify models as data frames to facilitate query and manipulation. The
example above may be reproduced as follows.

``` r
models <- tibble::tribble(
  ~parameters, ~monitor,
  "sigma1", "a",
  "sigma2", "all"
  )
models <- tidyr::expand(models, parameters, monitor)
models$code <- "lik"
models$constants <- "const"
models
#> # A tibble: 4 x 4
#>   parameters monitor code  constants
#>   <chr>      <chr>   <chr> <chr>    
#> 1 sigma1     a       lik   const    
#> 2 sigma1     all     lik   const    
#> 3 sigma2     a       lik   const    
#> 4 sigma2     all     lik   const

set.seed(10)
smc_simulate(models = models,
                  nsims = 3,
                  fun = identity,
                  exists = NA,
                  ask = FALSE)
#> Warning: Deleted 3 sims data files in './sims1'.
#> Warning: Deleted 3 sims data files in './sims2'.
#> Warning: Deleted 3 sims data files in './sims3'.
#> Warning: Deleted 3 sims data files in './sims4'.
#> [[1]]
#> [1] TRUE
#> 
#> [[2]]
#> [1] TRUE
#> 
#> [[3]]
#> [1] TRUE
#> 
#> [[4]]
#> [1] TRUE
```

## Contribution

Please report any [issues](https://github.com/audrey-b/simcases/issues).

[Pull requests](https://github.com/audrey-b/simcases/pulls) are always
welcome.

Please note that this project is released with a [Contributor Code of
Conduct](https://github.com/audrey-b/simcases/blob/master/CODE_OF_CONDUCT.md).
By contributing, you agree to abide by its terms.
