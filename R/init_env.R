clear_env <<- function() {
  rm(list = ls())
}

clear_mem <<- function() {
  gc()
}

clear_all <<- function(restart_R = T) {
  clear_env()
  clear_mem() 
  if(restart_R) .rs.restartR()
}

load_pkgs <<-
  function(packages = c(),
           basic.packages = c(
             "package:stats",
             "package:graphics",
             "package:grDevices",
             "package:utils",
             "package:datasets",
             "package:methods",
             "package:base"
           )) {
    package.list <-
      search()[ifelse(unlist(gregexpr("package:", search())) == 1, TRUE, FALSE)]
    package.list <- setdiff(package.list, basic.packages)
    if (length(package.list) > 0)
      for (package in package.list)
        detach(package, character.only = TRUE)
    installed_packages <-
      packages %in% rownames(installed.packages())
    if (any(installed_packages == FALSE)) {
      install.packages(packages[!installed_packages], dependencies = T)
    }
    invisible(lapply(packages, library, character.only = TRUE))
  }


load_helper_func <<- function(select = c()) {
  `%+=%` <<- function(e1, e2)
    eval.parent(substitute(e1 <- e1 + e2))
  `%-=%` <<- function(e1, e2)
    eval.parent(substitute(e1 <- e1 - e2))
  `%!in%` <<- function(x, y)
    ! ('%in%'(x, y))
}


load_tf_gpu_env <<-
  function(force_rein_minicon = F,
           force_rein_tf_env = F,
           envname = "r_tf_gpu",
           python_version = "3.9") {
    if (!require("reticulate")) install.packages("reticulate")
    if (!require("tensorflow")) install.packages("tensorflow")
    if (!require("keras")) install.packages("keras")
    
    if (force_rein_minicon) print("Force reinstalling Miniconda...") 
    
    tryCatch(
      expr = {
        install_miniconda(force = force_rein_minicon)
      },
      error = function(e) {
        if (grepl("Miniconda is already installed", e, fixed = TRUE)) {
          print("Miniconda is already installed. ")
        } else {
          print(e)
        }
      },
      warning = function(w) {
        print(w)
      },
      finally = {
        if (force_rein_tf_env) {
          print(paste("Force reinstalling ", envname, " environment..."))
          conda_remove(envname)
          conda_create(envname = envname,
                       packages = "tensorflow-gpu",
                       python_version = python_version)
        } else if (!(envname %in% conda_list()$name)) {
          conda_create(envname = envname,
                       packages = "tensorflow-gpu",
                       python_version = python_version)
        } else {
          print(paste(envname, " is already installed. "))
        }
        use_condaenv(envname)
      }
    )
    
  }
