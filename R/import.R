if (!require(downloader)) install.packages("downloader")

import_init_ <<- function () {
  downloader::source_url("https://raw.githubusercontent.com/DMinghao/Analysis_Pocketknife/main/R/init_env.R", 
    downloader::sha_url("https://raw.githubusercontent.com/DMinghao/Analysis_Pocketknife/main/R/init_env.R")
  )
} 

import_plotly_ <<- function() {
  downloader::source_url("https://raw.githubusercontent.com/DMinghao/Analysis_Pocketknife/main/R/plotly.R", 
    downloader::sha_url("https://raw.githubusercontent.com/DMinghao/Analysis_Pocketknife/main/R/plotly.R")
  )
}

import_helper_ <<- function() {
  downloader::source_url("https://raw.githubusercontent.com/DMinghao/Analysis_Pocketknife/main/R/helper.R", 
    downloader::sha_url("https://raw.githubusercontent.com/DMinghao/Analysis_Pocketknife/main/R/helper.R")
  )
}

clear_all_ <<- function() {
  downloader::source_url("https://raw.githubusercontent.com/DMinghao/Analysis_Pocketknife/main/R/clear_env.R", 
    downloader::sha_url("https://raw.githubusercontent.com/DMinghao/Analysis_Pocketknife/main/R/clear_env.R")
  )
}