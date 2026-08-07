# Load an RData file from a URL

Load an RData file from a URL

## Usage

``` r
util_rdataload(dataurl = NULL)
```

## Arguments

- dataurl:

  chr string of the URL for the RData file, expected to contain a single
  object named the same as the file (minus the `.RData` extension)

## Value

The R object stored in the RData file.

## Details

Tries to load the file directly from `dataurl`. If that fails (e.g. the
host doesn't support [`url()`](https://rdrr.io/r/base/connections.html)
connections), falls back to downloading the file to a temporary location
first, then loading it from there. The downloaded file is removed via
[`on.exit()`](https://rdrr.io/r/base/on.exit.html) once the function
returns, whether the fallback succeeds or fails.

## Examples

``` r
if (FALSE) { # \dontrun{
totanndat <- util_rdataload("https://github.com/tbep-tech/load-estimates/raw/main/data/totanndat.RData")
} # }
```
