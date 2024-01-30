mt <- alarm_50state_map('MT') |> 
  group_by(county) |> 
  summarize(
    across(where(is.numeric), sum)
  )

redist.prep.enumpart(
  adj = get_adj(mt),
  unordered_path = 'data/enumpart/up',
  ordered_path   = 'data/enumpart/op',
  weight_path    = 'data/enumpart/wt',
  total_pop = mt$pop
)

redist.run.enumpart(
  ordered_path   = 'data/enumpart/op',
  weight_path    = 'data/enumpart/wt',
  out_path       = 'data/enumpart/en',
  lower = floor(0.99 * sum(mt$pop) / 2),
  upper = ceiling(1.01 * sum(mt$pop) / 2),
  ndists = 2
)

x <- redist.read.enumpart(
  out_path       = 'data/enumpart/en',
  n_max = 1e4
)

sols <- read_lines('data/enumpart/en.dat')


# pl <- redist_plans(
#   x, map = mt, algorithm = 'enumpart'
# )
# write_rds(pl, 'data/test_pl_compression.rds', compress = 'xz')


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
