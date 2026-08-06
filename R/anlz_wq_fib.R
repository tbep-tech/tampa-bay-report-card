#' Fecal indicator bacteria (FIB) outcome by bay segment and year
#'
#' @param enterodata data.frame of raw enterococcus monitoring data, e.g.
#'   \code{tbeptools::enterodata}
#'
#' @details Uses \code{\link[tbeptools]{anlz_fibmatrix}} to grade each bay
#' segment/year A-E, then converts the grade to a 0-1 outcome with
#' \code{\link{util_outcome}} (\code{type = "category"}).
#'
#' @returns A data.frame with columns \code{bay_segment}, \code{yr}, and
#' \code{outcome} (0-1, 1 = best)
#'
#' @export
#'
#' @examples
#' anlz_wq_fib(tbeptools::enterodata)
anlz_wq_fib <- function(enterodata) {

  out <- tbeptools::anlz_fibmatrix(enterodata, bay_segment = c('OTB', 'HB', 'MTB', 'LTB', 'BCB', 'MR')) |>
    dplyr::mutate(
      bay_segment = as.character(.data$grp),
      outcome = util_outcome(.data$cat, type = 'category',
        levels = c(A = 1, B = 3 / 4, C = 2 / 4, D = 1 / 4, E = 0))
    ) |>
    dplyr::select(dplyr::all_of(c('bay_segment', 'yr', 'outcome')))

  return(out)

}
