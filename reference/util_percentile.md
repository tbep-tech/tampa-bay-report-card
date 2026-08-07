# Convert a wide data frame of values to percentiles by mean and standard deviation

Convert a wide data frame of values to percentiles by mean and standard
deviation

## Usage

``` r
util_percentile(df, id_cols = "year")
```

## Arguments

- df:

  data.frame with one or more id columns (see `id_cols`) and the
  remaining columns holding numeric values to convert

- id_cols:

  chr vector of column names to carry through unchanged, defaults to
  `"year"`

## Value

A data.frame the same shape as `df`, with non-id columns converted to
percentiles from `0` to `100`

## Details

Computes a single mean and standard deviation across every value in
every non-id column (not per-column), then converts each value to a
percentile via [`pnorm`](https://rdrr.io/r/stats/Normal.html) of its
z-score. This matches the `tbep-invasives` Python pipeline's
`as_percentile_by_mean_std()` exactly, including using one global
mean/sd for the whole table rather than one per column. If the standard
deviation is `0` or undefined (e.g. a single-row input), every value is
given a percentile of `50`.

## Examples

``` r
df <- data.frame(year = 2020:2022, OTB = c(10, 20, 30), HB = c(5, 15, 25))
util_percentile(df)
#>   year      OTB       HB
#> 1 2020 21.13390  9.07246
#> 2 2021 60.53660 39.46340
#> 3 2022 90.92754 78.86610
```
