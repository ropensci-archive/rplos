R CMD CHECK passed on my local OS X install on R 3.1.2 and R development
version, Ubuntu running on Travis-CI, and Win-Builder.

This version includes a fix requested by CRAN:
- CRAN reported this package contained a README.md file with invalid HTML output created by pandoc 1.12.4.2 according to W3C-validator. I have fixed that problem. 

Thanks! Scott Chamberlain
