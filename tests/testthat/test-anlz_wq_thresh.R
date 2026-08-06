test_that("anlz_wq_thresh returns expected structure and only scored vars", {

  result <- anlz_wq_thresh(tbeptools::epcdata)

  expect_named(result, c('yr', 'bay_segment', 'var', 'outcome'))
  expect_setequal(unique(result$var), c('mean_chla', 'mean_la'))
  expect_setequal(unique(result$outcome), c(0, 1))

})
