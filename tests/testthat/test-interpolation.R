a <- "foliage"
b <- 23

test_that("interp_single() works", {

  # substitution

  expect_identical(interp_single("${mtcars}"), mtcars)

  # neglects whitespace
  expect_identical(interp_single(" ${mtcars} "), mtcars)

  # string interpolation

  # errors (length > 1)
  expect_error(
    interp_single("I heart ${mtcars}"),
    "length greater than one"
  )

  expect_identical(interp_single("I heart ${a}"), "I heart foliage")
  expect_identical(interp_single("I heart ${b}"), "I heart 23")

})


test_that("interp_traverse() works", {

  # don't mess with data frames
  expect_identical(
    interp_transverse(mtcars),
    mtcars
  )

  tmp_a <- list(
    numbers = seq(1:10),
    string = c("ahoy", "foo ${a}")
  )

  tmp_aa <- tmp_a
  tmp_aa[["string"]] <- list("ahoy", "foo foliage")

  tmp_b <- list(
    list(
      numbers = list(3, 4, "${b}")
    )
  )

  tmp_bb <- tmp_b
  tmp_bb[[1]][["numbers"]][[3]] <- 23

  tmp_c <- list(data = "${mtcars}")
  tmp_cc <- list(data = mtcars)

  expect_identical(interp_transverse(tmp_a), tmp_aa)
  expect_identical(interp_transverse(tmp_b), tmp_bb)
  expect_identical(interp_transverse(tmp_c), tmp_cc)

})
