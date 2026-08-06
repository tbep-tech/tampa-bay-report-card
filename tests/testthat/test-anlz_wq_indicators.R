test_that("anlz_wq_indicators stacks all five indicators without NA-filling", {

  wqattain <- data.frame(bay_segment = 'OTB', yr = 2020, totsum = 3, outcome = 0.5)
  wqthresh <- data.frame(yr = 2020, bay_segment = 'OTB', var = c('mean_chla', 'mean_la'), outcome = c(1, 0))
  wqload <- data.frame(bay_segment = 'OTB', yr = 2020, indicator = c('tn_load', 'tnhy_load'), outcome = c(1, 0))
  # OTB has no tidal creek data this year - should just be absent, not NA-filled
  wqtidalcreeks <- data.frame(bay_segment = 'HB', yr = 2020, outcome = 0.7, n_assessed = 5)
  wqfib <- data.frame(bay_segment = 'OTB', yr = 2020, outcome = 0.25)

  result <- anlz_wq_indicators(wqattain, wqthresh, wqload, wqtidalcreeks, wqfib)

  expect_named(result, c('bay_segment', 'yr', 'indicator', 'outcome'))
  expect_setequal(
    result$indicator,
    c('wq_attain', 'chla_thresh', 'la_thresh', 'tn_load', 'tnhy_load', 'tidal_creeks', 'fib')
  )
  # OTB has no tidal_creeks row, HB has no other indicator rows - confirms
  # bind_rows (not a join) behavior
  expect_equal(nrow(result[result$bay_segment == 'HB', ]), 1)
  expect_equal(nrow(result[result$bay_segment == 'OTB', ]), 6)

})

test_that("anlz_wq_indicators drops NA outcomes", {

  wqattain <- data.frame(bay_segment = 'OTB', yr = 2020, totsum = 3, outcome = NA_real_)
  wqthresh <- data.frame(yr = integer(0), bay_segment = character(0), var = character(0), outcome = numeric(0))
  wqload <- data.frame(bay_segment = character(0), yr = integer(0), indicator = character(0), outcome = numeric(0))
  wqtidalcreeks <- data.frame(bay_segment = character(0), yr = integer(0), outcome = numeric(0), n_assessed = integer(0))
  wqfib <- data.frame(bay_segment = character(0), yr = integer(0), outcome = numeric(0))

  result <- anlz_wq_indicators(wqattain, wqthresh, wqload, wqtidalcreeks, wqfib)

  expect_equal(nrow(result), 0)

})
