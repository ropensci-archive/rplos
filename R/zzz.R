#' Concatenate author names, if present, used in other functions.
#'
#' @param x a single list element with PLoS API returned nested elements
#' @return data.frame of results, with authors concatenated to single vector.
#' @export
#' @keywords internal
concat_todf <- function(x){
	if(inherits(x$author_display, "character")){
	  if(length(x$author_display) > 1){
	    x$author_display<-paste(x$author_display, collapse=", ")
	  } else
		{x$author_display<-x$author_display}
		data.frame(x)
	} else
		if(inherits(x$author, "character")){
			if(length(x$author) > 1){x$author<-paste(x$author, collapse=", ")} else
			{x$author<-x$author}
			data.frame(x)
		} else
	data.frame(x)
}

#' Adds elements in a list that are missing because they were not returned
#' in the PLoS API call.
#'
#' @param x A list with PLoS API returned nested elements
#' @return A list with the missing element added with an
#' 		"na", if it is missing.
#' @export
#' @keywords internal
addmissing <- function(x){
	names_ <- names(x[[which.max(lapply(x, length))]])

	bbb <- function(x){
		if(identical(names_[!names_ %in% names(x)], character(0))){x} else
		{
			xx <- rep("na", length(names_[!names_ %in% names(x)]))
			names(xx) <- names_[!names_ %in% names(x)]
			c(x, xx)
		}
	}
	lapply(x, bbb)
}

#' Function to insert "none" character strings where NULL values found to
#' faciliate combining results
#'
#' @export
#' @keywords internal
insertnones <- function(x)
{
	fields = NULL
	f2 <- strsplit(fields, ",")[[1]]
	toadd <- f2[! f2 %in% names(x) ]
	values <- rep("none", length(toadd))
	names(values) <- toadd
	values <- as.list(values)
	x <- c(x, values)
	x
}

# plyr compact
ploscompact <- function(l) Filter(Negate(is.null), l)

#' Check response from PLOS, including status codes, server error messages, mime-type, etc.
#' @export
#' @keywords internal
check_response <- function(x){
  if(!x$status_code == 200){
    stnames <- names(content(x))
    if(!is.null(stnames)){
      if('error' %in% stnames){
        stop(sprintf("(%s) - %s", x$status_code, content(x)$error$msg), call. = FALSE)
      } else { stop(sprintf("(%s)", x$status_code), call. = FALSE) }
    } else { stop_for_status(x) }
  }
  assert_that(x$headers$`content-type` == 'application/json;charset=UTF-8')
  res <- content(x, as = 'text', encoding = "UTF-8")
  out <- RJSONIO::fromJSON(res)
  if('response' %in% names(out)){
    if(out$response$numFound == 0){ 
      message("Sorry, no data found")
      out 
    }
  } else {
    if( class(try(out$response, silent=TRUE))=="try-error" | is.null(try(out$response, silent=TRUE)) )
      stop("Sorry, no data found")
  }
  return( out )
}
