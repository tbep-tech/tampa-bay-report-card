#' Convert a wide data frame of values to percentiles by mean and standard deviation
#'
#' @param df data.frame with one or more id columns (see \code{id_cols}) and
#'   the remaining columns holding numeric values to convert
#' @param id_cols chr vector of column names to carry through unchanged,
#'   defaults to \code{"year"}
#'
#' @details Computes a single mean and standard deviation across every value
#' in every non-id column (not per-column), then converts each value to a
#' percentile via \code{\link[stats]{pnorm}} of its z-score. This matches
#' the \code{tbep-invasives} Python pipeline's
#' \code{as_percentile_by_mean_std()} exactly, including using one global
#' mean/sd for the whole table rather than one per column. If the standard
#' deviation is \code{0} or undefined (e.g. a single-row input), every value
#' is given a percentile of \code{50}.
#'
#' @returns A data.frame the same shape as \code{df}, with non-id columns
#' converted to percentiles from \code{0} to \code{100}
#'
#' @export
#'
#' @examples
#' df <- data.frame(year = 2020:2022, OTB = c(10, 20, 30), HB = c(5, 15, 25))
#' util_percentile(df)
util_percentile <- function(df, id_cols = 'year') {

  val_cols <- setdiff(names(df), id_cols)
  vals <- as.matrix(df[, val_cols])

  mu <- mean(vals, na.rm = TRUE)
  sigma <- stats::sd(vals, na.rm = TRUE)

  pctl <- if (sigma <= 0 || is.na(sigma))
    matrix(50, nrow(vals), ncol(vals), dimnames = list(NULL, val_cols))
  else
    stats::pnorm((vals - mu) / sigma) * 100

  out <- tibble::as_tibble(pctl, .name_repair = 'minimal')
  names(out) <- val_cols

  return(dplyr::bind_cols(df[, id_cols, drop = FALSE], out))

}
