---
layout: page
title: "getting organized"
---

[\\]: this is an Rmd comment





### set up a directory tree

- If you haven't installed R and RStudio, [please do](002_pre-hw.html). 
- If you haven't created an RStudio project and the `.Renviron` file for the workshop, [please do](002_pre-hw.html). 


In your main project directory (I'll call it `rr-workshop` for convenience), create additional folders (sub-directories) so that your project directory tree looks like this: 

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

We assume that our testing lab has made available two files: one is an image of the test setup, the second is a data set. Both are available online. 

- Launch your RStudio project.
- Copy the following lines of R code, paste into the Console (lower left pane of the RStudio interface), and `Enter`. 


```r
url <- "https://raw.githubusercontent.com/DSR-RHIT/creating-reproducible-reports/gh-pages/resources/load-cell-setup-786x989px.png"
destination <- "resources/load-cell-setup-786x989px.png"
download.file(url, destination, mode = "wb")
```

Learn R

- `<-` is the R assignment operator
- `download.file()` downloads a file from the Internet to your machine
- `destination` is a relative path with respect to your working directory 
- `wb` mode is for *binary* files (images and other non-text files)

Repeat to acquire the data. 

- Copy the following lines of R code, paste into the Console, and `Enter`. 


```r
url <- "https://raw.githubusercontent.com/DSR-RHIT/creating-reproducible-reports/gh-pages/data/007_wide-data.csv"
destination <- "data/007_wide-data.csv"
download.file(url, destination)
```

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

### tutorial design

You will be writing prose and code in the same document. The prose introduces the logic and rationale for a computation, the code performs the computation, and additional prose comments on the result. 

Because we are blending prose with computing, you are learning syntax for two languages: R Markdown (Rmd) for reporting; and R for computing. They sometimes use the same characters in different ways, for example, 

- In R, the single hash tag # denotes a comment.
- In Rmd, the single hash tag # denotes a level-1 heading. 

To distinguish prose (written in R Markdown) from code (written in R), I use the following icons. 

- ![](../resources/images/text-icon.png)<!-- --> When you see this icon, you will be adding new text to the Rmd script. Type the prose verbatim into the Rmd file.
- ![](../resources/images/code-icon.png)<!-- --> When you see this icon, you will first insert a *code chunk*  into the Rmd document, then transcribe the R code into the chunk. 
- ![](../resources/images/knit-icon.png)<!-- --> *Knit* the document after every change to check that your script is behaving as you expect.   

At the beginning of a tutorial, I list the packages used. If you have already installed a package (like you did for the `readr` package earlier, using `RStudio > Packages > Install`) then you do not have to install it again. 

I occasionally display some code output. Output is denoted by two hash tags, as shown below. You do not have to copy such blocks to your script.




```
## # A tibble: 3 x 5
##   test_point input_lb cycle_1 cycle_2 cycle_3
##        <chr>    <dbl>   <dbl>   <dbl>   <dbl>
## 1       2 up      1.5      NA    29.9    30.2
## 2       3 up      2.5    51.1    49.4    49.7
## 3       4 up      3.5    70.4    70.0      NA
```







---
Back [main page](../index.html)<br>
Next [initializing an Rmd script](105_initializing-an-Rmd-script.html)




