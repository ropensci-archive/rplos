## Test environments

* local OS X install, R 3.3.2
* ubuntu 12.04 (on travis-ci), R 3.3.2
* win-builder (devel and release)
* R-hub (Windows Server R-oldrel, Ubuntu Linux R-release, Fedora Linux R-devel)

## R CMD check results

0 errors | 0 warnings | 2 notes

❯ checking CRAN incoming feasibility ... NOTE
  Maintainer: ‘Scott Chamberlain <myrmecocystus@gmail.com>’
  
  License components with restrictions and base license permitting such:
    MIT + file LICENSE
  File 'LICENSE':
    YEAR: 2016
    COPYRIGHT HOLDER: Scott Chamberlain

❯ checking package dependencies ... NOTE
  Package which this enhances but not available for checking: ‘tm’

## Reverse dependencies

* I have run R CMD check on the 2 downstream dependencies, with no errors
  related to this package. Summary at 
  <https://github.com/ropensci/rplos/blob/master/revdep/README.md>

----------

This version includes a bug fix and updates to URLs for full text 
XML content of articles.

Thanks!
Scott Chamberlain
