#' @importFrom rlang .data
NULL

#' @importFrom tbeptools anlz_avedat
NULL

# aoi_shp/bayseg_shp are this package's own lazy-loaded data objects,
# referenced by bare name inside anlz_fw_nonnative_obs()/util_fw_nonnative_areas()
utils::globalVariables(c('aoi_shp', 'bayseg_shp'))
