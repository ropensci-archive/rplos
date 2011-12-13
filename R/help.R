#' Connect with PLoS API data
#'
#' rplos provides a wrapper to the PLoS Search API and the Article-Level 
#' metrics API.  More information about each function can be found in 
#' its help documentation.
#'
#' rplos functions
#'
#' Most rplos functions make web calls (using the RCurl package), and either
#' parse xml (using the XML package) or json (using the RJSONIO package) 
#' results.
#' 
#' PLoS API keys
#'
#' Get your PLoS API key here: http://api.plos.org/.  Put your API key in your 
#' .Rprofile file by adding \code{options(PlosApiKey = "YOURPLOSAPIKEY")}, 
#' and the functions within this package will be able to use your API key 
#' without you having to enter it every time you run a search. 
#' rplos tutorial at rOpenSci website here: 
#' http://ropensci.org/tutorials/rplos-tutorial/ 
#' 
#' Tutorials 
#'
#' See the rOpenSci website for a tutorial: 
#' http://ropensci.org/tutorials/rplos-tutorial/ 
#'
#' @docType package
#' @name rplos
#' @aliases rplos rplos-package
NULL