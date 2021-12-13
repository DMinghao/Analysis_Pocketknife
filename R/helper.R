if(!require(tidyverse))
  install.packages("tidyverse")


`%+=%` <- function(e1, e2) {
  eval.parent(substitute(e1 <- e1 + e2))
}

`%-=%` <- function(e1, e2) {
  eval.parent(substitute(e1 <- e1 - e2))
}

`%!in%` <- function(x, y) {
  !('%in%'(x, y))
}
