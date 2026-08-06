test_that("anlz_wq_attain returns expected structure and range", {

  result <- anlz_wq_attain(tbeptools::epcdata)

  expect_named(result, c('bay_segment', 'yr', 'totsum', 'outcome'))
  expect_true(all(result$outcome >= 0 & result$outcome <= 1, na.rm = TRUE))
  expect_setequal(unique(result$bay_segment), c('OTB', 'HB', 'MTB', 'LTB'))

})
