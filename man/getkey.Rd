\name{getkey}
\alias{getkey}
\title{Function to get an API key.}
\usage{
  getkey(x = NULL, service)

  getkey(x = NULL, service)
}
\arguments{
  \item{x}{An API key, defaults to NULL.}

  \item{x}{An API key, defaults to NULL.}

  \item{service}{The API data provider, used to match to
  default guest key.}
}
\description{
  Checks first to get key from your .Rprofile file for an
  API key with the name 'PlosApiKey'. If it is not found,
  the default guest key is used.

  Checks first to get key from your .Rprofile file for an
  API key with the name 'tropicoskey'. If it is not found,
  the default key is used.
}
\examples{
\dontrun{
getkey()
}
\dontrun{
getkey(service="tropicos")
getkey(service="EOL")
}
}

