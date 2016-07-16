# Extract header from an Rmd file
# collect with the existing md file too.
# md file must already exist in scripts, created by Rmd header

Rmd_to_gh_pages <- function(Rmd_file) {
	
	# replace Rmd only when it is at the end of the file name
	library(stringr)
	md_file <- str_replace(Rmd_file, 'Rmd$', 'md')
	
	# read both files
	library(readr)
	Rmd_source_file <- read_lines(Rmd_file)
	md_source_file  <- read_lines(md_file) # originally created by the Rmd file
	
	# change md_file path from scripts to pages
	# md_file <- str_replace(md_file, 'scripts', 'pages')
	
	# from the Rmd file, extract just the lines I want for the gh-page.md header
	# start by finding the line numbers of the first two sets of dashes
	header_limits <- grep("---", Rmd_source_file)[1:2]
	
	# extract the header lines, including dashes
	starting_lines <- Rmd_source_file[header_limits[1]:header_limits[2]]
	
	# keep title and tagline
  i_title   <- grep("title",   starting_lines)
	i_tagline <- grep("tagline", starting_lines)
	title_and_tagline <- starting_lines[c(i_title, i_tagline)]
	
	# remove the first # heading-1 line from the md file
	i_hashtag <- grep("#",  md_source_file)[1]
	md_source_file <- md_source_file[-i_hashtag]
	
	# print to file
	cat(c("---", "layout: page")
			, file = md_file, sep = '\n')
	cat(title_and_tagline
			, file = md_file, sep = '\n', append = TRUE)
	cat(c("---")
			, file = md_file, sep = '\n', append = TRUE)
	cat(md_source_file
			, file = md_file, sep = '\n', append = TRUE)
}
