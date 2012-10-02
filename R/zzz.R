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