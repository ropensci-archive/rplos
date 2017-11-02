#' Connect with PLoS API data
#'
#' \code{rplos} provides an R interface to the PLoS Search API. More
#' information about each function can be found in its help documentation.
#'
#' @section rplos functions:
#'
#' \pkg{rplos} functions make HTTP requests using the \pkg{crul} package,
#' and parse json using the \pkg{jsonlite} package.
#'
#' @section PLoS API key:
#'
#' You used to need an API key to use this package - no longer needed
#'
#' @section Tutorials:
#'
#' See the rOpenSci website for a tutorial:
#' https://ropensci.org/tutorials/rplos_tutorial.html
#'
#' @section Throttling:
#' Beware, PLOS recently has started throttling requests. That is,
#' they will give error messages like "(503) Service Unavailable -
#' The server cannot process the request due to a high load", which
#' probably means you've done too many requests in a certain time period.
#'
#' @examples \dontrun{
#' searchplos(q='ecology', fl=c('id','publication_date'), limit = 2)
#'
#' # Get only full article DOIs
#' out <- searchplos(q="*:*", fl='id', fq='doc_type:full', start=0, limit=250)
#' head(out$data)
#'
#' # Get DOIs for only PLoS One articles
#' out <- searchplos(q="*:*", fl='id', fq='journal_key:PLoSONE',
#'   start=0, limit=15)
#' head(out$data)
#' }
#'
#' @importFrom crul HttpClient
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr left_join bind_rows
#' @importFrom plyr ddply llply summarise ldply
#' @importFrom reshape2 melt
#' @importFrom whisker whisker.render
#' @importFrom solrium SolrClient
#' @importFrom lubridate now
#' @importFrom ggplot2 ggplot aes geom_bar theme_grey geom_line
#' scale_colour_brewer labs theme
#' @docType package
#' @name rplos
#' @aliases rplos rplos-package
#' @author Scott Chamberlain \email{myrmecocystus@@gmail.com}
#' @author Carl Boettiger \email{cboettig@@gmail.com}
#' @author Karthik Ram \email{karthik.ram@@gmail.com}
#' @keywords package
NULL

#' Defunct functions in rplos
#'
#' \itemize{
#'  \item \code{\link{crossref}}: service no longer provided -
#'  see the package \code{rcrossref}
#'  \item \code{\link{citations}}: service no longer available
#' }
#'
#' @name rplos-defunct
NULL
