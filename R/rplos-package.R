#' Connect with PLoS API data
#'
#' \code{rplos} provides an R interface to the PLoS Search API. More information about each
#' function can be found in its help documentation. If you are looking for PLOS
#' article-Level metrics data, see the \code{alm} package.
#'
#' @section rplos functions:
#'
#' Most rplos functions make web calls using the \code{httr} package, and parse json using
#' the \code{jsonlite} package.
#'
#' @section PLoS API key:
#'
#' You used to need an API key to use this package - no longer needed
#'
#' @section Tutorials:
#'
#' See the rOpenSci website for a tutorial:
#' http://ropensci.org/tutorials/rplos_tutorial.html
#'
#' @examples \dontrun{
#' searchplos(q='ecology', fl=c('id','publication_date'), limit = 2)
#'
#' # Get only full article DOIs
#' out <- searchplos(q="*:*", fl='id', fq='doc_type:full', start=0, limit=250)
#' head(out$data)
#'
#' # Get DOIs for only PLoS One articles
#' out <- searchplos(q="*:*", fl='id', fq='cross_published_journal_key:PLoSONE', start=0, limit=15)
#' head(out$data)
#' }
#'
#' @importFrom stats setNames na.omit
#' @importFrom utils browseURL URLdecode
#' @importFrom methods is
#' @importFrom httr GET content stop_for_status
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr left_join rbind_all
#' @importFrom plyr ddply llply summarise ldply
#' @importFrom reshape2 melt
#' @importFrom whisker whisker.render
#' @importFrom solr solr_highlight solr_facet
#' @importFrom lubridate now
#' @importFrom ggplot2 ggplot aes geom_bar theme_grey geom_line scale_colour_brewer labs theme
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
#'  \item \code{\link{crossref}}: service no longer provided - see the package \code{rcrossref}
#' }
#'
#' @name rplos-defunct
NULL
