# reference: https://www.r-bloggers.com/2013/04/package-wide-variablescache-in-r-packages/

vegadown_env <- new.env()

#' Access vegaspecs
#'
#' @param name `character` name of the code chunk to access
#'
#' @return `list()` with S3 class `vegaspec`.
#' @export
#'
vegadown <- function(name) {
  get(name, envir = vegadown_env)
}
