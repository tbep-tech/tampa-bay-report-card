library(here)
library(sf)

source(here('R/funcs.R'))

# seagrass segment estimates
sgsegest <- rdataload('https://github.com/tbep-tech/seagrass-analysis/raw/refs/heads/main/data/sgsegest.RData')
save(sgsegest, file = here('data/sgsegest.RData'))

# nonnative species report card boundaries, copied from the tbep-invasives
# repo (input_data/shp/) into data-raw/, saved here as RData so the
# exploratory doc doesn't need to read shapefiles directly
aoi_shp <- st_read(here('data-raw/TBEP_AOI_4326.shp'), quiet = TRUE)
save(aoi_shp, file = here('data/aoi_shp.RData'))

bayseg_shp <- st_read(here('data-raw/TBEP_Bay_Segments_4326.shp'), quiet = TRUE)
save(bayseg_shp, file = here('data/bayseg_shp.RData'))
