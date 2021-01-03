# reference: https://github.com/rstudio/r2d3/blob/master/R/zzz.R

.onAttach <- function(...) {

  knitr::knit_engines$set(
    vegajson = engine("json"),
    vegayaml = engine("yaml"),
    vegayml  = engine("yaml")
  )
}
