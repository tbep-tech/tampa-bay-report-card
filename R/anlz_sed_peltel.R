#' Sediment quality (PEL/TEL) outcome by bay segment and year
#'
#' @param sedimentdata data.frame of raw sediment monitoring data, e.g.
#'   \code{tbeptools::sedimentdata}
#' @param yrs integer vector of years to assess, passed to
#'   \code{\link[tbeptools]{anlz_sedimentpelave}} one year at a time
#'
#' @details Grades each bay segment/year by its average sediment
#' contamination score (\code{ave}, from
#' \code{\link[tbeptools]{anlz_sedimentpelave}}) into A-F , then converts the grade to a
#' 0-1 outcome with \code{\link{util_outcome}} (\code{type = "category"}).
#'
#' @returns A data.frame with columns \code{yr}, \code{bay_segment},
#' \code{ave} (average sediment contamination score), \code{grd} (letter
#' grade A-F), and \code{outcome} (0-1, 1 = best)
#'
#' @export
#'
#' @examples
#' anlz_sed_peltel(tbeptools::sedimentdata, yrs = 2020)
anlz_sed_peltel <- function(sedimentdata, yrs) {

  gradelevs <- c(A = 1, B = 0.75, C = 0.5, D = 0.25, F = 0)

  out <- tibble::tibble(yr = yrs) |>
    dplyr::group_nest(.data$yr) |>
    dplyr::mutate(
      data = purrr::map(.data$yr, function(x) tbeptools::anlz_sedimentpelave(sedimentdata, yrrng = x))
    ) |>
    tidyr::unnest('data') |>
    dplyr::mutate(
      bay_segment = as.character(.data$AreaAbbr),
      grd = cut(
        .data$ave,
        breaks = c(-Inf, 0.00756, 0.02052, 0.08567, 0.28026, Inf), # same cuts from tbeptools
        labels = names(gradelevs)
      ),
      outcome = util_outcome(.data$grd, type = 'category', levels = gradelevs)
    ) |>
    dplyr::select(dplyr::all_of(c('yr', 'bay_segment', 'ave', 'grd', 'outcome')))

  return(out)

}
