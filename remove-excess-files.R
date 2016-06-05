# removing extraneous tex files from folder

unlink("print-pages/*.log")
unlink("print-pages/*.gz")
unlink("print-pages/*.tex")
unlink("print-pages/.Rhistory")

unlink("slides/*.log")
unlink("slides/*.gz")
unlink("slides/*.tex")
unlink("slides/*.nav")
unlink("slides/*.vrb")
unlink("slides/*.toc")
unlink("slides/*.snm")
unlink("slides/.Rhistory")


unlink(".Rhistory") # in the main directory

