#' Load an RData file from a URL
#'
#' @param dataurl chr string of the URL for the RData file, expected to
#'   contain a single object named the same as the file (minus the
#'   \code{.RData} extension)
#'
#' @details Tries to load the file directly from \code{dataurl}. If that
#' fails (e.g. the host doesn't support \code{url()} connections), falls
#' back to downloading the file to a temporary location first, then loading
#' it from there. The downloaded file is removed via \code{on.exit()} once
#' the function returns, whether the fallback succeeds or fails.
#'
#' @returns The R object stored in the RData file.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' totanndat <- util_rdataload("https://github.com/tbep-tech/load-estimates/raw/main/data/totanndat.RData")
#' }
util_rdataload <- function(dataurl = NULL) {

  x <- gsub('\\.RData', '', basename(dataurl))

  # try simple load
  ld <- try(load(url(dataurl)), silent = TRUE)

  # return x if load worked
  if (!inherits(ld, 'try-error')) {
    out <- get(x)
  }

  # download x if load failed
  if (inherits(ld, 'try-error')) {
    fl <- paste(tempdir(), basename(dataurl), sep = '/')
    on.exit(unlink(fl), add = TRUE)
    utils::download.file(dataurl, destfile = fl, quiet = TRUE)
    load(file = fl)
    out <- get(x)
  }

  return(out)

}
