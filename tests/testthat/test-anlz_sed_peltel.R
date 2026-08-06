test_that("anlz_sed_peltel returns expected structure and range", {

  result <- anlz_sed_peltel(tbeptools::sedimentdata, yrs = 2020)

  expect_named(result, c('yr', 'bay_segment', 'ave', 'grd', 'outcome'))
  expect_true(all(result$outcome >= 0 & result$outcome <= 1, na.rm = TRUE))
  expect_true(all(result$yr == 2020))
  expect_true(is.character(result$bay_segment))

})

test_that("anlz_sed_peltel loops over multiple years", {

  result <- anlz_sed_peltel(tbeptools::sedimentdata, yrs = 2018:2020)

  expect_setequal(unique(result$yr), c(2018, 2019, 2020))

})
