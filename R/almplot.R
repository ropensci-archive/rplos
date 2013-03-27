#' Plot results of a call to the alm function.
#' 
#' @import RJSONIO XML RCurl plyr reshape ggplot2 grid gridExtra
#' @param dat Output from \code{alm} (character)
#' @param type One of totalmetrics or history
#' @param removezero Remove data sources with all zeros prior to plotting.
#' @return A ggplot2 bar plot for `totalmetrics` or line plot for `history`.
#' @details You have to specify info='detail' in your call to \code{alm} so that
#' 		you get history and summary data so that either or both can be plotted
#' 		in this function.
#' @seealso \code{\link{alm}} which is required to use this function.
#' @examples \dontrun{
#' out <- alm(doi='10.1371/journal.pone.0001543', info='detail')
#' almplot(out, type='totalmetrics') # just totalmetrics data
#' almplot(dat=out, type='history') # just historical data
#' almplot(dat=out) # leaving type as NULL prints both plots
#' }
#' @export
almplot <- function(dat, type = NULL, removezero = TRUE)
{  
  if(is.null(type)) {
  	dat_m <- melt(dat$totals, id.vars=".id")
  	dat_m <- na.omit(dat_m)
  	p <- ggplot(dat_m, aes(x = .id, y = value, fill = variable)) +
  		geom_bar(position="dodge", stat="identity") +
  		theme_bw(base_size=18) +
  		coord_flip() +
  		scale_fill_discrete("Metric") +
  		labs(y = 'Count')
  	if(removezero) {
  		datt <- dat$history
  		datt$dates <- as.Date(datt$dates)
  		temp <- split(datt, datt$.id)
  		dat2 <- ldply(compact(lapply(temp, function(x) if(sum(x$totals)==0){NULL} else {x})))
  	} else {dat2 <- dat$history}
  	q <- ggplot(dat2, aes(dates, totals, group=.id, colour=.id)) +
  		geom_line() + 
  		theme_bw(base_size=18)	
  	grid.newpage()
  	pushViewport(viewport(layout = grid.layout(2, 1)))
  	vplayout <- function(x, y) viewport(layout.pos.row = x, layout.pos.col = y)
  	print(p, vp = vplayout(1, 1))
  	print(q, vp = vplayout(2, 1))
  } else
    if(type == 'totalmetrics') {
    	dat_m <- melt(dat$totals, id.vars=".id")
    	dat_m <- na.omit(dat_m)
    	ggplot(dat_m, aes(x = .id, y = value, fill = variable)) +
    		geom_bar(position="dodge", stat="identity") +
    		theme_bw(base_size=18) +
    		coord_flip() +
    		scale_fill_discrete("Metric") +
    		labs(y = 'Count')
    	} else
      if(type == 'history') {
      	if(removezero) {
      		datt <- dat$history
      		datt$dates <- as.Date(datt$dates)
      		temp <- split(datt, datt$.id)
      		dat2 <- ldply(compact(lapply(temp, function(x) if(sum(x$totals)==0){NULL} else {x})))
      	} else {dat2 <- dat$history}
      	ggplot(dat2, aes(dates, totals, group=.id, colour=.id)) +
      		geom_line() + 
      		theme_bw(base_size=18)
      	} else
        stop("'type' must be one of 'totalmetrics' or 'history'")
}