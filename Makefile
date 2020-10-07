PACKAGE := $(shell grep '^Package:' DESCRIPTION | sed -E 's/^Package:[[:space:]]+//')
RSCRIPT = Rscript --no-init-file

vign:
		cd vignettes;\
		${RSCRIPT} -e "Sys.setenv(NOT_CRAN='true'); knitr::knit('rplos.Rmd.og', output = 'rplos.Rmd')";\
		cd ..

vign_facet:
		cd vignettes;\
		${RSCRIPT} -e "Sys.setenv(NOT_CRAN='true'); knitr::knit('facethighlight.Rmd.og', output = 'facethighlight.Rmd')";\
		cd ..

vign_fulltext:
		cd vignettes;\
		${RSCRIPT} -e "Sys.setenv(NOT_CRAN='true'); knitr::knit('fulltext.Rmd.og', output = 'fulltext.Rmd')";\
		cd ..

install: doc build
	R CMD INSTALL . && rm *.tar.gz

build:
	R CMD build .

doc:
	${RSCRIPT} -e "devtools::document()"

eg:
	${RSCRIPT} -e "devtools::run_examples(run=TRUE)"

codemeta:
	${RSCRIPT} -e "codemetar::write_codemeta()"

readme:
	${RSCRIPT} -e "knitr::knit('README.Rmd')"

check: build
	_R_CHECK_CRAN_INCOMING_=FALSE R CMD CHECK --as-cran --no-manual `ls -1tr ${PACKAGE}*gz | tail -n1`
	@rm -f `ls -1tr ${PACKAGE}*gz | tail -n1`
	@rm -rf ${PACKAGE}.Rcheck

check_windows:
	${RSCRIPT} -e "devtools::check_win_devel(); devtools::check_win_release()"

test:
	${RSCRIPT} -e 'devtools::test()'
