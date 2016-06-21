# housekeeping functions

library(knitr)
library(stringr)

# knit one file at a time
knit_Rmd_to_md <- function(file_name) {
	input  <- file_name
	output <- str_replace(file_name, '.Rmd', '.md')
	knit(input = input, output = output)
}

# makes a template for an Rmd for gh-pages
create_rmd <- function(page
											 , title=NULL
											 , tagline=NULL
											 , description=NULL
											 , next_page=NULL) {
	
  structure <- paste('---'
  									 , '\nlayout: page'
  									 , '\ntitle:', title
  									 , '\ntagline:', tagline
  									 , '\ndescription:', description
  									 , '\noutput: html_document'
  									 , '\n---'
  									 , '\n\n###heading'
  									 , '\n\n\n'
  									 , '\n---\n', next_page)
 
  cat(structure, file = page)
}

