\name{almplotallviews}
\alias{almplotallviews}
\title{Feed output of almplosallviews to this function to plot results.}
\usage{
  almplotallviews(dat, type = NULL, removezero = TRUE)
}
\arguments{
  \item{dat}{Output from \code{almplosallviews}
  (character)}

  \item{type}{plot views for html, pdf, xml, any
  combination of two (e.g., 'html,pdf'), or all
  (character)}
}
\value{
  A ggplot2 bar plot for `totalmetrics` or line plot for
  `history`.
}
\description{
  Feed output of almplosallviews to this function to plot
  results.
}
\examples{
\dontrun{
out <- almplosallviews(doi='10.1371/journal.pone.0001543', info='detail')
almplotallviews(out, type='totalmetrics') # just totalmetrics data
almplotallviews(dat=out, type='history') # just historical data
almplotallviews(dat=out) # leaving type as NULL prints both plots
}
}

