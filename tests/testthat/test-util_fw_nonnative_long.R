test_that("util_fw_nonnative_long drops All, abbreviates segments, reverses outcome", {

  df <- data.frame(
    year = 2020,
    `Old Tampa Bay` = 80, `Hillsborough Bay` = 20, `Middle Tampa Bay` = 50,
    `Lower Tampa Bay` = 10, `Remainder Lower Tampa Bay` = 30, All = 40,
    check.names = FALSE
  )

  result <- util_fw_nonnative_long(df)

  expect_named(result, c('yr', 'bay_segment', 'value', 'outcome'))
  expect_equal(nrow(result), 5)
  expect_setequal(result$bay_segment, c('OTB', 'HB', 'MTB', 'LTB', 'RALTB'))

  otb <- result[result$bay_segment == 'OTB', ]
  expect_equal(otb$value, 80)
  expect_equal(otb$outcome, 1 - 80 / 100)

})
