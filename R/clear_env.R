

rm(list = ls())

gc()

# .rs.restartR()

if (!require(downloader))
  install.packages("downloader")

downloader::source_url(
  "https://raw.githubusercontent.com/DMinghao/Analysis_Pocketknife/main/R/import.R",
  downloader::sha_url(
    "https://raw.githubusercontent.com/DMinghao/Analysis_Pocketknife/main/R/import.R"
  )
)