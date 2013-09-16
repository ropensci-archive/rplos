\name{plostitle}
\alias{plostitle}
\title{Search PLoS Journals titles.}
\usage{
  plostitle(terms = NA, fields = "id", toquery = NA,
    start = 0, limit = NA, returndf = TRUE, sleep = 6, ...,
    curl = getCurlHandle(),
    key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")))
}
\arguments{
  \item{terms}{search terms (character)}

  \item{fields}{fields to return from search (character)
  [e.g., 'id,title'], any combination of search fields
  [type 'data(plosfields)', then 'plosfields']}

  \item{toquery}{List specific fields to query (if NA, all
  queried). The possibilities for this parameter are the
  same as those for the fields parameter.}

  \item{start}{Record to start at (used in combination with
  limit when you need to cycle through more results than
  the max allowed=1000)}

  \item{limit}{Number of results to return (integer)}

  \item{returndf}{Return data.frame of results or not
  (defaults to TRUE).}

  \item{key}{Your PLoS API key, either enter as the key, or
  loads from .Rprofile. See details.}

  \item{sleep}{Number of seconds to wait between requests.
  No need to use this for a single call to searchplos.
  However, if you are using searchplos in a loop or lapply
  type call, do sleep parameter is used to prevent your IP
  address from being blocked. You can only do 10 requests
  per minute, so one request every 6 seconds is about
  right.}

  \item{...}{optional additional curl options (debugging
  tools mostly)}

  \item{curl}{If using in a loop, call getCurlHandle()
  first and pass the returned value in here (avoids
  unnecessary footprint)}
}
\value{
  Titles, in addition to any other fields requested in a
  data.frame.
}
\description{
  Search PLoS Journals titles.
}
\details{
  You can store your PLOS Search API key in your .Rprofile
  file so that you don't have to enter the key each
  function call. Open up your .Rprofile file on your
  computer, and put it an entry like:

  options(PlosApiKey = "your plos api key")
}
\examples{
\dontrun{
plostitle(terms='drosophila', fields='title', limit=99)
plostitle(terms='drosophila', fields='title,journal', limit=10)
plostitle(terms='drosophila',  limit = 5)
}
}

