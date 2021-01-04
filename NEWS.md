# vegadown 0.0.0 (development version)

* You can interpolate objects from your R environment into `vegajson` and `vegayaml` code chunks using `${}` as delimeters.

* Added functions `vegadown()` and `vegadown_labels()` to access vegaspecs created using `vegajson` or `vegayaml`.

* Added knitr engines for `vegajson` and `vegayaml` (`vegayml`); these are activated when the package namespace is attached.
  These become languages you can specify in RMarkdown code-chunks; they render the code as vegawidgets.

