\name{almplotallviews}
\alias{almplotallviews}
\title{almplotallviews.R   Alt-metrics_plot_allviews}
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
  ggplot line plot
}
\description{
  almplotallviews.R Alt-metrics_plot_allviews
}
\examples{
\dontrun{
   out <- plosallviews('10.1371/journal.pbio.0000012', 'counter', 'json')
   plotallviews(out, 'all')
   plotallviews(out, 'pdf')
   plotallviews(out, 'html,pdf')
}
}

