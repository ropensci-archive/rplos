#' Connect with PLoS API data
#'
#' rplos provides a wrapper to the PLoS Search API and the Article-Level
#' metrics API.  More information about each function can be found in
#' its help documentation.
#'
#' rplos functions
#'
#' Most rplos functions make web calls (using the httr package), and either
#' parse xml (using the XML package) or json (using the jsonlite package)
#' results.
#'
#' PLoS API keys
#'
#' You used to need an API key to use this package - no longer as of 2015-01-13
#' 
#' rplos tutorial at rOpenSci website here:
#' http://ropensci.org/tutorials/rplos-tutorial/
#'
#' Tutorials
#'
#' See the rOpenSci website for a tutorial:
#' http://ropensci.org/tutorials/rplos_tutorial.html
#'
#' @docType package
#' @name rplos
#' @aliases rplos rplos-package
NULL

#' Defunct functions in rplos
#'
#' \itemize{
#'  \item \code{\link{crossref}}: service no longer provided
#' }
#'
#' @name rplos-defunct
NULL
