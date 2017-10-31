conn_plos <- NULL
.onLoad <- function(libname, pkgname){
	x <- solrium::SolrClient$new(host = "api.plos.org", path = "search", port = NULL)
  conn_plos <<- x
}
