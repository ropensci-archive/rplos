\name{getkey}
\alias{getkey}
\title{Function to get an API key.}
\usage{
  getkey(x = NULL)
}
\arguments{
  \item{x}{An API key, defaults to NULL.}
}
\description{
  Checks first to get key from your .Rprofile file for an
  API key with the name 'PlosApiKey'. If it is not found,
  the default guest key is used.
}
\examples{
\dontrun{
getkey()
}
}

