# references:
# - https://github.com/rstudio/r2d3/blob/master/R/knit.R
# - https://www.r-bloggers.com/2013/04/package-wide-variablescache-in-r-packages/

engine <- function(language) {

  # the engines for json and yaml are virtually identical:
  #  - use a closure to adapt the function to the language

  parser_key <- list(
    json = identity,
    yaml = yaml::yaml.load
  )

  parser <- parser_key[[language]]

  function(options) {

    # to get htmlwidget to work, we seem to have to set this manually
    options[["results"]] <- "asis"

    # get YAML together
    code <- paste(options$code, collapse = '\n')

    # make vegaspec
    spec <- as_vegaspec(parser(code))

    # interpolate from R

    # add to vegadown
    assign(options$label, spec, envir = vegadown_env)

    # reset language for markdown highlighting
    options$engine <- language

    # combine vega-embed options, favoring local
    opts_embed <- getOption("vega.embed")
    local_embed <- options$vega.embed

    opts_embed[names(local_embed)] <- local_embed

    # set options for rendering
    withr::local_options(
      c(options[c("vega.width", "vega.height")], list(vega.embed = opts_embed))
    )

    if (identical(.Platform$GUI, "RStudio")) {
      return(vegawidget(spec))
    }

    knitr::engine_output(options, code, knit_print.vegaspec(spec))
  }

}

# from knitr

