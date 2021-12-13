rm(list = ls())

gc()

if (!require(downloader))
  install.packages("downloader")

downloader::source_url(
  "https://raw.githubusercontent.com/DMinghao/Analysis_Pocketknife/main/R/import.R",
  downloader::sha_url(
    "https://raw.githubusercontent.com/DMinghao/Analysis_Pocketknife/main/R/import.R"
  )
)