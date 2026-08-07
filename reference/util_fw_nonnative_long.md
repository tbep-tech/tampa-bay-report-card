# Reshape a non-native metric's wide year-by-segment table to long format

Reshape a non-native metric's wide year-by-segment table to long format

## Usage

``` r
util_fw_nonnative_long(df)
```

## Arguments

- df:

  data.frame with a `year` column, one column per bay segment full name
  (e.g. `"Old Tampa Bay"`), and an `"All"` column

## Value

A data.frame with columns `yr`, `bay_segment` (abbreviated, e.g.
`"OTB"`, `"RALTB"` for Remainder Lower Tampa Bay), `value` (the input
percentile, 0-100), and `outcome` (`1 - value / 100`, 0-1, 1 = best)

## Details

Drops the `"All"` column (only needed upstream so
[`util_percentile`](https://tbep-tech.github.io/tbepreport/reference/util_percentile.md)'s
mean/sd includes it), abbreviates bay segment names, and reverses the
percentile to a 0-1 outcome where `1` = best, since higher non-native
abundance/richness is worse.

## Examples

``` r
df <- data.frame(
  year = 2020,
  `Old Tampa Bay` = 80, `Hillsborough Bay` = 20, `Middle Tampa Bay` = 50,
  `Lower Tampa Bay` = 10, `Remainder Lower Tampa Bay` = 30, All = 40,
  check.names = FALSE
)
util_fw_nonnative_long(df)
#> # A tibble: 5 × 4
#>      yr bay_segment value outcome
#>   <int> <chr>       <dbl>   <dbl>
#> 1  2020 OTB            80     0.2
#> 2  2020 HB             20     0.8
#> 3  2020 MTB            50     0.5
#> 4  2020 LTB            10     0.9
#> 5  2020 RALTB          30     0.7
```
