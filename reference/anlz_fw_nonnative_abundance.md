# Non-native species abundance outcome by bay segment and year

Non-native species abundance outcome by bay segment and year

## Usage

``` r
anlz_fw_nonnative_abundance(obs)
```

## Arguments

- obs:

  output of
  [`anlz_fw_nonnative_obs`](https://tbep-tech.github.io/tbepreport/reference/anlz_fw_nonnative_obs.md)

## Value

A data.frame with columns `yr`, `bay_segment` (abbreviated), `value`
(0-100 percentile of area-normalized abundance), and `outcome` (0-1, 1 =
best)

## Details

Counts occurrences per bay segment/year, normalizes by segment area
(plus an AOI-wide `"All"` total normalized by total AOI area, from
[`util_fw_nonnative_areas`](https://tbep-tech.github.io/tbepreport/reference/util_fw_nonnative_areas.md)),
converts to a percentile with
[`util_percentile`](https://tbep-tech.github.io/tbepreport/reference/util_percentile.md),
then reshapes to long format and reverses to a 0-1 outcome with
[`util_fw_nonnative_long`](https://tbep-tech.github.io/tbepreport/reference/util_fw_nonnative_long.md)
(higher abundance is worse).

## Examples

``` r
if (FALSE) { # \dontrun{
obs <- anlz_fw_nonnative_obs()
anlz_fw_nonnative_abundance(obs)
} # }
```
