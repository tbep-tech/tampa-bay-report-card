# Fetch USGS NAS non-native species occurrences for a set of HUC8 watersheds

Fetch USGS NAS non-native species occurrences for a set of HUC8
watersheds

## Usage

``` r
util_fw_fetch_nas(
  huc8_list = c("03100101", "03100201", "03100202", "03100203", "03100204", "03100205",
    "03100206", "03100207", "03100208")
)
```

## Arguments

- huc8_list:

  chr vector of HUC8 watershed codes to query, defaults to the 9 codes
  covering the Tampa Bay area (from
  [tbep-invasives](https://github.com/tbep-tech)'
  `config/settings.yaml`)

## Value

A data.frame with columns `scientificName`, `commonName`, `group`,
`year`, `lon`, `lat`, and `source` (always `"NAS"`)

## Details

Queries the public [USGS Nonindigenous Aquatic Species
(NAS)](https://nas.er.usgs.gov/api/v2/occurrence/search) occurrence API
once per HUC8 code and combines the results. Dashed NAS taxonomic group
names (e.g. `"Amphibians-Frogs"`) are collapsed to their parent group
(matching `tbep-invasives`' `download_invasives.py`), and only
`Amphibians`, `Crustaceans`, `Fishes`, `Mammals`, `Mollusks`, `Plants`,
and `Reptiles` are kept.

## Examples

``` r
if (FALSE) { # \dontrun{
util_fw_fetch_nas()
} # }
```
