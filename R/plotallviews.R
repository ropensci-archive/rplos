# plotallviews.R

plotallviews <- 
# Examples
#   plotallviews(out)
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

  p <- ggplot(dat_m, aes(x = date, y = value, group = variable, colour = variable)) +
    geom_line() +
    labs(y = 'Views', x = 'Date')
  return(p)
}