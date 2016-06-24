---
layout: page
title: initializing a script
tagline: tutorial
---


### create an R markdown script 

In your workshop main directory, 

- Launch your *rr-workshop.Rproj* 
- File --> New File --> R Markdown 
- Output Format -> HTML 
- Save As --> to the `scripts/` directory, using the filename  `009_tidying-wide-data.Rmd` 

The Rmd file is pre-populated with prose and some markdown syntax. Edit the meta-data header as shown:

```
---
title: Load-cell calibration --- examine wide data
author: your name
date: 2016-08-24
output: html_document
---
```



### render the script 

To *knit* the Rmd file and create the output document, 

- Save the file 
- ![knit html icon](../resources/images/knit-html-icon.png) 

The report should appear in the RStudio *Viewer* pane. Compare the output document in the Viewer pane to  the text in the Rmd file. While you don't have learn all the syntax details at once (I'll introduce them as needed), the pre-populated file does illustrate commonly-needed syntax to:  

- write headings and paragraphs 
- include executable chunks of R code 
- link to a URL 
- mark bold text  
- create a graph 





### output to alternative formats 

If you have MS Word installed on your machine (or Libre/Open Office on Unix-alikes), you can render the Rmd to Word using the Knit pull-down menu.

- ![knit html icon](../resources/images/knit-word-icon.png) 

If you have TeX installed on your machine (MiKTeX on Windows, MacTeX 2013+ on OS X, TeX Live 2013+ on Unix-alikes), you can render the Rmd to PDF 

- ![knit html icon](../resources/images/knit-pdf-icon.png) 

We'll use HTML output for analysis and later switch to Word output for a client report. For now, 

- ![knit html icon](../resources/images/knit-html-icon.png) 




### cleanup your directory 

If you were able to render the Rmd script to all three output formats, your scripts directory will contain html, docx, and pdf output files. You may delete the docx and pdf files if you like. The scripts directory should contain at least:  

```
scripts\
  |-- 009_tidying-wide-data.html
  `-- 009_tidying-wide-data.Rmd 
```






















<!--
*Save and Knit* anytime you want to see how your changes appear in the output. Remember, this is not a WYSIWYG environment---until you knit it, you won't see it. We could call it WYKIWYS (What You *Knit* Is What You *See*). 









We can dispense with the default prose. In the Rmd file, 

- Delete everything below the YAML header 
- Save and Knit 

-->




--- 
back [organize files](004_organize-files.html)<br> 
next [tbd](tbd.html)




