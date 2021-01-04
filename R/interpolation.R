
# operates on a *single* item
interp_single <- function(x, .envir = parent.frame()) {

  regex <- "^\\$\\{(.*)\\}$"

  # susbstitute if this is the entire string
  if (grepl(regex, trimws(x))) {

    text <- gsub(regex, "\\1", trimws(x))

    # how to sanitize text?
    x <- eval(parse(text = text), envir = .envir)

    return(x)
  }

  # otherwise, interpolate
  x <- unclass(vegawidget::glue_js(x, .envir = .envir))

  if (length(x) > 1) {
    stop("Interpolation failed, length greater than one.", call. = FALSE)
  }

  x
}

# operates recursively
interp_transverse <- function(x, .envir = parent.frame()) {

  if (is.character(x)) {

    if (identical(length(x), 1L)) {
      x <- interp_single(x, .envir = .envir)
    } else {
      x <- purrr::map(x, interp_single, .envir = .envir)
    }

    return(x)
  }

  if (is.list(x) && !is.data.frame(x)) {
    x <- purrr::map(x, interp_transverse, .envir = .envir)
    return(x)
  }

  x
}
