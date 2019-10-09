context("simcases-simulate")

test_that("generates data with replicability",{
  set.seed(10)
  code="a ~ dunif(0,1)"
  nsims = 1L
  sims <- simcases_simulate("code nsims", "code nsims")
  expect_equal(sims, structure(list(structure(list(a = 0.1354861557627953), class = "nlist")), class = "nlists")
               )  
})

