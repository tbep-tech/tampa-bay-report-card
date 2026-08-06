test_that("anlz_wq_fib returns expected structure and range", {

  result <- anlz_wq_fib(tbeptools::enterodata)

  expect_named(result, c('bay_segment', 'yr', 'outcome'))
  expect_true(all(result$outcome >= 0 & result$outcome <= 1, na.rm = TRUE))
  expect_true(is.character(result$bay_segment))

})
