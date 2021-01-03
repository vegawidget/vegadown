# reference: https://github.com/rstudio/r2d3/blob/master/R/zzz.R

.onAttach <- function(...) {

  knitr::knit_engines$set(
    json = engine_json,
    yaml = engine_yaml,
    yml = engine_yaml
  )
}
