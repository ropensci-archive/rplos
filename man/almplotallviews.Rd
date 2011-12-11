\name{almplotallviews}
\alias{almplotallviews}
\title{Feed output of almplosallviews to this function to plot results.}
\usage{
  almplotallviews(data, type = NA)
}
\arguments{
  \item{data}{JSON output downloaded from PLoS (character)}

  \item{type}{plot views for html, pdf, xml, any
  combination of two (e.g., 'html,pdf'), or all
  (character)}
}
\value{
  A ggplot2 line plot.
}
\description{
  Feed output of almplosallviews to this function to plot
  results.
}
\examples{
out <- almplosallviews('10.1371/journal.pbio.0000012', 'counter', 'json')
almplotallviews(out, 'all')
almplotallviews(out, 'pdf')
almplotallviews(out, 'html,pdf')
}

