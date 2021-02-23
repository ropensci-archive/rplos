## Test environments

* local macOS install, R 4.0.4 Patched
* ubuntu 16.04 (on github actions), R 4.0.4
* win-builder (devel and release)

## R CMD check results

0 errors | 0 warnings | 0 notes

## Reverse dependencies

* I have run R CMD check on the 1 downstream dependency, with no errors. Summary at <https://github.com/ropensci/rplos/blob/master/revdep/README.md>

----------

This version fixes a broken test and future proofs all tests so they are skipped if the remote service is offline.

Thanks!
Scott Chamberlain
