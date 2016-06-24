---
layout: page
title: plan of work
tagline: tutorial
---

### method  

Here's what to expect in the tutorials: 

- We break the analysis into logical chunks, each with its own script limited to   60--100 lines 
- File names follow the scheme `nnn_descriptive-title.ext`, where `nnn` is a number to order files in the directory and `descriptive-title` is specific and helpful. 
- Output is named for the script that produces it, e.g., the Rmd analysis script  `010_tidy-data.Rmd` might produce a CSV data file called    `010_tidy-data.csv`. 


Because your first script mimics my 7th script and because it introduces the calibration analysis topic, its file name is `007_introducing-the-topic.Rmd`. You can of course develop your own naming scheme, but this is the one I'll assume you are using for the workshop. 


### two types of reports   

I use the Rmd scripts in what could be called a *literate programming* mode, that is, 

- Computing and explanatory prose are commingled in the same Rmd text file 
- We write (and learn) R code to do the analysis 
- We write (and learn) R Markdown syntax to explain the analysis 
- We try to abide by the *don't repeat yourself* (DRY) principle 

We create two types of reproducible reports: 

- In  `scripts/`, we write analysis reports with all the code and intermediate results shown and explained, as if they were reports for use within one's organization 
- In  `reports/`, we write a client report that presents selected elements of the analysis for a client.



### what you type

To help the R novice learn to use R, RStudio, and R Markdown, in the prose of the tutorials I explain the Rmd syntax and the R code, as well as the basic process of analyzing calibration data.   

A second workshop goal is learning to write reproducible documents. If you copy or retype all the tutorial prose not devoted to learning the syntax, what remains is a model reproducible report. 

Thus, in your scripts, you should: 

- Type (or copy and paste) the R code chunks in full 
- Type (or copy and paste) enough of the prose to explain the analysis. 

OK, we're ready to start. 


