#' Coerce output of searchplos, and similar fxns to data.frame's
#' 
#' @import data.table
#' @param input Output from searchplos, or similar function call
#' @param return One of data, highlighting, or both.
#' @return Either a data.frame or a list of two data.frame's
#' @export
#' @examples \dontrun{
#' out <- searchplos('ecology', 'id,publication_date', limit = 2, highlighting=TRUE)
#' plos_todf(out) # data element returned by default
#' plos_todf(out, 'high')
#' plos_todf(out, 'both')
#' 
#' out <- searchplos(q="*:*", fl='id', fq=list('cross_published_journal_key:PLoSONE', 'doc_type:full'), limit=15)
#' plos_todf(out, 'data') # returns a data.frame
#' plos_todf(out, 'high') # returns "No data"
#' 
#' out <- searchplos(q = 'drosophila', fl='id,author', limit = 50)
#' plos_todf(out, 'data') 
#' 
#' # Highlighting with lots of results
#' out <- searchplos(q='everything:"experiment"', fl='id,title', fq='doc_type:full', 
#'    limit=1100, highlighting = TRUE)
#' head(plos_todf(out))
#' head(plos_todf(out, "high"))
#' }
plos_todf <- function(input, return = 'data')
{
  if(!inherits(input, "plos"))
    stop("Input must be of class plos")
  return <- match.arg(return, choices=c('data','highlighting','both'))
  
  if(attributes(input)$form %in% 'many'){
    input$data <- do.call(c, input$data)
    input$highlighting <- do.call(c, input$highlighting)
  }
  
  if(return=='data'){
    if(is.null(input$data)){
      "No data"
    } else{  
      maxlendat <- max(sapply(input$data, length))
      namesdat <- names(input$data[which.max(sapply(input$data, length))][[1]])
      dat <- lapply(input$data, function(x){
        if(!length(x) < maxlendat){ x } else {
          fillnames <- namesdat[!namesdat %in% names(x)]
          tmp <- c(rep(NA, length(fillnames)), x)
          names(tmp)[seq_along(fillnames)] <- fillnames
          tmp
        }
      })
      data.frame(rbindlist(dat))
    }
  } else if(return=='highlighting'){
    if(is.null(input$highlighting)){
      "No data"
    } else {  
      maxlenhl <- max(sapply(input$highlighting, length))
      nameshl <- names(input$highlighting[which.max(sapply(input$highlighting, length))][[1]])  
      hl <- lapply(input$highlighting, function(x){
        if(!length(x) < maxlenhl){ x } else {
          fillnames <- nameshl[!nameshl %in% names(x)]
          tmp <- c(rep(NA, length(fillnames)), x)
          names(tmp)[seq_along(fillnames)] <- fillnames
          tmp
        }
      })
      data.frame(rbindlist(parsehighlight2(hl)))
    }
  } else {
    if(is.null(input$data)){
      datout <- "No data"
    } else{  
      maxlendat <- max(sapply(input$data, length))
      namesdat <- names(input$data[which.max(sapply(input$data, length))][[1]])
      dat <- lapply(input$data, function(x){
        if(!length(x) < maxlendat){ x } else {
          fillnames <- namesdat[!namesdat %in% names(x)]
          tmp <- c(rep(NA, length(fillnames)), x)
          names(tmp)[seq_along(fillnames)] <- fillnames
          tmp
        }
      })
      datout <- data.frame(rbindlist(dat))
    }
    
    if(is.null(input$highlighting)){
      hlout <- "No data"
    } else {  
      maxlenhl <- max(sapply(input$highlighting, length))
      nameshl <- names(input$highlighting[which.max(sapply(input$highlighting, length))][[1]])  
      hl <- lapply(input$highlighting, function(x){
        if(!length(x) < maxlenhl){ x } else {
          fillnames <- nameshl[!nameshl %in% names(x)]
          tmp <- c(rep(NA, length(fillnames)), x)
          names(tmp)[seq_along(fillnames)] <- fillnames
          tmp
        }
      })
      hlout <- data.frame(rbindlist(parsehighlight2(hl)))
    }
    list(data = datout, highlighting = hlout)
  }
}

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
  cat(paste("\nNo. of records:", length(x$data)))
  cat(paste("\nNo. of variables:", length(x$data)))
  cat(paste("\nVariables:", paste(names(x$data[[1]]), collapse=", ") ))
  cat("\n")
  cat("\n Highlighting")
  cat(paste("\nNo. of records:", length(x$highlighting)))
  cat(paste("\nNo. of variables:", length(x$highlighting) ))
  cat(paste("\nVariables:", paste(names(x$highlighting[[1]]), collapse=", ") ))
}