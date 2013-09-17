#' @param terms search terms (character)
#' @param fields fields to return from search (character) [e.g., 'id,title'], 
#'    any combination of search fields [type 'data(plosfields)', then 
#'    'plosfields']
#' @param toquery List specific fields to query (if NA, all queried). The possibilities
#'    for this parameter are the same as those for the fields parameter.
#' @param start Record to start at (used in combination with limit when 
#' you need to cycle through more results than the max allowed=1000)
#' @param limit Number of results to return (integer)
#' @param returndf Return data.frame of results or not (defaults to TRUE).
#' @param key Your PLoS API key, either enter as the key, or loads from .Rprofile. See details.
#' @param sleep Number of seconds to wait between requests. No need to use this for
#'    a single call to searchplos. However, if you are using searchplos in a loop or 
#'    lapply type call, do sleep parameter is used to prevent your IP address from being 
#'    blocked. You can only do 10 requests per minute, so one request every 6 seconds is 
#'    about right. 
#' @param callopts Optional additional curl options (debugging tools mostly)
#' @param curl If using in a loop, call getCurlHandle() first and pass 
#'  the returned value in here (avoids unnecessary footprint)
#'
#' @details 
#' You can store your PLOS Search API key in your .Rprofile file so that you 
#' don't have to enter the key each function call. Open up your .Rprofile file
#' on your computer, and put it an entry like:
#' 
#' options(PlosApiKey = "your plos api key")