# Fecal indicator bacteria (FIB) outcome by bay segment and year

Fecal indicator bacteria (FIB) outcome by bay segment and year

## Usage

``` r
anlz_wq_fib(enterodata)
```

## Arguments

- enterodata:

  data.frame of raw enterococcus monitoring data, e.g.
  [`tbeptools::enterodata`](https://rdrr.io/pkg/tbeptools/man/enterodata.html)

## Value

A data.frame with columns `bay_segment`, `yr`, and `outcome` (0-1, 1 =
best)

## Details

Uses
[`anlz_fibmatrix`](https://rdrr.io/pkg/tbeptools/man/anlz_fibmatrix.html)
to grade each bay segment/year A-E, then converts the grade to a 0-1
outcome with
[`util_outcome`](https://tbep-tech.github.io/tbepreport/reference/util_outcome.md)
(`type = "category"`).

## Examples

``` r
anlz_wq_fib(tbeptools::enterodata)
#> # A tibble: 107 × 3
#>    bay_segment    yr outcome
#>    <chr>       <dbl>   <dbl>
#>  1 LTB          2002    1   
#>  2 OTB          2003    0.25
#>  3 HB           2003    0.25
#>  4 MTB          2003    0.75
#>  5 LTB          2003    1   
#>  6 OTB          2004    0.25
#>  7 HB           2004    0.25
#>  8 MTB          2004    0.75
#>  9 LTB          2004    1   
#> 10 OTB          2005    0.25
#> # ℹ 97 more rows
```
