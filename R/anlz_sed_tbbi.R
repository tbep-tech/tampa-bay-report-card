#' Benthic index (TBBI) outcome by bay segment and year
#'
#' @param benthicdata raw benthic monitoring data, e.g.
#'   \code{tbeptools::benthicdata}
#'
#' @details Uses \code{\link[tbeptools]{anlz_tbbiscr}} and
#' \code{\link[tbeptools]{anlz_tbbimed}} to grade each bay segment/year
#' Poor/Fair/Good, drops the aggregate \code{"All"}/\code{"All (wt)"} rows
#' those functions also return (keeping only the real bay segments), then
#' converts the grade to a 0-1 outcome with \code{\link{util_outcome}}
#' (\code{type = "category"}).
#'
#' @returns A data.frame with columns \code{yr}, \code{bay_segment},
#' \code{TBBICat} (\code{"Poor"}, \code{"Fair"}, or \code{"Good"}), and
#' \code{outcome} (0-1, 1 = best)
#'
#' @export
#'
#' @examples
#' anlz_sed_tbbi(tbeptools::benthicdata)
anlz_sed_tbbi <- function(benthicdata) {

  out <- benthicdata |>
    tbeptools::anlz_tbbiscr() |>
    tbeptools::anlz_tbbimed() |>
    dplyr::filter(!grepl('All', .data$bay_segment)) |>
    dplyr::mutate(
      bay_segment = as.character(.data$bay_segment),
      outcome = util_outcome(.data$TBBICat, type = 'category', levels = c(Poor = 0, Fair = 0.5, Good = 1))
    ) |>
    dplyr::select(dplyr::all_of(c('yr', 'bay_segment', 'TBBICat', 'outcome')))

  return(out)

}
