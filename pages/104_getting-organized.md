---
layout: page
title: "getting organized"
---

[\\]: this is an Rmd comment





### set up a directory tree

- If you haven't installed R and RStudio, [please do](002_pre-hw.html). 
- If you haven't created an RStudio project and the *.Renviron* file for the workshop, [please do](002_pre-hw.html). 


In your main project directory (I'll call it *rr-workshop* for convenience), create additional folders (sub-directories) named *data*, *reports*, *resources*, and *scripts* so that your project directory tree looks like this: 

```
rr-workshop\
  |-- data\
  |-- reports\
  |-- resources\
  |-- scripts\
  |-- rr-workshop.Rproj
  `-- .Renviron
```

### tutorial design

You will be writing prose and code in the same document. The prose introduces the logic and rationale for a computation, the code performs the computation, and additional prose comments on the result. 

Because we are blending prose with computing, you are learning syntax for two languages: R Markdown (Rmd) for reporting; and R for computing. They sometimes use the same characters in different ways, for example, 

- In R, the single hash tag # denotes a comment.
- In Rmd, the single hash tag # denotes a level-1 heading. 

To distinguish prose (written in R Markdown) from code (written in R), I use the following icons. 

- ![](../resources/images/text-icon.png)<!-- --> When you see this icon, you will be adding new text to the Rmd script. Type the prose verbatim into the Rmd file.
- ![](../resources/images/code-icon.png)<!-- --> When you see this icon, you will first insert a *code chunk*  into the Rmd document, then transcribe the R code into the chunk. 
- ![](../resources/images/knit-icon.png)<!-- --> *Knit* the document after every change to check that your script is behaving as you expect.   

At the beginning of a tutorial, I list the packages used. If you have already installed a package (like you did for the *readr* package earlier, using RStudio --> Packages --> Install) then you do not have to install it again. 

I occasionally display a bit of code output to compare to your code output. Output is denoted by two hash tags, as shown below. You do not have to copy such blocks to your script.




```
## Source: local data frame [3 x 5]
## 
##   test_point input_lb cycle_1 cycle_2 cycle_3
##        <chr>    <dbl>   <dbl>   <dbl>   <dbl>
## 1       2 up      1.5      NA      30      30
## 2       3 up      2.5      51      49      50
## 3       4 up      3.5      70      70      NA
```

---
Back [main page](../index.html)<br>
Next [initializing an Rmd script](105_initializing-an-Rmd-script.html)




