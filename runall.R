# renders Rmd scripts to execute R code 
# creates gh-pages/md files from selected Rmds

# load my functions
source('scripts/helper_01_housekeeping-functions.R')


# ----------------------------------------------------
# render scripts.Rmd to execute their R code
scripts <- list.files(path = "scripts"
													, pattern = "*.Rmd$"
													, full.names = TRUE
													)
sapply(scripts, FUN = execute_Rmds)

# create gh-pages from selected Rmds 
sapply(scripts, FUN = Rmd_to_gh_pages)

# move index.md from pages to top level
file.rename(from = 'pages/index.md', to = './index.md')



# ----------------------------------------------------
# copy files to be used by particpants to the downloads folder
download_to <- "resources/downloads/"

# file.copy(from = "data/load-cell-calibr-L3.csv"
# 					, to = download_to
# )
# file.copy(from = "data/load-cell-calibr-L6.csv"
# 					, to = download_to
# )
file.copy(from = "resources/images/load-cell-setup.png"
					, to = download_to
					)

# copy files used by me to test the report.Rmd
file.copy(from = "resources/images/load-cell-setup.png"
					, to = "reports/"
					)


# ----------------------------------------------------
# cleanup after
unlink("./*.html")
unlink("pages/*.html")
unlink("scripts/*.html")
unlink("scripts/*.md")














# # ----------------------------------------------------
# # here I want to try rendering the Rmd files in scripts
# 
# # function to execute an Rmd file
# library(rmarkdown)
# execute_Rmds <- function(file_name) {
# 	input <- file_name
# 	render(input)
# }
# 
# # update this list as needed
# paths_to_search <- c("./scripts")
# 
# # obtain file names with full paths
# list_of_Rmds <- list.files(path = paths_to_search
# 													, pattern = "\\.Rmd$"
# 													, full.names = TRUE)
# 
# 
# 
# sapply(list_of_Rmds, execute_Rmds)
# 
# 
# ----------------------------------------------------
# knit Rmd -> md with the correct header for gh-pages
# this requires that the Rmd files DO NOT set knitr root.dir to project-WD
# instead use relative paths from their directories

# # list only those directories where knit to md needed
# paths_to_search <- c(".")
# 
# # obtain file names with full paths
# Rmd_to_knit <- list.files(path = paths_to_search
# 													, pattern = "\\.Rmd$"
# 													, full.names = TRUE)
# 
# # for comparison, find all Rmd files in the project
# all_Rmd <- list.files(path = "."
# 											, pattern = "\\.Rmd$"
# 											, full.names = TRUE
# 											, recursive = TRUE)
# 
# # knit Rmd to create md files for gh-pages
# sapply(Rmd_to_knit, knit_Rmd_to_md)



# # 
# # # print to console
# # knitted <- all_Rmd %in% Rmd_to_knit
# # not_knitted <- all_Rmd[!knitted]
# # cat("\n\nRmd files rendered by runall.R\n", Rmd_to_knit, sep = "\n")
# # cat("\nRmd files not rendered\n", not_knitted, sep = "\n")
# 

# 
# 
# 
# # ----------------------------------------------------
# # # cleanup, main directory
# # unlink(".Rhistory")
# # unlink("*.html")
# # 
# # # cleanup all readme.html
# # unlink("*/readme.html")
# # 
# # # cleanup html from directories with Rmd source files
# # unlink("pages/*.html")
# # unlink("reports/*.html")
# 
# 
# source("scripts/cleanup-scripts-dir.R")
