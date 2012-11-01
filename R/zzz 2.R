#' Function to get API key. 
#' 
#' Checks first to get key from your .Rprofile file for an API key with the name
#' 		'tropicoskey'. If it is not found, the default key is used. 
#' 
#' @param x An API key, defaults to NULL.
#' @param service The API data provider, used to match to default guest key.
#' @examples \dontrun{
#' getkey(service="tropicos")
#' getkey(service="EOL")
#' } 
#' @export
getkey <- function(x = NULL, service) {	
	if(is.null(x)){
		service <- match.arg(service, 
											 c("tropicoskey","EOLApi","uBioApi","pmkey"), 
											 several.ok=F)	
		
		key <- getOption(service)
		
		if(is.null(key)){
			keys <- c("00ca3d6a-cbcc-4924-b882-c26b16d54446",
								"44f1a53227f1c0b6238a997fcfe7513415f948d2",
								"750bc6b8a550f2b9af1e8aaa34651b4c1111862a",
								"530763730")
			names(keys) <- c("tropicoskey","EOLApi","uBioApi","pmkey")
			key <- keys[[service]]
			urls <- c("http://services.tropicos.org/help?requestkey",
								"http://eol.org/users/register",
								"http://www.ubio.org/index.php?pagename=form",
								"http://www.plantminer.com/")
			names(urls) <- c("tropicoskey","EOLApi","uBioApi","pmkey")
			message(paste("Using default key: Please get your own API key at ", 
										urls[service], sep=""))
		} else 
			
			if(class(key)=="character"){key <- key} else 
				{ stop("check your key input - it should be a character string") }
		
	} else 
		
		{ key <- x }
	key
}