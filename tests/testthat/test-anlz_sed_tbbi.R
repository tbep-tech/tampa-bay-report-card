test_that("anlz_sed_tbbi returns expected structure, range, and drops All rows", {

  result <- anlz_sed_tbbi(tbeptools::benthicdata)

  expect_named(result, c('yr', 'bay_segment', 'TBBICat', 'outcome'))
  expect_true(all(result$outcome >= 0 & result$outcome <= 1, na.rm = TRUE))
  expect_true(is.character(result$bay_segment))

  # the "All"/"All (wt)" aggregate rows anlz_tbbimed() also returns must be
  # excluded, leaving only the 7 real bay segments
  expect_false(any(grepl('All', result$bay_segment)))
  expect_setequal(unique(result$bay_segment), c('OTB', 'HB', 'MTB', 'LTB', 'TCB', 'MR', 'BCB'))

})
