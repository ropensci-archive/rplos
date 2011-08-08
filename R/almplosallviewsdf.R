# plosallviewsdf.R

##### NEEDS OVERALL!!!!!!!!!!!!!!!!!!!

plosallviewsdf <- 
# Args:
#   data: json object or xml object (data object) 
#   type: input type, json or xml (character)
# Input: JSON or XML output from the plosallviews function
# Output: data frame
# Examples
#   out <- plosallviews('10.1371/journal.pbio.0000012', 'citeulike', T, T, 'json')
#   plosallviewsdf(out, 'json')
#   
#   plosallviewsdf(out, 'xml')
  
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