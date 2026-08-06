library(sf)
library(usethis)

# area of interest boundary used to clip non-native species occurrence
# points, copied from the tbep-invasives repo (input_data/shp/TBEP_AOI_4326.shp)
aoi_shp <- st_read(here::here('data-raw', 'TBEP_AOI_4326.shp'), quiet = TRUE)

usethis::use_data(aoi_shp, overwrite = TRUE)
