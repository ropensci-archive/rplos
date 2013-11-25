\name{high_browse}
\alias{high_browse}
\title{Browse highlighted fragments in your default browser.}
\usage{
  high_browse(input = NULL, output = NULL, browse = TRUE)
}
\arguments{
  \item{x}{Input, usually output from a call to
  \code{\link[rplos]{highplos}}}

  \item{output}{Path and file name for output file. If
  NULL, a temp file is used.}

  \item{browse}{Browse file in your default browse
  immediately after file creation.  If FALSE, the file is
  written, but not opened.}
}
\description{
  Browse highlighted fragments in your default browser.
}
\examples{
\dontrun{
out <- highplos(q='alcohol', hl.fl = 'abstract', limit=10)
high_browse(out)

out <- highplos(q='alcohol', hl.fl = 'abstract', limit=1200)
high_browse(out)
}
}

