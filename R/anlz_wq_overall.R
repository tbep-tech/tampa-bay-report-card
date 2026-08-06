#' Overall water quality outcome by bay segment and year
#'
#' @param wqindicators output of \code{\link{anlz_wq_indicators}}
#' @param bay_segments chr vector of bay segments to include, defaults to
#'   \code{c('OTB', 'HB', 'MTB', 'LTB')}, the four segments with the most
#'   complete indicator coverage
#' @param yr_min integer, minimum year to include, defaults to \code{2000}
#'
#' @details Averages \code{outcome} across whatever indicators have data for
#' a given bay segment/year - see \code{n_indicator} in the output for how
#' many contributed. \strong{This is a water-quality-only score}: how
#' sediment, fish/wildlife, and habitat indicators combine with it into one
#' overall bay-segment score is not yet designed.
#'
#' @returns A data.frame with columns \code{bay_segment}, \code{yr},
#' \code{outcome} (0-1, 1 = best), and \code{n_indicator} (number of
#' indicators averaged for that segment/year)
#'
#' @export
#'
#' @examples
#' \dontrun{
#' anlz_wq_overall(wqindic)
#' }
anlz_wq_overall <- function(wqindicators, bay_segments = c('OTB', 'HB', 'MTB', 'LTB'), yr_min = 2000) {

  out <- wqindicators |>
    dplyr::filter(.data$bay_segment %in% bay_segments, .data$yr >= yr_min) |>
    dplyr::group_by(.data$bay_segment, .data$yr) |>
    dplyr::summarise(
      outcome = mean(.data$outcome, na.rm = TRUE),
      n_indicator = dplyr::n(),
      .groups = 'drop'
    )

  return(out)

}
