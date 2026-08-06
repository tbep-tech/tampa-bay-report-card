test_that("util_fw_fetch_fim returns expected structure and groups", {

  skip_on_cran()

  result <- util_fw_fetch_fim()

  expect_named(result, c('scientificName', 'commonName', 'group', 'year', 'lon', 'lat', 'source'))
  expect_true(all(result$source == 'FIM'))
  expect_setequal(unique(result$group), c('Fishes', 'Reptiles'))
  expect_true(all(result$year >= 2000 & result$year <= 2030))

})
