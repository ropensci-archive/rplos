RSCRIPT = Rscript --no-init-file

all: move rmd2md

vignettes:
		cd inst/vign;\
		Rscript --vanilla -e 'library(knitr); knit("rplos_vignette.Rmd"); knit("fulltext.Rmd"); knit("facethighlight.Rmd")'

move:
		cp inst/vign/rplos_vignette.md vignettes;\
		cp inst/vign/fulltext.md vignettes;\
		cp inst/vign/facethighlight.md vignettes;\
		cp -r inst/vign/figure/ vignettes/figure/

rmd2md:
		cd vignettes;\
		mv rplos_vignette.md rplos_vignette.Rmd;\
		mv fulltext.md fulltext.Rmd;\
		mv facethighlight.md facethighlight.Rmd

install: doc build
	R CMD INSTALL . && rm *.tar.gz

build:
	R CMD build .

docs:
	${RSCRIPT} -e "pkgdown::build_site()"

doc:
	${RSCRIPT} -e "devtools::document()"

eg:
	${RSCRIPT} -e "devtools::run_examples()"

codemeta:
	${RSCRIPT} -e "codemetar::write_codemeta()"

check:
	${RSCRIPT} -e 'devtools::check(document = FALSE, cran = TRUE)'

test:
	${RSCRIPT} -e 'devtools::test()'
