suppressMessages({
  # general purpose ----
  library(here)
  library(tidyverse)
  library(cli)
  library(fs)
  
  # alarm project ----
  library(redist)
  library(alarmdata)
  

})

lapply(Sys.glob(here("R/utils/*.R")), source)

cli_alert_success("Packages loaded and utilities prepared.")