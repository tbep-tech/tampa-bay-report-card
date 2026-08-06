test_that("util_fw_nonnative_areas returns positive areas for all 5 groups plus AOI", {

  result <- util_fw_nonnative_areas()

  expect_named(result, c('bayseg_area_sqmi', 'aoi_area_sqmi'))
  expect_length(result$bayseg_area_sqmi, 5)
  expect_true(all(result$bayseg_area_sqmi > 0))
  expect_true(result$aoi_area_sqmi > 0)
  # AOI should be at least as large as the largest single segment group
  expect_gte(result$aoi_area_sqmi, max(result$bayseg_area_sqmi))

})
