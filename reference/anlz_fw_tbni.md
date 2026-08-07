# Tampa Bay Nekton Index (TBNI) outcome by bay segment and year

Tampa Bay Nekton Index (TBNI) outcome by bay segment and year

## Usage

``` r
anlz_fw_tbni(fimdata)
```

## Arguments

- fimdata:

  data.frame of raw fisheries independent monitoring data, e.g.
  [`tbeptools::fimdata`](https://rdrr.io/pkg/tbeptools/man/fimdata.html)

## Value

A data.frame with columns `bay_segment`, `yr`, `Segment_TBNI` (the raw
0-100 score), `Action` (management action category from
[`anlz_tbniave`](https://rdrr.io/pkg/tbeptools/man/anlz_tbniave.html)),
and `outcome` (0-1, 1 = best)

## Details

Uses
[`anlz_tbniscr`](https://rdrr.io/pkg/tbeptools/man/anlz_tbniscr.html)
and
[`anlz_tbniave`](https://rdrr.io/pkg/tbeptools/man/anlz_tbniave.html) to
score each bay segment/year 0-100, then converts to a 0-1 outcome with
[`util_outcome`](https://tbep-tech.github.io/tbepreport/reference/util_outcome.md)
(`type = "continuous"`, `from = c(0, 100)`). **Caveat**: this is a plain
linear rescale - it does not yet account for TBNI's actual grade
breakpoints (On Alert below 32, Caution from 32 to 46, Stay the Course
above 46), which is a known simplification to revisit.

## Examples

``` r
anlz_fw_tbni(tbeptools::fimdata)
#> # A tibble: 108 × 5
#>    bay_segment    yr Segment_TBNI Action          outcome
#>    <chr>       <dbl>        <dbl> <fct>             <dbl>
#>  1 HB           1998           47 Stay the Course    0.47
#>  2 HB           1999           47 Stay the Course    0.47
#>  3 HB           2000           44 Caution            0.44
#>  4 HB           2001           44 Caution            0.44
#>  5 HB           2002           39 Caution            0.39
#>  6 HB           2003           41 Caution            0.41
#>  7 HB           2004           41 Caution            0.41
#>  8 HB           2005           32 Caution            0.32
#>  9 HB           2006           41 Caution            0.41
#> 10 HB           2007           42 Caution            0.42
#> # ℹ 98 more rows
```
