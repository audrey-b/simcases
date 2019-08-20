
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

``` r
library(simcases)
#> Loading required package: nlist
#> Registered S3 method overwritten by 'rjags':
#>   method               from 
#>   as.mcmc.list.mcarray mcmcr
code = "Y ~ dnorm(mu, 1/sigma^2)
        Z ~ dpois(lambda)"
simcases_simulate(code = list(code = code),
                  constants = list(const = nlist(mu=0)),
                  parameters = list(params1 = nlist(sigma=1, lambda=1),
                                    params2 = nlist(sigma=2, lambda=1)),
                  monitor = list(monitor.Y = "Y", monitor.all = ".*"),
                  cases = list(sims1 = "code const params1 monitor.Y",
                               sims2 = "code const params1 monitor.all",
                               sims3 = "code const params2 monitor.Y",
                               sims4 = "code const params2 monitor.all"))
#> [[1]]
#> $Y
#> [1] 0.01991886
#> 
#> $mu
#> [1] 0
#> 
#> an nlists object of 100 nlist objects each with 2 natomic elements
#> 
#> [[2]]
#> $Y
#> [1] 0.0436809
#> 
#> $Z
#> [1] 1.21
#> 
#> $mu
#> [1] 0
#> 
#> an nlists object of 100 nlist objects each with 3 natomic elements
#> 
#> [[3]]
#> $Y
#> [1] -0.2279108
#> 
#> $mu
#> [1] 0
#> 
#> an nlists object of 100 nlist objects each with 2 natomic elements
#> 
#> [[4]]
#> $Y
#> [1] -0.1602485
#> 
#> $Z
#> [1] 0.98
#> 
#> $mu
#> [1] 0
#> 
#> an nlists object of 100 nlist objects each with 3 natomic elements
```

## Contribution

Please report any [issues](https://github.com/audrey-b/simcases/issues).

[Pull requests](https://github.com/audrey-b/simcases/pulls) are always
welcome.

Please note that this project is released with a [Contributor Code of
Conduct](https://github.com/audrey-b/simcases/blob/master/CODE_OF_CONDUCT.md).
By contributing, you agree to abide by its terms.
