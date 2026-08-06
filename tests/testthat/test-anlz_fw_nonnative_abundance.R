test_that("anlz_fw_nonnative_abundance normalizes by area and reverses to outcome", {

  # synthetic obs matching anlz_fw_nonnative_obs()'s output shape - avoids a
  # live network fetch for a fast, deterministic test
  obs <- data.frame(
    year = c(2020, 2020, 2020, 2021),
    bay_segment = c('Old Tampa Bay', 'Old Tampa Bay', 'Hillsborough Bay', 'Old Tampa Bay'),
    scientificName = c('Sp A', 'Sp B', 'Sp A', 'Sp A')
  )

  result <- anlz_fw_nonnative_abundance(obs)

  expect_named(result, c('yr', 'bay_segment', 'value', 'outcome'))
  expect_setequal(unique(result$bay_segment), c('OTB', 'HB', 'MTB', 'LTB', 'RALTB'))
  # both years x all 5 segments present, even ones with zero observations
  expect_equal(nrow(result), 10)
  expect_true(all(result$outcome >= 0 & result$outcome <= 1, na.rm = TRUE))

  # OTB had more raw observations than HB in 2020 -> lower (worse) outcome
  otb_2020 <- result$outcome[result$bay_segment == 'OTB' & result$yr == 2020]
  hb_2020  <- result$outcome[result$bay_segment == 'HB'  & result$yr == 2020]
  expect_lt(otb_2020, hb_2020)

})
