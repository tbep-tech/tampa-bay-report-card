library(sf)
library(usethis)

# bay segment boundaries used to assign non-native species occurrence points
# to a segment, copied from the tbep-invasives repo
# (input_data/shp/TBEP_Bay_Segments_4326.shp). BAY_SEG_GP groups the 7 raw
# segments into 5: Old Tampa Bay, Hillsborough Bay, Middle Tampa Bay,
# Lower Tampa Bay, and Remainder Lower Tampa Bay (Boca Ciega Bay + Manatee
# River + Terra Ceia Bay dissolved together)
bayseg_shp <- st_read(here::here('data-raw', 'TBEP_Bay_Segments_4326.shp'), quiet = TRUE)

usethis::use_data(bayseg_shp, overwrite = TRUE)
