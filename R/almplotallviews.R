#' Feed output of almplosallviews to this function to plot results.
#' 
#' @import RJSONIO XML RCurl plyr reshape2 ggplot2
#' @param data JSON output downloaded from PLoS (character)
#' @param type plot views for html, pdf, xml, any combination of two 
#'     (e.g., 'html,pdf'), or all (character)
#' @return A ggplot2 line plot.
#' @examples \dontrun{
#' out <- almplosallviews('10.1371/journal.pbio.0000012', 'crossref', 1, 0, 'json')
#' almplotallviews(out, 'all')
#' almplotallviews(out, 'pdf')
#' almplotallviews(out, 'html,pdf')
#' }
#' @export
almplotallviews <- function(data, type = NA) 
{  
	datdat <- 
		data$article[data$article %in% c("pub_med","pub_med_central","events_count")]
  datdat <- data$article$source[[1]]$events[[1]]$events$views
  
  dat <- as.data.frame(t(do.call(cbind, laply(datdat, cbind))))
  class(dat$pdf_views) <- "numeric"
  class(dat$xml_views) <- "numeric"
  class(dat$html_views) <- "numeric"
  class(dat$month) <- "numeric"
  class(dat$year) <- "numeric"

  dat_m <- melt(dat, id.var = c("month","year"))
  dat_m$date <- as.Date(paste(dat_m$month, 1, dat_m$year, sep='/'), "%m/%d/%Y")
        
  if(type == 'html') {toplot <- 'html_views'} else
    if(type == 'pdf') {toplot <- 'pdf_views'} else
      if(type == 'xml') {toplot <- 'xml_views'} else
        if(type == 'html,pdf') {toplot <- c("html_views", "pdf_views")} else
          if(type == 'html,xml') {toplot <- c("html_views", "xml_views")} else
            if(type == 'pdf,xml') {toplot <- c("pdf_views", "xml_views")} else
              if(type == 'all') {toplot <- c("html_views", "pdf_views", "xml_views")}
  
  p <- ggplot(droplevels(dat_m[dat_m$variable %in% toplot, ]), 
    aes(x = date, y = value, group = variable, colour = variable)) +
    geom_line() +
    labs(y = 'Views', x = 'Date')

return(p)
}