context("simcases-simulate")

test_that("generates data with replicability",{
  set.seed(10)
  case1 <- smc_set_case(fun=sims_simulate, code="a ~ dunif(0,1)", nsims = 1L)
  expect_equal(simcases_simulate(case1),
               structure(list(structure(list(a = 0.1354861557627953), class = "nlist")), class = "nlists")
               )  
})
