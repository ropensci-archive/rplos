\name{almplot}
\alias{almplot}
\title{Feed output of almplosallviews to this function to plot results.}
\usage{
  almplot(dat, type = NULL, removezero = TRUE)
}
\arguments{
  \item{dat}{Output from \code{almplosallviews}
  (character)}

  \item{type}{One of totalmetrics or history}

  \item{removezero}{Remove data sources with all zeros
  prior to plotting.}
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
out <- almplot(doi='10.1371/journal.pone.0001543', info='detail')
almplot(out, type='totalmetrics') # just totalmetrics data
almplot(dat=out, type='history') # just historical data
almplot(dat=out) # leaving type as NULL prints both plots
}
}

