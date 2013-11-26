\name{high_brow}
\alias{high_brow}
\title{Browse highlighted fragments in your default browser.}
\usage{
  high_brow(input = NULL, output = NULL, browse = TRUE)
}
\arguments{
  \item{input}{Input, usually output from a call to
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
high_brow(out)

out <- highplos(q='alcohol', hl.fl = 'abstract', limit=1200)
high_brow(out)
}
}

