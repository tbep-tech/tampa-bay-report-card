test_that("anlz_wq_overall averages across indicators present, filters segment/year", {

  wqindic <- data.frame(
    bay_segment = c('OTB', 'OTB', 'HB', 'LTB', 'BCB', 'OTB'),
    yr          = c(2020, 2020, 2020, 1999, 2020, 2020),
    indicator   = c('wq_attain', 'fib', 'wq_attain', 'wq_attain', 'wq_attain', 'wq_attain'),
    outcome     = c(1, 0.5, 0.2, 0.9, 0.9, 1)
  )

  result <- anlz_wq_overall(wqindic)

  # LTB dropped (yr < 2000), BCB dropped (not in default bay_segments),
  # OTB has a duplicate wq_attain row deliberately - both average in
  expect_setequal(result$bay_segment, c('OTB', 'HB'))
  otb <- result[result$bay_segment == 'OTB', ]
  expect_equal(otb$outcome, mean(c(1, 0.5, 1)))
  expect_equal(otb$n_indicator, 3)

})

test_that("anlz_wq_overall respects custom bay_segments and yr_min", {

  wqindic <- data.frame(
    bay_segment = c('BCB', 'OTB'),
    yr          = c(1995, 1995),
    indicator   = c('wq_attain', 'wq_attain'),
    outcome     = c(0.4, 0.6)
  )

  result <- anlz_wq_overall(wqindic, bay_segments = 'BCB', yr_min = 1990)

  expect_equal(nrow(result), 1)
  expect_equal(result$bay_segment, 'BCB')
  expect_equal(result$outcome, 0.4)

})
