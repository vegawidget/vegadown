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

    # options[["results"]] <- "asis"

    # get code together
    code <- paste(options$code, collapse = '\n')

    # make vegaspec
    spec <- as_vegaspec(parser(code))

    # interpolate from R

    # add to vegadown
    assign(options$label, spec, envir = vegadown_env)

    # reset language for markdown highlighting
    options$engine <- language

    # if RStudio GUI
    if (identical(.Platform$GUI, "RStudio")) {

      widget <- vegawidget(
        spec,
        embed = options$vega.embed,
        width = options$vega.width,
        height = options$vega.height
      )

      return(widget)
    }

    widget_output <- knit_print.vegaspec(spec, options = options)
    knitr::engine_output(
      options,
      out = list(
        structure(list(src = options$code), class = 'source'),
        widget_output
      )
    )
  }

}

# from knitr

