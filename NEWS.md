rplos 1.0
---------

### MINOR IMPROVEMENTS

* fix a broken test on cran (#128)


rplos 0.9.0
-----------

### MINOR IMPROVEMENTS

* functions that use solrium under the hood now have a `progress` parameter that you can pass `htt::progress()` to get progress information; especially useful for long running queries  (#124)
* move readme images to man/figures (#127)
* replace `dplyr::data_frame` with `dplyr::tibble` (#126)


rplos 0.8.6
-----------

### MINOR IMPROVEMENTS

* use `preserve_exact_body_bytes` for tests for plosabstract and plosfigtabcaps to avoid non-ascii text problems on debian clang devel (#125)


rplos 0.8.4
-----------

### MINOR IMPROVEMENTS

* update docs for `searchplos()` and all wrapper fxns to explain that internal pagination is used, but that users can do their own pagination if they like (#122)

### BUG FIXES

* fix to pagination in `searchplos()` and all wrapper fxns. large numbers were being passed as scientific notation, fixed now (#123)


rplos 0.8.2
-----------

### NEW FEATURES

* Integration with `vcr` and `webmockr` packages for unit test stubbing

### BUG FIXES

* for `highbrow()` open pages with `https://doi.org` instead of `http://dx.doi.org` (#117)
* remove message `"Looping - printing progress ..."` from `searchplos()` (#120)
* fix internal pagination for `searchplos()`: were accidentally dropping `fq` statements if more than 1, woopsy  (#121)


rplos 0.8.0
-----------

### NEW FEATURES

* Now using `solrium` for under the hood Solr interaction instead
of `solr` package (#106)
* Along with above change, the following: `facetplos`, `searchplos`,
and `highplos` lose parameter `verbose`, and gain parameters
`error` and `proxy` for changing how verbose error reporting is, and
for setting proxy details, respectively.
* Now using `crul` instead of `httr` for HTTP requests (#110)

### MINOR IMPROVEMENTS

* Fix to placement of images for README requested by CRAN (#114)
* Replaced `XML` with `xml2` (#112)
* `citations` function for PLOS rich citations is defunct as the
service is gone (#113)
* package `tm` dropped from Enhances (#111)
* added code of conduct, issue and pull request templates


rplos 0.6.4
-----------

### MINOR IMPROVEMENTS

* URLs to full text XML have been changed - old URLs were working
but were going through 2 302 redirects to get there. Updated URLs.
(#107)

### BUG FIXES

* Fixed `content-type` check for `plos_fulltext()` function. XML
can be either `application/xml` or `text/xml` (#108)


rplos 0.6.0
------------

### MINOR IMPROVEMENTS

* Added notes to documentation for relavant functions for how to do
phrase searching. (#96) (#97) thanks @poldham
* Removed parameter `random` parameter from `citations()` function as it's
no longer available in the API (#103)
* Swapped out all uses of `dplyr::rbind_all()` for `dplyr::bind_rows()` (#105)
* `full_text_urls()` now gives back `NA` when DOIs for annotations are
given, which can be easily removed.

### BUG FIXES

* Fixed `full_text_urls()` function to create full text URLs for PLOS
Clinical Trials correctly (#104)

rplos 0.5.6
------------

### MINOR IMPROVEMENTS

* move `ggplot2` from _Depends_ to _Imports_, and using `@importFrom` for
`ggplot2` functions, now all imports are using `@importFrom` (#99)
* Fixes for `httr::content()` to parse manually, and use explicit
encoding of `UTF-8` (#102)

rplos 0.5.4
------------

### MINOR IMPROVEMENTS

* Change `solr` dependency to require version `v0.1.6` or less (#94)

rplos 0.5.2
------------

### MINOR IMPROVEMENTS

* More tests added (#94)

### BUG FIXES

* Fix encoding in parsing of XML data in `plos_fulltext()` to
avoid unicode problems (#93)

rplos 0.5.0
------------

### MINOR IMPROVEMENTS

* Now importing non-Base R functions from `utils`, `stats`, and `methods` packages (#90)

### BUG FIXES

* Fixes for `httr` `v1` that broke `rplos` when length 0 list passed to `query` parameter (#89)


rplos 0.4.7
------------

### NEW FEATURES

* New function `citations()` for querying the PLOS Rich Citations API (http://api.richcitations.org/) (#88)

### BUG FIXES

* Added `vignettes/figure` to `.Rbuildignore` as requested by CRAN admin (#87)

rplos 0.4.6
------------

### NEW FEATURES

* API key no longer required (#86)

### MINOR IMPROVEMENTS

* `searchplos()` now returns a list of length two, `meta` and `data`, and `meta` is a data.frame of metadata for the search.
* Switched from CC0 to MIT license.
* No longer importing libraries `RCurl`, `data.table`, `googleVis`, `assertthat`, `RJSONIO`, and `stringr` (#79) (#82) (#84)
* Now importing `dplyr`.
* Moved `jsonlite` from Suggests to Imports. Replaces use of `RJSONIO`. (#80)
* `crossref()` now defunct. See package `rcrossref` https://github.com/ropensci/rcrossref. (#83)
* `highplos()` now uses `solr::solr_highlight()` to do highlight searches.
* `searchplos()`, `plosabstract()`, and other functions that wrap `searchplos()` now use `...` to pass in curl options to `httr::GET()`. You'll now get an error on using `callopts` parameter.
* Added manual file entry for the dataset `isocodes`.
* Reworked both `plosword()` and `plot_throughtime()` to have far less code, uses `httr` now instead of `RCurl`, but to the user, everything should be the same.
* Made documentation more clear on discrepancy between PLOS website behavior and `rplos` behavior, and how to make them match, or match more closely (#76)
* Added package level man file to allow `?rplos` to go to help page.

### BUG FIXES

* Removed some examples from `searchplos()` that are now not working for some unknown reason. (#81)
* Previously when user set `limit=0`, we still gave back data, this is fixed, and now the `meta` slot given back, and the `data` slot gives an `NA` (#85)

rplos 0.4.1
------------

### BUG FIXES

* Fixed some broken tests.

rplos 0.4.0
------------

### NEW FEATURES

* Errors from the data provider are reported now. At least we attempt to do so when they are given, for example if you specify `asc` or `desc` incorrectly with the `sort` parameter. See the `check_response()` function https://github.com/ropensci/rplos/blob/master/tests/testthat/test-check_response.R for examples.
* New functions `facetplos()` and `highplos()` using the `solr` R wrapper to the Solr indexing engine. The PLOS API just exposes the Solr endpoints, so we can use the general Solr wrapper package `solr` to allow more flexible Solr searching.
* New function `highbrow()` to visualize highlighting results in a browser.
* New function `plos_fulltext()` to get full text xml of PLOS articles. Helper function `full_text_urls()` constructs the URL's for full text xml.

### BUG FIXES

* Fixed bug in tests where we forgot to give a key. No key is required per se, but PLOS encourages it so we prevent a call from happening without at least a dumby key.
* Added function `check_response()` to check responses from the PLOS API, deals with capturing server error messages, and checking for correct content type, etc.

### IMPROVEMENTS

* Removed function `crossref_r()` as we are working on a package for the CrossRef API.
* Parameter arguments in `searchplos()`, `plosauthor()`, `plosfigtabcaps()`, `plossubject()`, and `plostitle()` were changed to match closer the Solr parameter names. `terms` to `q`. `fields` to `fl`. `toquery` to `fq`.
* Multiple values passed to `fields `
* `returndf` parameter is gone from `searchplos()`, `plosauthor()`, `plosfigtabcaps()`, `plossubject()`, and `plostitle()`. You can easily get raw JSON, etc. data using the `solr` package.
* Now using `httr` instead of `RCurl` in `plosviews()` function.

rplos 0.3.6
------------

### NEW FEATURES

* All search functions (searchplos(), plosabstract(), plosauthor(), plosfigtabcaps(), plossubject(), and plostitle()) gain highlighting argument, setting to TRUE (default=FALSE) returns matching sentence fragments that were matched. NOTE that if highlighting=TRUE the output can be a list of data.frame's if returndf=TRUE, with two named elements 'data' and 'highlighting', or a list of lists if returndf=FALSE.
* All search functions (searchplos(), plosabstract(), plosauthor(), plosfigtabcaps(), plossubject(), and plostitle()) gain sort argument. You can pass a field to sort by even if you don't return that field in the output, e.g., sort='counter_total_month desc'.
* A tiny function parsehighlight() added to parse out html code from highlighting output.

### BUG FIXES

* Some examples in docs didn't work - fixed them.
* Fixed bug in searchplos() that was causing elements of a return field to cause failure because they were longer than 1 (e.g., authors). Now concatenating elements of length > 1.
* Fixed bug in searchplos() that was causing elements of length 0 to cause failure. Now removing elements of length 0.
* Fixed parsehighlight function to return NA if highlighting return of length 0.
* Fixed broken test for plosauthor(), plosabstract(), and plot_throughtime().

rplos 0.3.0
------------

### NEW FEATURES

* Added httr::stop_for_status() calls to a few functions to give informative http status errors when they happen

### BUG FIXES

* Fixed bug in plot_throughtime() that was throwing errors and preventing fxn from working, thanks to Ben Bolker for the fix.
* Simplified code in many functions to have cleaner and simpler code.
* ... parameter in many functions changed to callopts=list(), which passes in curl options to a call to either RCurl::getForm() or httr::GET()
* Fixed bug in function plosviews() that caused errors in some calls. Now forces full document searches, so that you get views data back for full papers only, not sections of papers. See package alm (https://github.com/ropensci/alm) for more in depth PLOS article-level metrics.


rplos 0.2.0
------------

### NEW FEATURES

* All functions for interacting with the PLOS ALM (altmetrics) API have been removed, and are now in a separate package called alm (http://github.com/ropensci/alm).
* Convenience functions `plosabstract`, `plosauthor`, `plosfigtabcaps`, `plossubject`, and `plostitle`, that search specifically within those sections of papers now wrap `searchplos`, so they should behave the same way.
* ldfast() fxn added as an attempt to do ldply faster
* performance improvements in searchplos

### BUG FIXES

* Dependency on assertthat removed since it's not on CRAN.
* Fixed namespace conflicts by importing only functions needed from some packages.
* searchplos() now removes leading, trailing, and internal whitespace from character strings


rplos 0.1.1
------------

* remove alm*() functions so that this package now only wraps the PLoS search API.


rplos 0.1.0
------------

* The `almdateupdated` function has been deprecated - use `almupdated` instead.

* The `articlelength` function has been deprecated - didn't see the usefulness any longer.

* In general simplified and prettified code.

* Changed from using RCurl to httr in many functions, but not all.

* Added more examples for many functions.

* Added three internal functions: `concat_todf`, `addmissing`, and `getkey`.

* Added Karthik Ram as a package author.

### BUG FIXES

* All `url` arguments in functions put inside functions as they are not likely to change that often.

* Fixed `crossref` function, and added more examples.

### NEW FEATURES

* The `alm` function (previously `almplosallviews`) gains many ### new features: now allows up to 50 DOIs per call; you can specify the source you want to get alm data from as an argument; you can specify the year you want to get alm data from as an argument.

* Added the plosfields data file to get all the possible fields to use in function calls.


### NEW FUNCTIONS

* `almplosallviews` changed to `alm`.

* `almplotallviews` changed to `almplot`.

* `almevents` added to specifically search and get detailed events data for a specific source or N sources.

* `crossref_r` gets 20 random DOIs from Crossref.org.

* Added package startup message.

* `journalnamekey` function to get the short name keys for each PLoS Journal.


rplos 0.0-7
------------

## IMPROVEMENTS AND ### BUG FIXES

* ALM functions (any functions starting with alm) received updated arguments/parameters according to the ALM API version 3.0 changes.

* ### Bug fixes in general across library.

* Added tests.

* `almplosallviews` now outputs different output - two data.frames, one total metrics (summed across time), and history (for metrics for each time period specified in the search)

* `crossref` function returns R's native bibtype format.  See examples in `crossref` function documentation

rplos 0.0-5
------------

### IMPROVEMENTS AND BUG FIXES

* `almpub` changed to `almdatepub`

* changed help file `rplos` to `help` - use help('rplos') in R

* changed URL from http://ropensci.org/ to https://github.com/ropensci/rplos

* added sleep argument to `plosallviews` function to allow pauses between API calls when running `plosallviews` in a loop - this is an attempt to limit hitting the PLoS API too hard

* various other fixed to functions

* more examples added to some functions

### NEW FUNCTIONS

* added function `journalnamekey` to get short keys for journals to use in searching for specific journals


rplos 0.0-1
===============

### NEW FEATURES

* released to CRAN
