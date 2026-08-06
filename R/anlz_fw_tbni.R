#' Tampa Bay Nekton Index (TBNI) outcome by bay segment and year
#'
#' @param fimdata data.frame of raw fisheries independent monitoring data,
#'   e.g. \code{tbeptools::fimdata}
#'
#' @details Uses \code{\link[tbeptools]{anlz_tbniscr}} and
#' \code{\link[tbeptools]{anlz_tbniave}} to score each bay segment/year 0-100,
#' then converts to a 0-1 outcome with \code{\link{util_outcome}}
#' (\code{type = "continuous"}, \code{from = c(0, 100)}). \strong{Caveat}:
#' this is a plain linear rescale - it does not yet account for TBNI's actual
#' grade breakpoints (On Alert below 32, Caution from 32 to 46, Stay the
#' Course above 46), which is a known simplification to revisit.
#'
#' @returns A data.frame with columns \code{bay_segment}, \code{yr},
#' \code{Segment_TBNI} (the raw 0-100 score), \code{Action} (management
#' action category from \code{\link[tbeptools]{anlz_tbniave}}), and
#' \code{outcome} (0-1, 1 = best)
#'
#' @export
#'
#' @examples
#' anlz_fw_tbni(tbeptools::fimdata)
anlz_fw_tbni <- function(fimdata) {

  out <- fimdata |>
    tbeptools::anlz_tbniscr() |>
    tbeptools::anlz_tbniave() |>
    dplyr::rename(yr = dplyr::all_of('Year')) |>
    dplyr::mutate(
      bay_segment = as.character(.data$bay_segment),
      outcome = util_outcome(.data$Segment_TBNI, type = 'continuous', from = c(0, 100))
    )

  return(out)

}
