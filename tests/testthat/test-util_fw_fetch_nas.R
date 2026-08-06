test_that("util_fw_fetch_nas returns expected structure and only kept groups", {

  skip_on_cran()

  # single HUC8 code for a fast, live smoke test of the real API
  result <- util_fw_fetch_nas(huc8_list = '03100206')

  expect_named(result, c('scientificName', 'commonName', 'group', 'year', 'lon', 'lat', 'source'))
  expect_true(all(result$source == 'NAS'))
  expect_true(all(result$group %in% c('Amphibians', 'Crustaceans', 'Fishes', 'Mammals', 'Mollusks', 'Plants', 'Reptiles')))
  expect_false(any(grepl('-', result$group)))

})
