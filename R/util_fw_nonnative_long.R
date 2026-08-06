#' Reshape a non-native metric's wide year-by-segment table to long format
#'
#' @param df data.frame with a \code{year} column, one column per bay segment
#'   full name (e.g. \code{"Old Tampa Bay"}), and an \code{"All"} column
#'
#' @details Drops the \code{"All"} column (only needed upstream so
#' \code{\link{util_percentile}}'s mean/sd includes it), abbreviates bay
#' segment names, and reverses the percentile to a 0-1 outcome where
#' \code{1} = best, since higher non-native abundance/richness is worse.
#'
#' @returns A data.frame with columns \code{yr}, \code{bay_segment}
#' (abbreviated, e.g. \code{"OTB"}, \code{"RALTB"} for Remainder Lower Tampa
#' Bay), \code{value} (the input percentile, 0-100), and \code{outcome}
#' (\code{1 - value / 100}, 0-1, 1 = best)
#'
#' @export
#'
#' @examples
#' df <- data.frame(
#'   year = 2020,
#'   `Old Tampa Bay` = 80, `Hillsborough Bay` = 20, `Middle Tampa Bay` = 50,
#'   `Lower Tampa Bay` = 10, `Remainder Lower Tampa Bay` = 30, All = 40,
#'   check.names = FALSE
#' )
#' util_fw_nonnative_long(df)
util_fw_nonnative_long <- function(df) {

  seg_abbrev <- c(
    'Old Tampa Bay'             = 'OTB',
    'Hillsborough Bay'          = 'HB',
    'Middle Tampa Bay'          = 'MTB',
    'Lower Tampa Bay'           = 'LTB',
    'Remainder Lower Tampa Bay' = 'RALTB'
  )

  out <- df |>
    dplyr::select(-dplyr::all_of('All')) |>
    tidyr::pivot_longer(-dplyr::all_of('year'), names_to = 'bay_segment', values_to = 'value') |>
    dplyr::mutate(
      yr = as.integer(.data$year),
      bay_segment = seg_abbrev[.data$bay_segment],
      outcome = 1 - .data$value / 100
    ) |>
    dplyr::select(dplyr::all_of(c('yr', 'bay_segment', 'value', 'outcome')))

  return(out)

}
