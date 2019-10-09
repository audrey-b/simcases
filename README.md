
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
lik = "Y ~ dnorm(mu, 1/sigma^2)
        Z ~ dpois(lambda)"
const = nlist(mu=0)
params1 = nlist(sigma=1, lambda=1)
params2 = nlist(sigma=2, lambda=1)
monitor.Y = "Y"
monitor.all = ".*"

simcases_simulate("code constants parameters monitor",
                  "lik  const     params1    monitor.Y
                   lik  const     params2    monitor.Y
                   lik  const     params1    monitor.all
                   lik  const     params2    monitor.all")
#> [[1]]
#> $Y
#> [1] -0.9349803
#> 
#> $mu
#> [1] 0
#> 
#> an nlists object of an nlist object with 2 natomic elements
#> [[2]]
#> $Y
#> [1] 2.048787
#> 
#> $mu
#> [1] 0
#> 
#> an nlists object of an nlist object with 2 natomic elements
#> [[3]]
#> $Y
#> [1] 1.258582
#> 
#> $Z
#> [1] 2
#> 
#> $mu
#> [1] 0
#> 
#> an nlists object of an nlist object with 3 natomic elements
#> [[4]]
#> $Y
#> [1] 1.557847
#> 
#> $Z
#> [1] 2
#> 
#> $mu
#> [1] 0
#> 
#> an nlists object of an nlist object with 3 natomic elements
```

## Contribution

Please report any [issues](https://github.com/audrey-b/simcases/issues).

[Pull requests](https://github.com/audrey-b/simcases/pulls) are always
welcome.

Please note that this project is released with a [Contributor Code of
Conduct](https://github.com/audrey-b/simcases/blob/master/CODE_OF_CONDUCT.md).
By contributing, you agree to abide by its terms.
