# housekeeping functions

library(knitr)
library(stringr)
library(rmarkdown)

# function to execute/render an Rmd file (executes Rmd scripts)
execute_Rmds <- function(file_name) {
	input <- file_name
	render(input)
}

# knit one file at a time, producing an md file for gh-pages
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

Rmd_to_gh_pages <- function(Rmd_file) {
	# md file must already exist in scripts, created by Rmd header
	# create md file name
	library(stringr)
	md_file <- str_replace(Rmd_file, '.Rmd', '.md')
	
	# read both files
	library(readr)
	Rmd_source_file <- read_lines(Rmd_file)
	md_source_file  <- read_lines(md_file) # originally created by the Rmd file
	
	# change md_file to be the pages destination
	md_file <- str_replace(md_file, 'scripts', 'pages')
	
	# from the Rmd file, extract just the lines I want for the gh-page.md header
	# start by finding the line numbers of the first two sets of dashes
	header_limits  <- grep("---", Rmd_source_file)[1:2]
	
	# extract the header lines, including dashes
	starting_lines <- Rmd_source_file[header_limits[1]:header_limits[2]]
	
	# keep layout, title, and tagline
	idx1 <- grep("layout",  starting_lines)
	idx2 <- grep("title",   starting_lines)
	idx3 <- grep("tagline", starting_lines)
	idx  <- sort(c(header_limits, idx1, idx2, idx3))
	md_header <- starting_lines[idx]
	
	# remove the first # heading-1 line from the md file made from the Rmd
	idx <- grep("#",  md_source_file)[1]
	md_source_file <-  md_source_file[-idx]
	
	# print to file
	cat(md_header, file = md_file, sep = '\n')
	cat(md_source_file, file = md_file, sep = '\n', append = TRUE)
}
