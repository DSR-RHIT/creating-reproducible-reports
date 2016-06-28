# render scripts.Rmd to execute the R code and create md files
# create gh-pages from selected Rmds. 
# move and copy files 
# delete byproduct files

library(plyr)
library(dplyr)



# ----------------------------------------------------
# render scripts.Rmd to execute their R code
library(rmarkdown)
Rmd_scripts <- list.files(path = "scripts"
													, pattern = "*.Rmd"
													, full.names = TRUE
													)

# files to omit
# omit_files <- list.files(path = "scripts"
# 											, pattern = "calibration-analysis.Rmd"
# 											, full.names = TRUE
# )
# Rmd_scripts <- Rmd_scripts[Rmd_scripts != omit_files]

sapply(Rmd_scripts, function(x) render(x))



# ----------------------------------------------------
# Rmds -> mds with edited YAML header for gh-pages
source('scripts/helper-01_create-gh-pages.R')

# plyr::failwith() allows completion even if an error occurs
library(plyr)
sapply(Rmd_scripts, failwith(NULL, Rmd_to_gh_pages))



# ----------------------------------------------------
# move and copy files 

# move index.md from pages to top level
file.rename(from = 'pages/index.md', to = './index.md')

# copy particpant files to the downloads folder
download_dir <- "resources/downloads/"

file.copy(from = "resources/images/load-cell-setup-315x396px.png"
					, to = download_dir
)

file.copy(from = "resources/images/load-cell-setup-315x396px.png"
					, to = "resources/"
)

file.copy(from = "data/009_wide-data.csv"
					, to = download_dir
)

# file.copy(from = "data/load-cell-calibr-L6.csv"
# 					, to = download_to
# )



# ----------------------------------------------------
# delete byproduct files
unlink("./*.html")
unlink("pages/*.html")
unlink("scripts/*.html")
unlink("scripts/*.md")



# last line













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
