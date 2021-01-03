# reference: https://www.r-bloggers.com/2013/04/package-wide-variablescache-in-r-packages/

vegadown_env <- new.env()

#' Access vegaspecs
#'
#' @description
#' Any vegaspecs rendered in knitr chunks using `vegajson`, `vegayaml`,
#' or `vegayml` will be stored to a package environment, where they can
#' be accessed using the `vegadown()` function, using the label of a
#' code chunk.
#'
#' To get all the available labels, use `vegadown_labels()`.
#'
#' @param label `character` label of the code chunk to access
#'
#' @return \describe{
#'   \item{`vegadown()`}{`list()` with S3 class `vegaspec`.}
#'   \item{`vegadown_labels()`}{`character` vector, all available labels.}
#' }
#' @examples
#' vegadown_labels()
#'
#' # not run because it depends on side effects
#' \dontrun{
#'   vegadown("json-cars")
#' }
#'
#' @export
#'
vegadown <- function(label) {
  get(label, envir = vegadown_env)
}

#' @rdname vegadown
#' @export
#'
vegadown_labels <- function() {
  names(vegadown_env)
}

