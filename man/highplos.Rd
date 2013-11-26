\name{highplos}
\alias{highplos}
\title{Base function to search PLoS Journals}
\usage{
  highplos(q, hl.fl = NULL, hl.snippets = NULL,
    hl.fragsize = NULL, hl.q = NULL,
    hl.mergeContiguous = NULL, hl.requireFieldMatch = NULL,
    hl.maxAnalyzedChars = NULL, hl.alternateField = NULL,
    hl.maxAlternateFieldLength = NULL,
    hl.preserveMulti = NULL,
    hl.maxMultiValuedToExamine = NULL,
    hl.maxMultiValuedToMatch = NULL, hl.formatter = NULL,
    hl.simple.pre = NULL, hl.simple.post = NULL,
    hl.fragmenter = NULL, hl.fragListBuilder = NULL,
    hl.fragmentsBuilder = NULL, hl.boundaryScanner = NULL,
    hl.bs.maxScan = NULL, hl.bs.chars = NULL,
    hl.bs.type = NULL, hl.bs.language = NULL,
    hl.bs.country = NULL,
    hl.useFastVectorHighlighter = NULL,
    hl.usePhraseHighlighter = NULL,
    hl.highlightMultiTerm = NULL, hl.regex.slop = NULL,
    hl.regex.pattern = NULL,
    hl.regex.maxAnalyzedChars = NULL, start = 0,
    limit = NA,
    key = getOption("PlosApiKey", stop("need an API key for PLoS Journals")),
    sleep = 6, callopts = list())
}
\arguments{
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

  \item{hl.simple.pre/hl.simple.post}{XXXX}

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
}
\value{
  A list.
}
\description{
  Base function to search PLoS Journals
}
\examples{
\dontrun{
highplos(q='alcohol', hl.fl = 'abstract', limit=10)
highplos(q='alcohol', hl.fl = 'abstract', limit=1200)
}
}

