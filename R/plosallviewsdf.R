# plosallviewsdf.R

plosallviewsdf <- 
# Examples
#   plosallviewsdf(out)
# Input: the JSON output from the plosallviews function
# Output: data frame
  
function(data) {
  
  datdat <- data$article$source[[1]]$citations[[1]]$citation$views
  
  dat <- as.data.frame(t(do.call(cbind, laply(datdat, cbind))))
  class(dat$pdf_views) <- "numeric"
  class(dat$xml_views) <- "numeric"
  class(dat$html_views) <- "numeric"
  class(dat$month) <- "numeric"
  class(dat$year) <- "numeric"
return(dat)
}