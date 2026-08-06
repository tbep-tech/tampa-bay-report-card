test_that("anlz_hab_seagrass_transect returns expected structure, range, and drops All", {

  result <- anlz_hab_seagrass_transect(tbeptools::transect)

  expect_named(result, c('bay_segment', 'yr', 'foest', 'outcome'))
  expect_true(all(result$outcome >= 0 & result$outcome <= 1, na.rm = TRUE))
  expect_false('All' %in% result$bay_segment)
  expect_equal(result$outcome, result$foest / 100)

})
