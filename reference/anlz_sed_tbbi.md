# Benthic index (TBBI) outcome by bay segment and year

Benthic index (TBBI) outcome by bay segment and year

## Usage

``` r
anlz_sed_tbbi(benthicdata)
```

## Arguments

- benthicdata:

  raw benthic monitoring data, e.g.
  [`tbeptools::benthicdata`](https://rdrr.io/pkg/tbeptools/man/benthicdata.html)

## Value

A data.frame with columns `yr`, `bay_segment`, `TBBICat` (`"Poor"`,
`"Fair"`, or `"Good"`), and `outcome` (0-1, 1 = best)

## Details

Uses
[`anlz_tbbiscr`](https://rdrr.io/pkg/tbeptools/man/anlz_tbbiscr.html)
and
[`anlz_tbbimed`](https://rdrr.io/pkg/tbeptools/man/anlz_tbbimed.html) to
grade each bay segment/year Poor/Fair/Good, drops the aggregate
`"All"`/`"All (wt)"` rows those functions also return (keeping only the
real bay segments), then converts the grade to a 0-1 outcome with
[`util_outcome`](https://tbep-tech.github.io/tbepreport/reference/util_outcome.md)
(`type = "category"`).

## Examples

``` r
anlz_sed_tbbi(tbeptools::benthicdata)
#> # A tibble: 222 × 4
#> # Rowwise: 
#>       yr bay_segment TBBICat outcome
#>    <dbl> <chr>       <fct>     <dbl>
#>  1  1995 BCB         Good        1  
#>  2  1996 BCB         Poor        0  
#>  3  1997 BCB         Poor        0  
#>  4  1998 BCB         Poor        0  
#>  5  1999 BCB         Fair        0.5
#>  6  2000 BCB         Fair        0.5
#>  7  2001 BCB         Poor        0  
#>  8  2002 BCB         Poor        0  
#>  9  2003 BCB         Poor        0  
#> 10  2004 BCB         Poor        0  
#> # ℹ 212 more rows
```
