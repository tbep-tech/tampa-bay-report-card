# Sediment quality (PEL/TEL) outcome by bay segment and year

Sediment quality (PEL/TEL) outcome by bay segment and year

## Usage

``` r
anlz_sed_peltel(sedimentdata, yrs)
```

## Arguments

- sedimentdata:

  data.frame of raw sediment monitoring data, e.g.
  [`tbeptools::sedimentdata`](https://rdrr.io/pkg/tbeptools/man/sedimentdata.html)

- yrs:

  integer vector of years to assess, passed to
  [`anlz_sedimentpelave`](https://rdrr.io/pkg/tbeptools/man/anlz_sedimentpelave.html)
  one year at a time

## Value

A data.frame with columns `yr`, `bay_segment`, `ave` (average sediment
contamination score), `grd` (letter grade A-F), and `outcome` (0-1, 1 =
best)

## Details

Grades each bay segment/year by its average sediment contamination score
(`ave`, from
[`anlz_sedimentpelave`](https://rdrr.io/pkg/tbeptools/man/anlz_sedimentpelave.html))
into A-F , then converts the grade to a 0-1 outcome with
[`util_outcome`](https://tbep-tech.github.io/tbepreport/reference/util_outcome.md)
(`type = "category"`).

## Examples

``` r
anlz_sed_peltel(tbeptools::sedimentdata, yrs = 2020)
#> # A tibble: 7 × 5
#>      yr bay_segment    ave grd   outcome
#>   <dbl> <chr>        <dbl> <fct>   <dbl>
#> 1  2020 BCB         0.0329 C        0.5 
#> 2  2020 HB          0.0447 C        0.5 
#> 3  2020 LTB         0.0209 C        0.5 
#> 4  2020 MR          0.0989 D        0.25
#> 5  2020 MTB         0.0136 B        0.75
#> 6  2020 OTB         0.0350 C        0.5 
#> 7  2020 TCB         0.0481 C        0.5 
```
