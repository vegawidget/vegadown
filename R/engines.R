# references:
# - https://github.com/rstudio/r2d3/blob/master/R/knit.R
# - https://www.r-bloggers.com/2013/04/package-wide-variablescache-in-r-packages/

engine_json <- function(options) {

  options[["results"]] <- "asis"

  # get JSON together
  code <- paste(options$code, collapse = '\n')

  # make vegaspec
  spec <- as_vegaspec(code)

  # leave room for interpolation

  # add to vegadown
  assign(options$label, spec, envir = vegadown_env)

  knitr::engine_output(options, code, knit_print.vegaspec(spec))
}


engine_yaml <- function(options) {

  options[["results"]] <- "asis"

  # get YAML together
  code <- paste(options$code, collapse = '\n')

  # make vegaspec
  spec <- as_vegaspec(yaml::yaml.load(code))

  # leave room for interpolation

  # add to vegadown
  assign(options$label, spec, envir = vegadown_env)

  knitr::engine_output(options, code, knit_print.vegaspec(spec))
}
