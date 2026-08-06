#' Fetch USGS NAS non-native species occurrences for a set of HUC8 watersheds
#'
#' @param huc8_list chr vector of HUC8 watershed codes to query, defaults to
#'   the 9 codes covering the Tampa Bay area (from
#'   \href{https://github.com/tbep-tech}{tbep-invasives}'
#'   \code{config/settings.yaml})
#'
#' @details Queries the public
#' \href{https://nas.er.usgs.gov/api/v2/occurrence/search}{USGS Nonindigenous
#' Aquatic Species (NAS)} occurrence API once per HUC8 code and combines the
#' results. Dashed NAS taxonomic group names (e.g. \code{"Amphibians-Frogs"})
#' are collapsed to their parent group (matching
#' \code{tbep-invasives}' \code{download_invasives.py}), and only
#' \code{Amphibians}, \code{Crustaceans}, \code{Fishes}, \code{Mammals},
#' \code{Mollusks}, \code{Plants}, and \code{Reptiles} are kept.
#'
#' @returns A data.frame with columns \code{scientificName}, \code{commonName},
#' \code{group}, \code{year}, \code{lon}, \code{lat}, and \code{source}
#' (always \code{"NAS"})
#'
#' @export
#'
#' @examples
#' \dontrun{
#' util_fw_fetch_nas()
#' }
util_fw_fetch_nas <- function(huc8_list = c(
    '03100101', '03100201', '03100202', '03100203',
    '03100204', '03100205', '03100206', '03100207', '03100208'
  )) {

  fetch_one <- function(huc8) {
    url <- paste0('https://nas.er.usgs.gov/api/v2/occurrence/search?huc8=', huc8)
    res <- jsonlite::fromJSON(url, simplifyDataFrame = TRUE)
    rows <- res$results
    if (is.null(rows) || nrow(rows) == 0) return(NULL)
    tibble::tibble(
      scientificName = rows$scientificName,
      commonName     = rows$commonName,
      group          = rows$group,
      year           = as.integer(rows$year),
      lon            = as.numeric(rows$decimalLongitude),
      lat            = as.numeric(rows$decimalLatitude)
    )
  }

  group_name_changes <- c(
    'Amphibians-Frogs'    = 'Amphibians',
    'Crustaceans-Crabs'   = 'Crustaceans',
    'Marine Fishes'       = 'Fishes',
    'Mollusks-Bivalves'   = 'Mollusks',
    'Mollusks-Gastropods' = 'Mollusks',
    'Reptiles-Lizards'    = 'Reptiles',
    'Reptiles-Snakes'     = 'Reptiles',
    'Reptiles-Turtles'    = 'Reptiles'
  )
  keep_groups <- c('Amphibians', 'Crustaceans', 'Fishes', 'Mammals', 'Mollusks', 'Plants', 'Reptiles')

  out <- huc8_list |>
    purrr::map(fetch_one) |>
    dplyr::bind_rows() |>
    dplyr::mutate(
      group = ifelse(.data$group %in% names(group_name_changes), group_name_changes[.data$group], .data$group),
      source = 'NAS'
    ) |>
    dplyr::filter(.data$group %in% keep_groups)

  return(out)

}
