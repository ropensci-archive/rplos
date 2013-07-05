# tests for plossubject fxn in rplos
context("plossubject")

test_that("plossubject returns the correct class", {
	expect_that(plossubject('museums', fields = 'id,journal', toquery='doc_type:full', limit = 9), 
							is_a("data.frame"))
	expect_that(plossubject(terms='marine ecology', fields = 'id,journal', toquery=list('doc_type:full','!article_type_facet:"Issue%20Image"'), limit = 9), 
							is_a("data.frame"))
})