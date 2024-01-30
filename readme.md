# Montana Counties with enumpart

- `R/00_setup.R`: Loads packages and ensures the data output folder is available.
- `R/01_enum_mt.R`: Downloads the data from the Harvard Dataverse, coarsens to counties, and runs the `enumpart` algorithm.

[`enumpart` documentation](https://alarm-redist.org/redist/reference/redist.enumpart.html)
[`enumpart` paper](https://www.tandfonline.com/doi/full/10.1080/2330443X.2020.1791773)


# Code to generate `data/enumpart/ex.dat`

Replace the call to `redist.run.enumpart()` with:

```r
redist.run.enumpart(
  ordered_path   = 'data/enumpart/op',
  weight_path    = 'data/enumpart/wt',
  out_path       = 'data/enumpart/ex',
  # plus or minus a quarter percent, rounded to lower/higher integer
  lower = floor(0.9975 * sum(mt$pop) / 2),
  upper = ceiling(1.0025 * sum(mt$pop) / 2),
  ndists = 2,
  all = FALSE,
  n = 1000
)
```