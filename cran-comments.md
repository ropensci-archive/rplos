R CMD CHECK passed on my local OS X install on R 3.2.1 and R development
version, Ubuntu running on Travis-CI, and Win-Builder.

This submission is mostly to fix a number of broken functions due to the
recent update in httr on CRAN to v1.0.

In addition, this package now imports non-base functions explicitly as 
needed in accordance with R-devel changes. 

Thanks! Scott Chamberlain
