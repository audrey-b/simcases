
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
#> Loading required package: nlist
lik = "Y ~ dnorm(mu, 1/sigma^2)
        Z ~ dpois(lambda)"
const = nlist(mu=0)
params1 = nlist(sigma=1, lambda=1)
params2 = nlist(sigma=2, lambda=1)
monitor.Y = "Y"
monitor.all = ".*"
```

Specify the models to use. The first row is a header and the following
rows each describe a model.

``` r
models = "code constants parameters monitor,
          lik  const     params1    monitor.Y
          lik  const     params2    monitor.Y
          lik  const     params1    monitor.all
          lik  const     params2    monitor.all"
```

Simulate data. The results are written to files.

``` r
set.seed(10)
simcases_simulate(models = models,
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

Have a look at the files created.

``` r
files <- list.files(getwd(), recursive=TRUE, all.files=TRUE)
print(files)
#>  [1] "case1/sims/.sims.rds"       "case1/sims/data0000001.rds"
#>  [3] "case1/sims/data0000002.rds" "case1/sims/data0000003.rds"
#>  [5] "case2/sims/.sims.rds"       "case2/sims/data0000001.rds"
#>  [7] "case2/sims/data0000002.rds" "case2/sims/data0000003.rds"
#>  [9] "case3/sims/.sims.rds"       "case3/sims/data0000001.rds"
#> [11] "case3/sims/data0000002.rds" "case3/sims/data0000003.rds"
#> [13] "case4/sims/.sims.rds"       "case4/sims/data0000001.rds"
#> [15] "case4/sims/data0000002.rds" "case4/sims/data0000003.rds"
```

Load one file.

``` r
readRDS(file.path(getwd(), files[2]))
#> $Y
#> [1] 0.7500481
#> 
#> $mu
#> [1] 0
#> 
#> an nlist object with 2 natomic elements
```

## Additional features

When a large number of models is used, it can be more convenient to
specify models as data frames to facilitate query and manipulation. The
example above may be reproduced as follows.

``` r
models <- tibble::tribble(
  ~parameters, ~monitor,
  "params1", "monitor.Y",
  "params2", "monitor.all"
  )
models <- tidyr::expand(models, parameters, monitor)
models$code <- "lik"
models$constants <- "const"
models
#> # A tibble: 4 x 4
#>   parameters monitor     code  constants
#>   <chr>      <chr>       <chr> <chr>    
#> 1 params1    monitor.all lik   const    
#> 2 params1    monitor.Y   lik   const    
#> 3 params2    monitor.all lik   const    
#> 4 params2    monitor.Y   lik   const

set.seed(10)
simcases_simulate(models = models,
                  nsims = 3,
                  fun = identity,
                  exists = NA,
                  ask = FALSE)
#> Warning: Deleted 3 sims data files in './case1/sims'.
#> Warning: Deleted 3 sims data files in './case2/sims'.
#> Warning: Deleted 3 sims data files in './case3/sims'.
#> Warning: Deleted 3 sims data files in './case4/sims'.
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
