# set up vcr
library("vcr")
vcr::vcr_configure(dir = vcr::vcr_test_path("fixtures"))
vcr::check_cassette_names()
