---
layout: page
title: tidying wide data 
tagline: load cell calibration 
---

### instructions 

- Start with the Rmd file you created in [initializing a script](pages/005_initialize-script.html). 
- Save and Knit to see the output of each chunk of text or code.   
- I'll introduce R Markdown syntax as we need it. For a quick reference to the most commonly used syntax, see [Markdown basics](http://rmarkdown.rstudio.com/authoring_basics.html) by RStudio. 
- Insert a code chunk ![insert code chunk button](../resources/images/insert-code-chunk-icon.png) for each chunk of R code I ask you to add to the document  
- We use the *knitr* package for executing R code and embedding the results in the output document. To reset the *knitr* working directory for all R chunks to match the project working directory, insert a code chunk and type (or copy and paste) 


```r
library(knitr) 
opts_knit$set(root.dir = '../')
```



### Introduction 

- Markdown uses hash tags to indicate heading levels in the final document. Add `## Introduction` below the meta-data header. 
- This next chunk of text is an example of the prose that would go into the analysis report. You may copy and paste it directly into your Rmd file. 


In this report, we analyze calibration data from our testing lab for an Omega LCL-005 *load cell* (a force sensor). The goal of the analysis is to produce a calibration equation relating output voltage (mV) to input force (lb) and an estimate of sensor accuracy as a percentage of full span. 

- Use asterisks around a phrase for emphasis, e.g.,  `*load cell*` 
- Your file should look like: 

```
---
title: Load-cell calibration --- examine wide data
author: your name
date: 2016-08-24
output: html_document
---

## Introduction

In this report, we analyze calibration data ...
```
