\name{formatarticleurl}
\alias{formatarticleurl}
\title{formatarticleurl.R   format a URL for a specific article in a specific journal}
\usage{
  formatarticleurl(doi, journal)
}
\arguments{
  \item{doi}{digital object identifier for an article in
  PLoS Journals}

  \item{journal}{quoted journal name (character)}
}
\value{
  get url for the article to use in your browser, etc
}
\description{
  formatarticleurl.R format a URL for a specific article in
  a specific journal
}
\examples{
\dontrun{
 formatarticleurl("10.1371/journal.pone.0004045", 'PLoSONE')
}
}

