test_that("anlz_fw_nonnative_obs clips to AOI and assigns a bay segment", {

  skip_on_cran()

  # a single HUC8 code for a fast, live smoke test
  result <- anlz_fw_nonnative_obs(huc8_list = '03100206')

  expect_named(result, c('scientificName', 'commonName', 'group', 'year', 'lon', 'lat', 'source', 'bay_segment'))
  expect_false(anyNA(result$bay_segment))
  expect_true(all(result$bay_segment %in% c(
    'Old Tampa Bay', 'Hillsborough Bay', 'Middle Tampa Bay', 'Lower Tampa Bay', 'Remainder Lower Tampa Bay'
  )))
  expect_true(all(result$year >= 2000))

})
