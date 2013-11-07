# tests for journalnamekey fxn in rplos
context("journalnamekey")

test_that("journalnamekey returns the correct value", {
	expect_that(journalnamekey(), 
							equals(c(
								"PLoSONE","PLoSGenetics","PLoSPathogens","PLoSCompBiol",
								"PLoSBiology","PLoSNTD","PLoSMedicine","PLoSCollections",
								"PLoSClinicalTrials"
								)))
})

test_that("journalnamekey returns the correct class", {
	expect_that(journalnamekey(), is_a("character"))
})

test_that("journalnamekey returns the correct length vector", {
	expect_that(length(journalnamekey()), equals(9))
})