suppressMessages({
  # general purpose ----
  library(here)
  library(tidyverse)
  library(fs)
  
  # alarm project ----
  library(redist)
  library(alarmdata)
})

dir_create(here('data/enumpart'))