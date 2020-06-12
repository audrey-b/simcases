context("simcases")

test_that("test",{
  tempdir <- file.path(tempdir(), "sims")
  unlink(tempdir, recursive = TRUE)
  dir.create(tempdir)
  set.seed(10)
  param <- list(mu = 0)
  model="a ~ dunif(mu,1)"
  nsims1 = 1L
  smc_simulate("code parameters nsims
                model param nsims1
                model param nsims1",
                    path=tempdir,
                    exists=NA,
                    ask=FALSE)
  prior <- "mu ~ dunif(0,1)"
  models <- "code code.add
             model prior
             model prior"
  cases <- "sims analyse
             1   1
             2   2"
  smc_analyse(models, 
              cases,                     
              path=tempdir,
              mode=sma_set_mode("quick"))
  # sims <- smc_simulate("code nsims
  #                            model nsims1
  #                            model nsims1")
  # set.seed(10)
  # sims1 <- sims::sims_simulate(model)
  # sims2 <- sims::sims_simulate(model)
  # #expect_equal(sims, structure(list(structure(list(a = 0.1354861557627953), class = "nlist")), class = "nlists"))  
  # expect_equal(sims, list(sims1, sims2))
  })

