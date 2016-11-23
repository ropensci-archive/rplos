# Setup

## Platform

|setting  |value                        |
|:--------|:----------------------------|
|version  |R version 3.3.2 (2016-10-31) |
|system   |x86_64, darwin13.4.0         |
|ui       |RStudio (1.0.117)            |
|language |(EN)                         |
|collate  |en_US.UTF-8                  |
|tz       |America/Los_Angeles          |
|date     |2016-11-23                   |

## Packages

|package |*  |version |date       |source                    |
|:-------|:--|:-------|:----------|:-------------------------|
|rplos   |   |0.6.4   |2016-11-23 |local (ropensci/rplos@NA) |

# Check results
2 packages

## alm (0.4.0)
Maintainer: Scott Chamberlain <myrmecocystus@gmail.com>  
Bug reports: http://www.github.com/ropensci/alm/issues

0 errors | 0 warnings | 2 notes

```
checking R code for possible problems ... NOTE
alm_events : parse_events: no visible global function definition for
  ‘setNames’
alm_ids : getalm: no visible global function definition for ‘is’
alm_plot: no visible global function definition for ‘na.omit’
Undefined global functions or variables:
  is na.omit setNames
Consider adding
  importFrom("methods", "is")
  importFrom("stats", "na.omit", "setNames")
to your NAMESPACE file (and ensure that your DESCRIPTION Imports field
contains 'methods').

checking files in ‘vignettes’ ... NOTE
The following directory looks like a leftover from 'knitr':
  ‘figure’
Please remove from your package.
```

## fulltext (0.1.8)
Maintainer: Scott Chamberlain <myrmecocystus@gmail.com>  
Bug reports: https://github.com/ropensci/fulltext/issues

0 errors | 0 warnings | 0 notes

