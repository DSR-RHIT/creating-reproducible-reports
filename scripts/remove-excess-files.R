# removing extraneous tex files
# from all directories in the reports directory

unlink("reports/*/*.bbl")
unlink("reports/*/*.log")
unlink("reports/*/*.gz")
unlink("reports/*/*concordance*")
unlink("reports/*/*.tex")
unlink("reports/*/.Rhistory")

# from beamer compile
unlink("reports/*/*.nav")
unlink("reports/*/*.vrb")
unlink("reports/*/*.toc")
unlink("reports/*/*.snm")

unlink("reports/2016*/*.nav")

unlink(".Rhistory") # in the main directory

