context("check")

test_that("check_flag()", {
  expect_identical(check_flag(TRUE), TRUE)
  expect_identical(check_flag(FALSE), TRUE)
  expect_error(check_flag(NA), "^NA must be TRUE or FALSE$")
  y <- TRUE
  expect_identical(check_flag(y), TRUE)
  y <- c("name" = TRUE)
  expect_identical(check_flag(y), TRUE)
  y <- NA
  expect_error(check_flag(y), "^y must be TRUE or FALSE$")
  z <- 1
  expect_error(check_flag(z), "^z must be TRUE or FALSE$")
})

test_that("check_flag_na()", {
  expect_identical(check_flag_na(TRUE), TRUE)
  expect_identical(check_flag_na(FALSE), TRUE)
  expect_identical(check_flag_na(NA), TRUE)
  y <- TRUE
  expect_identical(check_flag_na(y), TRUE)
  y <- c("name" = TRUE)
  expect_identical(check_flag_na(y), TRUE)
  y <- NA
  expect_identical(check_flag_na(y), TRUE)
  y <- c("name" = NA)
  expect_identical(check_flag_na(y), TRUE)
  y <- NA_integer_
  expect_error(check_flag_na(y), "^y must be TRUE, FALSE or NA$")
  y <- 1
  expect_error(check_flag_na(y), "^y must be TRUE, FALSE or NA$")
})

test_that("check_string", {
  z <- "str"
  expect_identical(check_string(z), TRUE)
  z <- ""
  expect_identical(check_string(z), TRUE)
  z <- c("name" = "str")
  expect_identical(check_string(z), TRUE)
  z <- 1
  expect_error(check_string(z), "^z must be a string [(]character vector of length 1[)]$")
  z <- character(0)
  expect_error(check_string(z), "^z must be a string [(]character vector of length 1[)]$")
  z <- c("1", "2")
  expect_error(check_string(z), "^z must be a string [(]character vector of length 1[)]$")
  expect_error(check_string(NA_character_), "^NA_character_ must be a string [(]character vector of length 1[)]$")
})

test_that("check_unused", {
  expect_identical(check_unused(), TRUE)
  expect_error(check_unused(1), "^... must be unused$")
})

test_that("check_named", {
  y <- c("z" = 1L)
  expect_identical(check_named(y), TRUE)
  expect_identical(check_named(y[-1]), TRUE)
  expect_error(check_named(1L), "1L must be named")
})
