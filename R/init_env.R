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
    installed_packages <- packages %in% rownames(installed.packages())
    if (any(installed_packages == FALSE)) {
      install.packages(packages[!installed_packages], dependencies = T)
    }
    invisible(lapply(packages, library, character.only = TRUE))
  }


load_helper_func <<- function(select = c()){
  `%+=%` <- function(e1,e2) eval.parent(substitute(e1 <- e1 + e2))
  `%-=%` <- function(e1,e2) eval.parent(substitute(e1 <- e1 - e2))
  `%!in%` <- function(x,y)!('%in%'(x,y))
}