#' Concatenate author names, if present, used in other functions.
#' 
#' @param x a single list element with PLoS API returned nested elements
#' @return data.frame of results, with authors concatenated to single vector.
#' @export
#' @keywords internal
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

#' Function to get an API key. 
#' 
#' Checks first to get key from your .Rprofile file for an API key with the name
#' 		'PlosApiKey'. If it is not found, the default guest key is used. 
#' 
#' @param x An API key, defaults to NULL.
#' @examples \dontrun{
#' getkey()
#' } 
#' @export
#' @keywords internal
getkey <- function(x = NULL) {	
	if(is.null(x)){
		key <- getOption("PlosApiKey")
		
		if(is.null(key)){
			key <- "MUvThuaeRNV2cNs"
			message("Using default key: Please get your own API key at http://api.plos.org/")
		} else 
			if(class(key)=="character"){key <- key} else 
				{ stop("check your key input - it should be a character string") }
	} else 
		{ key <- x }
	key
}

#' Replacement function for ldply that should be faster in all cases. 
#' 
#' @importFrom plyr rbind.fill
#' @param x A list.
#' @param convertvec Convert a vector to a data.frame before rbind is called.
#' @export
#' @keywords internal
ldfast <- function(x, convertvec=FALSE){
  convert2df <- function(x){
    if(!inherits(x, "data.frame")) 
      data.frame(rbind(x))
    else
      x
  }
  
  if(convertvec)
    do.call(rbind.fill, lapply(x, convert2df))
  else
    do.call(rbind.fill, x)
}

#' Function to insert "none" character strings where NULL values found to faciliate combining results
#' @export
#' @keywords internal
insertnones <- function(x) {
	f2 <- strsplit(fields, ",")[[1]]
	toadd <- f2[! f2 %in% names(x) ]
	values <- rep("none", length(toadd))
	names(values) <- toadd
	values <- as.list(values)
	x <- c(x, values)
	x
}