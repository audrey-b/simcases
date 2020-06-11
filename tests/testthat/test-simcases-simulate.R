context("simcases-simulate")

test_that("generates data with replicability",{
  tempdir <- file.path(tempdir(), "sims")
  unlink(tempdir, recursive = TRUE)
  dir.create(tempdir)
  set.seed(10)
  model="a ~ dunif(0,1)"
  nsims1 = 1L
  smc_simulate("code nsims
                     model nsims1
                     model nsims1",
                    path=tempdir,
                    exists=NA,
                    ask=FALSE)
  # sims <- smc_simulate("code nsims
  #                            model nsims1
  #                            model nsims1")
  # set.seed(10)
  # sims1 <- sims::sims_simulate(model)
  # sims2 <- sims::sims_simulate(model)
  # #expect_equal(sims, structure(list(structure(list(a = 0.1354861557627953), class = "nlist")), class = "nlists"))  
  # expect_equal(sims, list(sims1, sims2))
  })

