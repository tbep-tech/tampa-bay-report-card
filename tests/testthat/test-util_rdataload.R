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

test_that("util_rdataload cleans up its fallback temp file even when load fails", {

  # a real file that exists but is not valid RData - forces the primary
  # load(url()) to fail (triggering the download.file() fallback), and
  # forces the fallback's load(file = fl) to also fail (garbage content),
  # so util_rdataload() should error overall - but the downloaded temp file
  # must still be removed via on.exit(), not left behind
  garbage_file <- tempfile(fileext = '.RData')
  on.exit(unlink(garbage_file))
  writeLines('not actually RData content', garbage_file)

  fileurl <- paste0('file:///', gsub('\\\\', '/', garbage_file))
  fl <- paste(tempdir(), basename(fileurl), sep = '/')
  unlink(fl)

  expect_error(suppressWarnings(util_rdataload(fileurl)))
  expect_false(file.exists(fl))

})
