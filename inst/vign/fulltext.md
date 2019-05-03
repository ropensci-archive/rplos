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
#>  [1] "http://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0155491&type=manuscript"    
#>  [2] "http://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0168631&type=manuscript"    
#>  [3] "http://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0168627&type=manuscript"    
#>  [4] "http://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0184491&type=manuscript"    
#>  [5] "http://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0155489&type=manuscript"    
#>  [6] "http://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0127059&type=manuscript"    
#>  [7] "http://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0168605&type=manuscript"    
#>  [8] "http://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0168602&type=manuscript"    
#>  [9] "http://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0184468&type=manuscript"    
#> [10] "http://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0141298&type=manuscript"    
#> [11] "http://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0168604&type=manuscript"    
#> [12] "http://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0155469&type=manuscript"    
#> [13] "http://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0184467&type=manuscript"    
#> [14] "http://journals.plos.org/plosbiology/article/file?id=10.1371/journal.pbio.0030350&type=manuscript"
#> [15] "http://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0127056&type=manuscript"    
#> [16] "http://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0168612&type=manuscript"    
#> [17] "http://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0127060&type=manuscript"    
#> [18] "http://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0127061&type=manuscript"    
#> [19] "http://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0155472&type=manuscript"    
#> [20] "http://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0184470&type=manuscript"
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
#> [1] "Embryo implantation is an essential step for the establishment of pregnancy and dynamically regulated by estrogen and progesterone. NDRG4 (N-myc down-regulated gene 4) is a tumor suppressor that participates in cell survival, tumor invasion and angiogenesis. The objective of this study was to preliminarily explore the role of NDRG4 in embryo implantation. By immunohistochemistry (IHC) and quantitive RT-PCR (qRT-PCR), we found that uterine expression of NDRG4 was increased along with puberal development, and its expression in adult females reached the peak at the estrus stage during the estrus cycle. Furthermore, uterine NDRG4 expression was significantly induced by the treatment of estradiol (E2) both in pre-puberty females and ovariectomized adult females. Uterine expression pattern of NDRG4 during the peri-implantation period in mice was determined by IHC, qRT-PCR and Western blot. It was observed that NDRG4 expression was up-regulated during the implantation process, and its expression level at the implantation sites was significantly higher than that at the inter-implantation sites. Meanwhile, an increased expression in NDRG4 was associated with artificial decidualization as well as the activation of delayed implantation. By qRT-PCR and Western blot, we found that the in vitro decidualization of endometrial stromal cells (ESCs) was accompanied by up-regulation of NDRG4 expression, whereas knockdown of its expression in these cells by siRNA inhibited the decidualization process. In addition, Western blot analysis showed that NDRG4 protein expression was decreased in human villus tissues of recurrent miscarriage (RM) patients compared to normal pregnant women. Collectively, these data suggested that uterine NDRG4 expression could be induced by estrogen, and NDRG4 might play an important role during early pregnancy."
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
#> $`10.1371/journal.pone.0168631`
#> {xml_node}
#> <ref id="pone.0168631.ref001">
#> [1] <label>1</label>
#> [2] <mixed-citation publication-type="journal" xlink:type="simple"><name ...
#> 
#> $`10.1371/journal.pone.0168627`
#> {xml_node}
#> <ref id="pone.0168627.ref001">
#> [1] <label>1</label>
#> [2] <mixed-citation publication-type="journal" xlink:type="simple"><name ...
```
