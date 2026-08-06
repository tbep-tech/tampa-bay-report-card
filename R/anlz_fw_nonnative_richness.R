#' Non-native species richness outcome by bay segment and year
#'
#' @param obs output of \code{\link{anlz_fw_nonnative_obs}}
#'
#' @details Counts unique \code{scientificName} values per bay segment/year,
#' normalizes by segment area (plus an AOI-wide \code{"All"} total
#' normalized by total AOI area, from \code{\link{util_fw_nonnative_areas}}),
#' converts to a percentile with \code{\link{util_percentile}}, then
#' reshapes to long format and reverses to a 0-1 outcome with
#' \code{\link{util_fw_nonnative_long}} (higher richness is worse).
#'
#' @returns A data.frame with columns \code{yr}, \code{bay_segment}
#' (abbreviated), \code{value} (0-100 percentile of area-normalized
#' richness), and \code{outcome} (0-1, 1 = best)
#'
#' @export
#'
#' @examples
#' \dontrun{
#' obs <- anlz_fw_nonnative_obs()
#' anlz_fw_nonnative_richness(obs)
#' }
anlz_fw_nonnative_richness <- function(obs) {

  areas <- util_fw_nonnative_areas()
  segs <- names(areas$bayseg_area_sqmi)

  ws <- obs |>
    dplyr::distinct(.data$year, .data$bay_segment, .data$scientificName) |>
    dplyr::count(.data$year, .data$bay_segment) |>
    tidyr::complete(year = unique(.data$year), bay_segment = segs, fill = list(n = 0)) |>
    tidyr::pivot_wider(names_from = 'bay_segment', values_from = 'n', values_fill = 0) |>
    dplyr::select(dplyr::all_of(c('year', segs)))
  ws[segs] <- Map(`/`, ws[segs], areas$bayseg_area_sqmi[segs])
  ws$All <- (obs |> dplyr::distinct(.data$year, .data$scientificName) |> dplyr::count(.data$year) |> dplyr::pull('n')) / areas$aoi_area_sqmi

  out <- util_percentile(ws) |> util_fw_nonnative_long()

  return(out)

}
