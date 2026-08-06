test_that("util_rdataload loads an object matching the file basename", {

  tf <- tempfile(fileext = '.RData')
  on.exit(unlink(tf))

  objnm <- gsub('\\.RData$', '', basename(tf))
  assign(objnm, data.frame(x = 1:3, y = c('a', 'b', 'c')))
  save(list = objnm, file = tf)

  fileurl <- paste0('file:///', gsub('\\\\', '/', tf))

  # suppressWarnings: a file:// URL on Windows triggers a benign "text-mode
  # file connection" warning from gzcon() that real http(s) URLs don't hit
  result <- suppressWarnings(util_rdataload(fileurl))

  expect_identical(result, data.frame(x = 1:3, y = c('a', 'b', 'c')))

})
