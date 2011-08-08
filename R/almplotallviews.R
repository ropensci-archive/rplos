# plotallviews.R

plotallviews <- 
# Args:
#   data: JSON output downloaded from PLoS (character)
#   type: plot views for html, pdf, xml, any combination of two (e.g., 'html,pdf'), 
#     or all (character)
# Examples
#  out <- plosallviews('10.1371/journal.pbio.0000012', 'counter', 'json') 
#  plotallviews(out, 'all')
#  plotallviews(out, 'pdf')
#  plotallviews(out, 'html,pdf')
# Input: for now, the JSON output from the plosallviews function
# Output: ggplot line plot
  
function(data, type = NA) {
  
  datdat <- data$article$source[[1]]$citations[[1]]$citation$views
  
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