\name{highplos}
\alias{highplos}
\title{Base function to search PLoS Journals}
\usage{
highplos(q, fl = NULL, fq = NULL, hl.fl = NULL, hl.snippets = NULL,
  hl.fragsize = NULL, hl.q = NULL, hl.mergeContiguous = NULL,
  hl.requireFieldMatch = NULL, hl.maxAnalyzedChars = NULL,
  hl.alternateField = NULL, hl.maxAlternateFieldLength = NULL,
  hl.preserveMulti = NULL, hl.maxMultiValuedToExamine = NULL,
  hl.maxMultiValuedToMatch = NULL, hl.formatter = NULL,
  hl.simple.pre = NULL, hl.simple.post = NULL, hl.fragmenter = NULL,
  hl.fragListBuilder = NULL, hl.fragmentsBuilder = NULL,
  hl.boundaryScanner = NULL, hl.bs.maxScan = NULL, hl.bs.chars = NULL,
  hl.bs.type = NULL, hl.bs.language = NULL, hl.bs.country = NULL,
  hl.useFastVectorHighlighter = NULL, hl.usePhraseHighlighter = NULL,
  hl.highlightMultiTerm = NULL, hl.regex.slop = NULL,
  hl.regex.pattern = NULL, hl.regex.maxAnalyzedChars = NULL, start = 0,
  rows = NULL, key = NULL, callopts = list(), ...)
}
\arguments{
  \item{q}{Search terms (character). You can search on
  specific fields by doing 'field:your query'. For example,
  a real query on a specific field would be
  'author:Smith'.}

  \item{hl}{XXXX}

  \item{hl.q}{XXXX}

  \item{hl.fl}{XXXX}

  \item{hl.snippets}{XXXX}

  \item{hl.fragsize}{XXXX}

  \item{hl.mergeContiguous}{XXXX}

  \item{hl.requireFieldMatch}{XXXX}

  \item{hl.maxAnalyzedChars}{XXXX}

  \item{hl.alternateField}{XXXX}

  \item{hl.maxAlternateFieldLength}{XXXX}

  \item{hl.preserveMulti}{XXXX}

  \item{hl.maxMultiValuedToExamine}{XXXX}

  \item{hl.maxMultiValuedToMatch}{XXXX}

  \item{hl.formatter}{XXXX}

  \item{hl.simple.pre}{XXXX}

  \item{hl.simple.post}{XXXX}

  \item{hl.fragmenter}{XXXX}

  \item{hl.fragListBuilder}{XXXX}

  \item{hl.fragmentsBuilder}{XXXX}

  \item{hl.boundaryScanner}{XXXX}

  \item{hl.bs.maxScan}{XXXX}

  \item{hl.bs.chars}{XXXX}

  \item{hl.bs.type}{XXXX}

  \item{hl.bs.language}{XXXX}

  \item{hl.bs.country}{XXXX}

  \item{hl.useFastVectorHighlighter}{XXXX}

  \item{hl.usePhraseHighlighter}{XXXX}

  \item{hl.highlightMultiTerm}{XXXX}

  \item{hl.regex.slop}{XXXX}

  \item{hl.regex.pattern}{XXXX}

  \item{hl.regex.maxAnalyzedChars}{XXXX}

  \item{start}{Record to start at (used in combination with
  limit when you need to cycle through more results than
  the max allowed=1000)}

  \item{limit}{Number of results to return (integer)}

  \item{key}{Your PLoS API key, either enter as the key, or
  loads from .Rprofile.  See details.}

  \item{sleep}{Number of seconds to wait between requests.
  No need to use this for a single call to searchplos.
  However, if you are using searchplos in a loop or lapply
  type call, do sleep parameter is used to prevent your IP
  address from being blocked. You can only do 10 requests
  per minute, so one request every 6 seconds is about
  right.}

  \item{callopts}{Optional additional curl options
  (debugging tools mostly)}
}
\value{
A list.
}
\description{
Base function to search PLoS Journals
}
\examples{
\dontrun{
highplos(q='alcohol', hl.fl = 'abstract', rows=10)
highplos(q='everything:"sports alcohol"~7', hl.fl='everything')
highplos(q='alcohol', hl.fl='abstract', hl.fragsize=20, rows=5)
highplos(q='alcohol', hl.fl='abstract', hl.snippets=5, rows=5)
highplos(q='alcohol', hl.fl='abstract', hl.snippets=5, hl.mergeContiguous='true', rows=5)
highplos(q='alcohol', hl.fl='abstract', hl.useFastVectorHighlighter='true', rows=5)

highplos(q='alcohol', hl.fl = 'abstract', rows=1200)
}
}

