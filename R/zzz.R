#' Concatenate author names, if present, used in other functions.
#' 
#' @param x a single list element with PLoS API returned nested elements
#' @return data.frame of results, with authors concatenated to single vector.
#' @export
concat_todf <- function(x){
	if(inherits(x$author_display, "character")){
		if(length(x$author_display) > 1){x$author_display<-paste(x$author_display, collapse=", ")} else
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
addmissing <- function(x){
	names_ <- names(x[[which.max(laply(x, length))]])
	
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