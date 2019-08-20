context("simcases-simulate")

test_that("generates data with replicability",{
  set.seed(10)
  expect_equal(simcases_simulate(list(code1="a ~ dunif(0,1)"),
                                 cases=list("code1"), nsims = 1L),
               list(structure(list(structure(list(a = 0.1354861557627953), class = "nlist")), class = "nlists")))  
})
