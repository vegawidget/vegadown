# vegadown 0.0.0 (development version)

* Added functions `vegadown()` and `vegadown_labels()` to access vegaspecs created using `vegajson` or `vegayaml`.

* Added knitr engines for `vegajson` and `vegayaml` (also `vegayml`); these are activated when the package namespace is attached.
  These become languages you can specify in RMarkdown code-chunks; they render the code as vegawidgets.

