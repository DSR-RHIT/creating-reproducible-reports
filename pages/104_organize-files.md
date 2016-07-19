---
layout: page
title: "organize your files"
---

[\\]: this is an Rmd comment





### set up a directory tree

- If you haven't installed R and RStudio, [please do](002_pre-hw.html). 
- If you haven't created an RStudio project and the `.Renviron` file for the workshop, [please do](002_pre-hw.html). 

In your main project directory (I'll call it `rr-workshop` for convenience, but you may have named it differently), create new folders (sub-directories) for `data\`, `reports\`, `resources\`, etc. as shown below. The `.Rproj` and `.Renviron` files should already be there.  

```
rr-workshop\
  |-- data\
  |-- reports\
  |-- resources\
  |-- results\
  |-- scripts\
  |-- rr-workshop.Rproj
  `-- .Renviron
```



### download image and data files

In this workshop, you are going to take a guided tour of creating a reproducible report. The technical purpose of the work is to calibrate a force sensor and report the  outcomes. 

We begin by assuming our test lab has performed the requisite testing and has provided us two files: an image of the test setup, and a data set. Both files are available online. 

To retrieve these files and place them in the appropriate directories: 

- Make sure you have a live Internet connection
- Launch your RStudio project.
- To download the *image*, copy these lines of R code, paste into the Console (lower left pane of the RStudio interface), and `Enter`. 


```r
url <- "https://raw.githubusercontent.com/DSR-RHIT/creating-reproducible-reports/gh-pages/resources/load-cell-setup-786x989px.png"
destination <- "resources/load-cell-setup-786x989px.png"
download.file(url, destination, mode = "wb")
```

- To download the *data*, copy these lines of R code, paste into the Console, and `Enter`. 


```r
url <- "https://raw.githubusercontent.com/DSR-RHIT/creating-reproducible-reports/gh-pages/data/007_wide-data.csv"
destination <- "data/007_wide-data.csv"
download.file(url, destination)
```

Learn R

- `<-` is the R assignment operator
- `download.file()` downloads a file from the Internet to your machine
- `destination` is a relative path with respect to your working directory and includes the filename under which we save the file to our local machine.
- `mode = wb` mode is for *binary* files (images and other non-text files)


### check yourself

Your directories should contain these files:

    data\
      `-- 007_wide-data.csv

    reports\
    
    resources\
      `-- load-cell-setup-786x989px.png 
      
    results\
      
    scripts\

If not, navigate to [https://github.com/DSR-RHIT/creating-reproducible-reports/tree/gh-pages/resources/downloads](https://github.com/DSR-RHIT/creating-reproducible-reports/tree/gh-pages/resources/downloads) and follow the instructions. 






---
Back [main page](../index.html)<br>
Next [starting your first script](105_first-script.html)




