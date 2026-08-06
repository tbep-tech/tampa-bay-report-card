#' Combine water quality indicators into a single long-format table
#'
#' @param wqattain output of \code{\link{anlz_wq_attain}}
#' @param wqthresh output of \code{\link{anlz_wq_thresh}}
#' @param wqload output of \code{\link{anlz_wq_load}}
#' @param wqtidalcreeks output of \code{\link{anlz_wq_tidalcreeks}}
#' @param wqfib output of \code{\link{anlz_wq_fib}}
#'
#' @details Stacks (\code{\link[dplyr]{bind_rows}}) rather than joins the
#' five water quality indicators, since bay segment/year coverage differs by
#' indicator - a segment/year missing from one indicator's source data
#' simply has no row for it, rather than an \code{NA}-filled one.
#'
#' @returns A data.frame with columns \code{bay_segment}, \code{yr},
#' \code{indicator} (\code{"wq_attain"}, \code{"chla_thresh"},
#' \code{"la_thresh"}, \code{"tn_load"}, \code{"tnhy_load"},
#' \code{"tidal_creeks"}, \code{"fib"}), and \code{outcome} (0-1, 1 = best)
#'
#' @export
#'
#' @examples
#' \dontrun{
#' anlz_wq_indicators(
#'   anlz_wq_attain(tbeptools::epcdata),
#'   anlz_wq_thresh(tbeptools::epcdata),
#'   anlz_wq_load(totanndat),
#'   anlz_wq_tidalcreeks(tbeptools::tidalcreeks, tbeptools::iwrraw, yrs = 2015:2020),
#'   anlz_wq_fib(tbeptools::enterodata)
#' )
#' }
anlz_wq_indicators <- function(wqattain, wqthresh, wqload, wqtidalcreeks, wqfib) {

  out <- dplyr::bind_rows(
    wqattain |>
      dplyr::transmute(
        bay_segment = as.character(.data$bay_segment),
        yr = as.integer(.data$yr),
        indicator = 'wq_attain',
        outcome = .data$outcome
      ),
    wqthresh |>
      dplyr::transmute(
        bay_segment = as.character(.data$bay_segment),
        yr = as.integer(.data$yr),
        indicator = dplyr::recode(.data$var, mean_chla = 'chla_thresh', mean_la = 'la_thresh'),
        outcome = .data$outcome
      ),
    wqload |>
      dplyr::transmute(
        bay_segment = as.character(.data$bay_segment),
        yr = as.integer(.data$yr),
        indicator = .data$indicator,
        outcome = .data$outcome
      ),
    wqtidalcreeks |>
      dplyr::transmute(
        bay_segment = as.character(.data$bay_segment),
        yr = as.integer(.data$yr),
        indicator = 'tidal_creeks',
        outcome = .data$outcome
      ),
    wqfib |>
      dplyr::transmute(
        bay_segment = as.character(.data$bay_segment),
        yr = as.integer(.data$yr),
        indicator = 'fib',
        outcome = .data$outcome
      )
  ) |>
    dplyr::filter(!is.na(.data$outcome))

  return(out)

}
