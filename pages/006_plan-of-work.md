---
layout: page
title: plan of work
tagline: tutorial
---

### method  

Here's what to expect in the tutorials: 

- We break the analysis into logical chunks, each with its own script limited to   60--100 lines 
- A script writes outputs named after the script, for example, the Rmd script  `scripts/008_examine-wide-data.Rmd` might produce a CSV file  `data/008_examine-wide-data.csv`. 
- File names follow the scheme `nnn_descriptive-title.Rmd`, where `nnn` is a number that organizes the files in the directory in the logical order in which they are run and `descriptive-title` is specific and helpful.


### types of scripts  

I use the Rmd scripts in what could be called a *literate programming* mode, that is, 

- Computing and explanatory prose are commingled in the same Rmd text file 
analysis 
- We write (and learn) R code to do the analysis 
- We write (and learn) R Markdown syntax to explain the analysis 
- We try to abide by the *don't repeat yourself* (DRY) principle 

We create two types of reproducible reports: 

- In  `scripts/`: Analysis reports, treated as if they were reports for use within one's organization, with all the code and intermediate results shown and explained.   
- In  `reports/`: A client report that presents selected elements of the analysis for a client.



### what you type

In the tutorials that follow, I explain the Rmd syntax, the R code, and the analysis. The work flow I'm trying to have you emulate is developing an analysis fully explained in the text. You can omit from your Rmd scripts any of my prose devoted to teaching R and Rmd syntax.  

- Type the R code chunks in full 
- Type (or copy and paste) the prose that explains the analysis. 


