\name{almplot}
\alias{almplot}
\title{Plot results of a call to the alm function.}
\usage{
  almplot(dat, type = NULL, removezero = TRUE)
}
\arguments{
  \item{dat}{Output from \code{alm} (character)}

  \item{type}{One of totalmetrics or history}

  \item{removezero}{Remove data sources with all zeros
  prior to plotting.}
}
\value{
  A ggplot2 bar plot for `totalmetrics` or line plot for
  `history`.
}
\description{
  Plot results of a call to the alm function.
}
\details{
  You have to specify info='detail' in your call to
  \code{alm} so that you get history and summary data so
  that either or both can be plotted in this function.
}
\examples{
\dontrun{
out <- alm(doi='10.1371/journal.pone.0001543', info='detail')
almplot(out, type='totalmetrics') # just totalmetrics data
almplot(dat=out, type='history') # just historical data
almplot(dat=out) # leaving type as NULL prints both plots
}
}
\seealso{
  \code{\link{alm}} which is required to use this function.
}

