test_that("util_percentile converts values to percentiles using one global mean/sd", {

  df <- data.frame(year = 2020:2022, OTB = c(10, 20, 30), HB = c(10, 20, 30))

  result <- util_percentile(df)

  expect_named(result, c('year', 'OTB', 'HB'))
  # OTB and HB are identical, and the value 20 is the mean of all 6 cells -> 50th percentile
  expect_equal(result$OTB[result$year == 2021], 50)
  expect_equal(result$OTB, result$HB)
  # monotonic: higher raw value -> higher percentile
  expect_true(all(diff(result$OTB) > 0))

})

test_that("util_percentile returns 50 everywhere when sd is 0", {

  df <- data.frame(year = 2020:2021, OTB = c(5, 5), HB = c(5, 5))

  result <- util_percentile(df)

  expect_true(all(result$OTB == 50, result$HB == 50))

})

test_that("util_percentile respects custom id_cols", {

  df <- data.frame(year = 2020, seg = 'OTB', val = 100)

  result <- util_percentile(df, id_cols = c('year', 'seg'))

  expect_named(result, c('year', 'seg', 'val'))
  expect_equal(result$val, 50)

})
