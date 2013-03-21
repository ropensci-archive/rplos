\name{almtitle}
\alias{almtitle}
\title{Get title of article by inputting the doi for the article.}
\usage{
  almtitle(doi, key = NULL, curl = getCurlHandle())
}
\arguments{
  \item{doi}{digital object identifier for an article in
  PLoS Journals}

  \item{key}{your PLoS API key, either enter, or loads from
  .Rprofile}

  \item{curl}{If using in a loop, call getCurlHandle()
  first and pass the returned value in here (avoids
  unnecessary footprint)}
}
\value{
  Title of article, in xml format.
}
\description{
  Get title of article by inputting the doi for the
  article.
}
\examples{
\dontrun{
almtitle(doi='10.1371/journal.pbio.0000012')
}
}

