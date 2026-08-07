# Tidal creek condition outcome by bay segment and year

Tidal creek condition outcome by bay segment and year

## Usage

``` r
anlz_wq_tidalcreeks(tidalcreeks, iwrraw, yrs)
```

## Arguments

- tidalcreeks:

  sf object of tidal creek assessment segments, e.g.
  [`tbeptools::tidalcreeks`](https://rdrr.io/pkg/tbeptools/man/tidalcreeks.html)

- iwrraw:

  data.frame of raw IWR water quality data for tidal creeks, e.g.
  [`tbeptools::iwrraw`](https://rdrr.io/pkg/tbeptools/man/iwrraw.html)

- yrs:

  integer vector of years to assess, passed to
  [`anlz_tdlcrk`](https://rdrr.io/pkg/tbeptools/man/anlz_tdlcrk.html)

## Value

A data.frame with columns `bay_segment`, `yr`, `outcome` (0-1, 1 =
best), and `n_assessed` (number of creek records feeding that
segment/year's outcome)

## Details

Each tidal creek is assigned to the bay segment subwatershed
([`tbsegshed`](https://rdrr.io/pkg/tbeptools/man/tbsegshed.html)) it
overlaps most (by length, for creeks spanning more than one
subwatershed). Creek condition category scores
(Prioritize/Investigate/Caution/Monitor) are converted to a 0-1 outcome
with
[`util_outcome`](https://tbep-tech.github.io/tbepreport/reference/util_outcome.md)
(`type = "category"`), then averaged to a bay-segment/year outcome,
weighted by each creek's physical length so longer creek segments
contribute proportionally more. Creeks with a "No Data" assessment are
dropped.

## Examples

``` r
if (FALSE) { # \dontrun{
anlz_wq_tidalcreeks(tbeptools::tidalcreeks, tbeptools::iwrraw, yrs = 2015:2020)
} # }
```
