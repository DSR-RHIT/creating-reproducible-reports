# template for an Rmd for gh-pages

# file/page names for class-material related
# 	cm001_descriptive-name     for lessn 00n class materials
# 	slides001_descriptive-name accompanying cm001_descriptive-name
# 	code001_descriptive-name   accompanying cm001_descriptive-name
# 	data001_descriptive-name   accompanting cm001_descriptive-name
#
# and I'll also have
# 	assign01_descriptive-name 
# 	read01_descriptive-name 

source('scripts/hskp02_housekeeping-functions.R')

page <- 'pages/test2.Rmd'
title <- 'my title'
tagline <- 'my tagline'
describe <- 'description for searches'
next_page <- 'Return to the [main page](../index.html)'

create_rmd(page, title, tagline, describe, next_page)
