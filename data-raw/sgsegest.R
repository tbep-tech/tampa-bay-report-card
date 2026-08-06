library(usethis)

source(here::here('R', 'util_rdataload.R'))

# seagrass coverage estimates by bay segment and year, from the
# seagrass-analysis pipeline (tbep-tech/seagrass-analysis)
sgsegest <- util_rdataload('https://github.com/tbep-tech/seagrass-analysis/raw/refs/heads/main/data/sgsegest.RData')

usethis::use_data(sgsegest, overwrite = TRUE)
