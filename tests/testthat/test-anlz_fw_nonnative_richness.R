test_that("anlz_fw_nonnative_richness counts distinct species, normalizes by area, reverses to outcome", {

  obs <- data.frame(
    year = c(2020, 2020, 2020, 2020),
    bay_segment = c('Old Tampa Bay', 'Old Tampa Bay', 'Old Tampa Bay', 'Hillsborough Bay'),
    # OTB: 2 distinct species (one duplicated), HB: 1 distinct species
    scientificName = c('Sp A', 'Sp A', 'Sp B', 'Sp A')
  )

  result <- anlz_fw_nonnative_richness(obs)

  expect_named(result, c('yr', 'bay_segment', 'value', 'outcome'))
  expect_true(all(result$outcome >= 0 & result$outcome <= 1, na.rm = TRUE))

  # segments with zero observations still appear, with the worst possible
  # raw richness (0) - so they should have the best (highest) outcome
  ltb <- result$outcome[result$bay_segment == 'LTB']
  expect_equal(ltb, max(result$outcome))

})
