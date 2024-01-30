# on each fresh install of redist, run:
# redist.init.enumpart()

# map data from https://www.nature.com/articles/s41597-022-01808-2
mt <- alarm_50state_map('MT') |> 
  group_by(county) |> 
  `attr<-`('existing_col', NULL) |> 
  summarize(
    across(where(is.numeric), sum)
  )

# creates a reordered graph so the enumeration runs quickest
redist.prep.enumpart(
  adj = get_adj(mt),
  unordered_path = 'data/enumpart/up',
  ordered_path   = 'data/enumpart/op',
  weight_path    = 'data/enumpart/wt',
  total_pop = mt$pop
)

# runs the algorithm
redist.run.enumpart(
  ordered_path   = 'data/enumpart/op',
  weight_path    = 'data/enumpart/wt',
  out_path       = 'data/enumpart/en',
  # plus or minus a quarter percent, rounded to lower/higher integer
  lower = floor(0.9975 * sum(mt$pop) / 2),
  upper = ceiling(1.0025 * sum(mt$pop) / 2),
  ndists = 2
)

# to read the plans into memory
x <- redist.read.enumpart(
  out_path       = 'data/enumpart/en',
  # up to 10k to start
  n_max = 1e4
)

# to create a redist_plans object with `x`
# pl <- redist_plans(
#   x, map = mt, algorithm = 'enumpart'
# )


# Started
# Reading "data/enumpart/op.dat" ... done in 0.00s elapsed, 0.00s user, 4MB.
# #vertex = 56, #edge = 138
# GraphPartitionSpecL31 ...
# Sweeping <10985> ... <8085> in 0.00s elapsed, 0.00s user, 4MB.
# ...
# Sweeping <245696> ... <198404> in 0.00s elapsed, 0.00s user, 10MB.
# ....
# Done GraphPartitionSpecL31 <243134> in 0.06s elapsed, 0.02s user, 8MB.
# Reduction .......... <6087> in 0.00s elapsed, 0.00s user, 8MB.
# #node = 6087, #solution = 7012136966
# lower = 536691, upper = 547534
