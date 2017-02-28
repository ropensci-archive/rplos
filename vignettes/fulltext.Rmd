<!--
%\VignetteEngine{knitr::knitr}
%\VignetteIndexEntry{Full text}
%\VignetteEncoding{UTF-8}
-->

Full text
=====



Search functions in `rplos` can be used to get back full text in addition to 
any section of an article. However, if you prefer XML, this vignette is 
for you.

### Load package from CRAN


```r
install.packages("rplos")
```


```r
library('rplos')
```

### Get full text URLs

Create urls for full text articles in PLOS journals

Here's the URL for XML full text for the DOI `10.1371/journal.pone.0086169`


```r
full_text_urls(doi = '10.1371/journal.pone.0086169')
```

```
#> [1] "http://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0086169&type=manuscript"
```

And for the DOI `10.1371/journal.pbio.1001845`


```r
full_text_urls(doi = '10.1371/journal.pbio.1001845')
```

```
#> [1] "http://journals.plos.org/plosbiology/article/file?id=10.1371/journal.pbio.1001845&type=manuscript"
```

The function is vectorized, so you can pass in many DOIs


```r
full_text_urls(doi = c('10.1371/journal.pone.0086169', 
                       '10.1371/journal.pbio.1001845'))
```

```
#> [1] "http://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0086169&type=manuscript"    
#> [2] "http://journals.plos.org/plosbiology/article/file?id=10.1371/journal.pbio.1001845&type=manuscript"
```

Use `searchplos()` to get a lot of DOIs, then get the URLs for full text XML


```r
dois <- searchplos(q = "*:*", fq = 'doc_type:full', limit = 20)$data$id
full_text_urls(dois)
```

```
#>  [1] "http://journals.plos.org/ploscompbiol/article/file?id=10.1371/journal.pcbi.1000942&type=manuscript"
#>  [2] "http://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0130089&type=manuscript"     
#>  [3] "http://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0165670&type=manuscript"     
#>  [4] "http://journals.plos.org/plosgenetics/article/file?id=10.1371/journal.pgen.1002909&type=manuscript"
#>  [5] "http://journals.plos.org/ploscompbiol/article/file?id=10.1371/journal.pcbi.1004317&type=manuscript"
#>  [6] "http://journals.plos.org/plosbiology/article/file?id=10.1371/journal.pbio.1002259&type=manuscript" 
#>  [7] "http://journals.plos.org/plosgenetics/article/file?id=10.1371/journal.pgen.1003554&type=manuscript"
#>  [8] "http://journals.plos.org/ploscompbiol/article/file?id=10.1371/journal.pcbi.1004432&type=manuscript"
#>  [9] "http://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0162873&type=manuscript"     
#> [10] "http://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0163015&type=manuscript"     
#> [11] "http://journals.plos.org/plosgenetics/article/file?id=10.1371/journal.pgen.1003597&type=manuscript"
#> [12] "http://journals.plos.org/plosgenetics/article/file?id=10.1371/journal.pgen.1004934&type=manuscript"
#> [13] "http://journals.plos.org/plosgenetics/article/file?id=10.1371/journal.pgen.1004795&type=manuscript"
#> [14] "http://journals.plos.org/plosbiology/article/file?id=10.1371/journal.pbio.0000004&type=manuscript" 
#> [15] "http://journals.plos.org/plosgenetics/article/file?id=10.1371/journal.pgen.1003631&type=manuscript"
#> [16] "http://journals.plos.org/plosgenetics/article/file?id=10.1371/journal.pgen.1003549&type=manuscript"
#> [17] "http://journals.plos.org/plosgenetics/article/file?id=10.1371/journal.pgen.1003507&type=manuscript"
#> [18] "http://journals.plos.org/plosbiology/article/file?id=10.1371/journal.pbio.0000040&type=manuscript" 
#> [19] "http://journals.plos.org/plosbiology/article/file?id=10.1371/journal.pbio.0000026&type=manuscript" 
#> [20] "http://journals.plos.org/plosgenetics/article/file?id=10.1371/journal.pgen.1003332&type=manuscript"
```

### Get XML

Get full text XML of PLOS papers given a DOI


```r
plos_fulltext(doi = '10.1371/journal.pone.0086169')
```

```
#> 1 full-text articles retrieved 
#> Min. Length: 110717 - Max. Length: 110717 
#> DOIs: 10.1371/journal.pone.0086169 ... 
#> 
#> NOTE: extract xml strings like output['<doi>']
```

`plos_fulltext()` is vectorized, so you can pass in more than one DOI


```r
plos_fulltext(c('10.1371/journal.pone.0086169','10.1371/journal.pbio.1001845'))
```

```
#> 2 full-text articles retrieved 
#> Min. Length: 110717 - Max. Length: 143442 
#> DOIs: 10.1371/journal.pone.0086169 10.1371/journal.pbio.1001845 ... 
#> 
#> NOTE: extract xml strings like output['<doi>']
```

Get many DOIs, then index to get the full XML of the one you want 
(output not shown)


```r
dois <- searchplos(q = "*:*", fq = 'doc_type:full', limit = 3)$data$id
out <- plos_fulltext(dois)
xml <- out[dois[1]][[1]]
```

Extract the abstract from the XML


```r
if (requireNamespace("xml2")) {
  library("xml2")
  xml_text(xml_find_all(read_xml(xml), "//abstract/p"))
}
```

```
#> [1] "Quantitative linkages between individual organism movements and the resulting population distributions are fundamental to understanding a wide range of ecological processes, including rates of reproduction, consumption, and mortality, as well as the spread of diseases and invasions. Typically, quantitative data are collected on either movement behaviors or population distributions, rarely both. This study combines empirical observations and model simulations to gain a mechanistic understanding and predictive ability of the linkages between both individual movement behaviors and population distributions of a single-celled planktonic herbivore. In the laboratory, microscopic 3D movements and macroscopic population distributions were simultaneously quantified in a 1L tank, using automated video- and image-analysis routines. The vertical velocity component of cell movements was extracted from the empirical data and used to motivate a series of correlated random walk models that predicted population distributions. Validation of the model predictions with empirical data was essential to distinguish amongst a number of theoretically plausible model formulations. All model predictions captured the essence of the population redistribution (mean upward drift) but only models assuming long correlation times (minute), captured the variance in population distribution. Models assuming correlation times of 8 minutes predicted the least deviation from the empirical observations. Autocorrelation analysis of the empirical data failed to identify a de-correlation time in the up to 30-second-long swimming trajectories. These minute-scale estimates are considerably greater than previous estimates of second-scale correlation times. Considerable cell-to-cell variation and behavioral heterogeneity were critical to these results. Strongly correlated random walkers were predicted to have significantly greater dispersal distances and more rapid encounters with remote targets (e.g. resource patches, predators) than weakly correlated random walkers. The tendency to disperse rapidly in the absence of aggregative stimuli has important ramifications for the ecology and biogeography of planktonic organisms that perform this kind of random walk."
#> [2] "Organism movement is fundamental to how organisms interact with each other and the environment. Such movements are also important on the population level and determine the spread of disease and invasion, reproduction, consumption, and mortality. Theoretical ecologists have sought to predict population dispersal rates, which are often hard to measure, from individual movement behaviors, which are often easier to measure. This problem has been non-trivial. This manuscript contributes seldom available, simultaneously measured movement behaviors and population distributions of a single celled planktonic organism. The empirical data are used to distinguish amongst a set of plausible theoretical modeling approaches to suggest that organism movements are highly correlated, meaning movement direction and speed is consistent over several minutes. Previous estimates suggested persistence only lasted several seconds. Minute-scale correlations result in much more rapid organism dispersal and greater dispersal distance, indicating that organisms encounter and impact a greater portion of their surrounding habitat than previously suspected."
```

Extract reference lists, just give back first one from each for brevity sake


```r
if (requireNamespace("xml2")) {
  library("xml2")
  lapply(out[2:3], function(x){
    xml_find_all(read_xml(x), "//ref-list/ref")[[1]]
  })
}
```

```
#> $`10.1371/journal.pone.0130089`
#> {xml_node}
#> <ref id="pone.0130089.ref001">
#> [1] <label>1</label>
#> [2] <mixed-citation xlink:type="simple" publication-type="book"><name na ...
#> 
#> $`10.1371/journal.pone.0165670`
#> {xml_node}
#> <ref id="pone.0165670.ref001">
#> [1] <label>1</label>
#> [2] <mixed-citation publication-type="book" xlink:type="simple"><collab> ...
```
