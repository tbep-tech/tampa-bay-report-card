# Combine water quality indicators into a single long-format table

Combine water quality indicators into a single long-format table

## Usage

``` r
anlz_wq_indicators(wqattain, wqthresh, wqload, wqtidalcreeks, wqfib)
```

## Arguments

- wqattain:

  output of
  [`anlz_wq_attain`](https://tbep-tech.github.io/tbepreport/reference/anlz_wq_attain.md)

- wqthresh:

  output of
  [`anlz_wq_thresh`](https://tbep-tech.github.io/tbepreport/reference/anlz_wq_thresh.md)

- wqload:

  output of
  [`anlz_wq_load`](https://tbep-tech.github.io/tbepreport/reference/anlz_wq_load.md)

- wqtidalcreeks:

  output of
  [`anlz_wq_tidalcreeks`](https://tbep-tech.github.io/tbepreport/reference/anlz_wq_tidalcreeks.md)

- wqfib:

  output of
  [`anlz_wq_fib`](https://tbep-tech.github.io/tbepreport/reference/anlz_wq_fib.md)

## Value

A data.frame with columns `bay_segment`, `yr`, `indicator`
(`"wq_attain"`, `"chla_thresh"`, `"la_thresh"`, `"tn_load"`,
`"tnhy_load"`, `"tidal_creeks"`, `"fib"`), and `outcome` (0-1, 1 = best)

## Details

Stacks
([`bind_rows`](https://dplyr.tidyverse.org/reference/bind_rows.html))
rather than joins the five water quality indicators, since bay
segment/year coverage differs by indicator - a segment/year missing from
one indicator's source data simply has no row for it, rather than an
`NA`-filled one.

## Examples

``` r
if (FALSE) { # \dontrun{
anlz_wq_indicators(
  anlz_wq_attain(tbeptools::epcdata),
  anlz_wq_thresh(tbeptools::epcdata),
  anlz_wq_load(totanndat),
  anlz_wq_tidalcreeks(tbeptools::tidalcreeks, tbeptools::iwrraw, yrs = 2015:2020),
  anlz_wq_fib(tbeptools::enterodata)
)
} # }
```
