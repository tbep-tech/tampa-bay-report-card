# Overall water quality outcome by bay segment and year

Overall water quality outcome by bay segment and year

## Usage

``` r
anlz_wq_overall(
  wqindicators,
  bay_segments = c("OTB", "HB", "MTB", "LTB"),
  yr_min = 2000
)
```

## Arguments

- wqindicators:

  output of
  [`anlz_wq_indicators`](https://tbep-tech.github.io/tbepreport/reference/anlz_wq_indicators.md)

- bay_segments:

  chr vector of bay segments to include, defaults to
  `c('OTB', 'HB', 'MTB', 'LTB')`, the four segments with the most
  complete indicator coverage

- yr_min:

  integer, minimum year to include, defaults to `2000`

## Value

A data.frame with columns `bay_segment`, `yr`, `outcome` (0-1, 1 =
best), and `n_indicator` (number of indicators averaged for that
segment/year)

## Details

Averages `outcome` across whatever indicators have data for a given bay
segment/year - see `n_indicator` in the output for how many contributed.
**This is a water-quality-only score**: how sediment, fish/wildlife, and
habitat indicators combine with it into one overall bay-segment score is
not yet designed.

## Examples

``` r
if (FALSE) { # \dontrun{
anlz_wq_overall(wqindic)
} # }
```
