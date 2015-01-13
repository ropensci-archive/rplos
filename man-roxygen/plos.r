#' @param q Search terms (character). You can search on specific fields by
#'    doing 'field:your query'. For example, a real query on a specific field would
#'    be 'author:Smith'.
#' @param fl Fields to return from search (character) [e.g., 'id,title'],
#'    any combination of search fields (see the dataset \code{plosfields})
#' @param fq List specific fields to filter the query on (if NA, all queried).
#'    The options for this parameter are the same as those for the fl parameter.
#'    Note that using this parameter doesn't influence the actual query, but is used
#'    to filter the resuls to a subset of those you want returned. For example,
#'    if you want full articles only, you can do \code{'doc_type:full'}. In another example,
#'    if you want only results from the journal PLOS One, you can do
#'    \code{'cross_published_journal_key:PLoSONE'}. See \code{\link{journalnamekey}} for journal
#'    abbreviations.
#' @param sort Sort results according to a particular field, and specify ascending (asc)
#'    or descending (desc) after a space; see examples. For example, to sort the
#'    counter_total_all field in descending fashion, do sort='counter_total_all desc'
#' @param start Record to start at (used in combination with limit when
#'    you need to cycle through more results than the max allowed=1000)
#' @param limit Number of results to return (integer). Setting \code{limit=0} returns only
#'    metadta.
#' @param sleep Number of seconds to wait between requests. No need to use this for
#'    a single call to searchplos. However, if you are using searchplos in a loop or
#'    lapply type call, do sleep parameter is used to prevent your IP address from being
#'    blocked. You can only do 10 requests per minute, so one request every 6 seconds is
#'    about right.
#' @param ... Optional additional curl options (debugging tools mostly), passed on to
#' \code{\link[httr]{GET}}
#' @param terms DEPRECATED PARAMETER - replaced with the \code{q} param.
#' @param fields DEPRECATED PARAMETER - replaced with the \code{fl} param.
#' @param toquery DEPRECATED PARAMETER - replaced with the \code{fq} param.
#' @param callopts DEPRECATED PARAMETER - replaced with the \code{...} param.
#'
#' @details Details:
#' @section Faceting:
#' Read more about faceting here: url{http://wiki.apache.org/solr/SimpleFacetParameters}
#'
#' @section Website vs. API behavior:
#' Don't be surprised if queries you perform in a scripting language, like using \code{rplos}
#' in R, give different results than when searching for articles on the PLOS website. I am
#' not sure what exact defaults they use on their website. There are a few things to consider.
#' You can tweak which types of articles are returned: Try using the \code{article_type}
#' filter in the \code{fq} parameter. For which journal to search, e.g., do
#' \code{'cross_published_journal_key:PLoSONE'}. See \code{journalnamekey()} for journal
#' abbreviations.
