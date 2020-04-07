## Test environments

* local OS X install, R 3.6.0 Patched
* ubuntu 14.04 (on travis-ci), R 3.6.0
* win-builder (devel and release)

## R CMD check results

  License components with restrictions and base license permitting such:
    MIT + file LICENSE
  File 'LICENSE':
    YEAR: 2019
    COPYRIGHT HOLDER: Scott Chamberlain

## Reverse dependencies

* I have run R CMD check on the 1 downstream dependency, with no errors
  related to this package. Summary at
  <https://github.com/ropensci/rplos/blob/master/revdep/README.md>

----------

This version fixes problems in test fixture files that had non-ascii text that caused test suite failures on debian clang devel platform.

Thanks!
Scott Chamberlain
