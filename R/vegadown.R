# reference: https://www.r-bloggers.com/2013/04/package-wide-variablescache-in-r-packages/

vegadown_env <- new.env()

vegadown <- function(name) {
  get(name, envir = vegadown_env)
}
