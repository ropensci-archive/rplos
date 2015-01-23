This is a follow up submission to my submission yesterday (2015-01-22) in which I had a word spelled incorrectly in the DESCRIPTION file - that is 
fixed in this submission. The following comments were from yesterday's submission:


R CMD CHECK passed on my local OS X install on R 3.1.2 and R development
version, Ubuntu running on Travis-CI, and Win-Builder.

This version includes a number of updates, including a fix requested by CRAN:
- CRAN reported this package contained a README.md file with invalid HTML output created by pandoc 1.12.4.2 according to W3C-validator. I have fixed that problem. 

In R-devel checks on Win-Builder I get three messages in the check log that "curlGetHeaders is not supported on this platform" - I assume this is not a problem with my package, but that that particular check in R CMD is not supported on that specific Windows platform.  

Thanks! Scott Chamberlain
