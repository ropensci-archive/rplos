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
#>  [1] "http://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0044136&type=manuscript"
#>  [2] "http://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0155491&type=manuscript"
#>  [3] "http://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0168631&type=manuscript"
#>  [4] "http://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0058100&type=manuscript"
#>  [5] "http://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0168627&type=manuscript"
#>  [6] "http://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0184491&type=manuscript"
#>  [7] "http://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0155489&type=manuscript"
#>  [8] "http://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0072057&type=manuscript"
#>  [9] "http://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0127059&type=manuscript"
#> [10] "http://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0168605&type=manuscript"
#> [11] "http://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0058079&type=manuscript"
#> [12] "http://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0168602&type=manuscript"
#> [13] "http://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0044129&type=manuscript"
#> [14] "http://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0058091&type=manuscript"
#> [15] "http://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0184468&type=manuscript"
#> [16] "http://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0141298&type=manuscript"
#> [17] "http://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0168604&type=manuscript"
#> [18] "http://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0155469&type=manuscript"
#> [19] "http://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0184467&type=manuscript"
#> [20] "http://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0085513&type=manuscript"
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
#> [1] "Growth hormone (GH) is an important regulator of metabolism and body composition. GH deficiency is associated with increased visceral body fat and other features of the metabolic syndrome. Here we performed a cross-sectional study to explore the association of GH levels with nonalcoholic fatty liver disease (NAFLD), which is considered to be the hepatic manifestation of the metabolic syndrome. A total of 1,667 subjects were diagnosed as NAFLD according the diagnostic criteria, and 5,479 subjects were defined as the controls. The subjects with NAFLD had significantly lower levels of serum GH than the controls. Those with low GH levels had a higher prevalence of NAFLD and the metabolic syndrome. A stepwise logistic regression analysis showed that GH levels were significantly associated with the risk factor for NAFLD (OR = 0.651, 95%CI = 0.574–0.738, P<0.001). Our results showed a significant association between lower serum GH levels and NAFLD."
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
#> $`10.1371/journal.pone.0155491`
#> {xml_node}
#> <ref id="pone.0155491.ref001">
#> [1] <label>1</label>
#> [2] <mixed-citation publication-type="journal" xlink:type="simple"><name ...
#> 
#> $`10.1371/journal.pone.0168631`
#> {xml_node}
#> <ref id="pone.0168631.ref001">
#> [1] <label>1</label>
#> [2] <mixed-citation publication-type="journal" xlink:type="simple"><name ...
```
