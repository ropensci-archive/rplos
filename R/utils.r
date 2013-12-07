parsehighlight <- function(x) if(length(x) == 0){ NA } else { gsub("<[^>]+>","",x[[1]]) }

parsehighlight2 <- function(alist){
  tt <- c()
  for(i in seq_along(alist)){
    res <- c(names(alist[i]), alist[[i]][1])
    names(res)[1] <- "id"
    res <- lapply(res, parsehighlight)
    tt[[i]] <- res
  }
  tt
}

#' @method print plos
#' @export
print.plos <- function(x, ...)
{
  cat(" Data")
  cat(paste("\nNo. of records:", nrow(x$data)))
  cat(paste("\nNo. of variables:", length(x$data)))
  cat(paste("\nVariables:", paste(names(x$data), collapse=", ") ))
  cat("\n")
  cat("\n Highlighting")
  cat(paste("\nNo. of records:", nrow(x$highlighting)))
  cat(paste("\nNo. of variables:", length(x$highlighting) ))
  cat(paste("\nVariables:", paste(names(x$highlighting), collapse=", ") ))
}