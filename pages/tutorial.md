# tutorial





### Getting started

- If you haven't installed R and RStudio, [please do](https://github.com/DSR-RHIT/install-R-and-RStudio/blob/master/pages/install_R.md). 
- If you haven't created an RStudio project and the *.Renviron* file for the workshop, [please do](https://github.com/DSR-RHIT/install-R-and-RStudio/blob/master/pages/setup_R_project.md). 


On the website, I've provided an image file and four CSV data files. Download these files to your workshop directory. 

- load-cell-calibr-L3.csv 
- load-cell-calibr-L6.csv 
- load-cell-calibr-W3.csv 
- load-cell-calibr-W6.csv 
- load-cell-setup.png 




### Initializing an Rmd file 

In your workshop main directory, find the file with the *.Rproj* suffix. It will have the same name as the directory. I'll refer to this file as  *workshop.Rproj*. 

- Launch your *workshop.Rproj*.  

From RStudio,  

- File --> New File --> R Markdown 
- Output Format --> Word 
- Save As --> _load-cell-calibr-report.Rmd_ (in the workshop main directory)

The Rmd file is pre-populated with prose and some markdown syntax. Edit the header (called a *YAML* header): 

- Change the title to _Calibration report_
- Output should be *word_document* (if Word is not installed on your machine, change the output to _html_ and Save)

```
---
title:  "Calibration report"
author: "your name"
date:   "date"
output: "word_document"
---
```

To *knit* the Rmd file and create the Word document, 

- Save the file 
- Knit Word

*Save and Knit* anytime you want to see how your changes appear in the output. Remember, this is not a WYSIWYG environment---until you knit it, you won't see it. We could call it WYKIWYS (What You *Knit* Is What You *See*). 

You should have 9 files in the workshop directory :

```
workshop\
  |-- load-cell-calibr-L3.csv 
  |-- load-cell-calibr-L6.csv 
  |-- load-cell-calibr-W3.csv 
  |-- load-cell-calibr-W6.csv 
  |-- load-cell-calibr-report.docx
  |-- load-cell-calibr-report.Rmd
  |-- load-cell-setup.png 
  |-- workshop.Rproj
  \-- .Renviron
```

<a href = "#header">[back to top]</a>



### Beginning the report 

In the Rmd file, 

- Delete everything below the YAML header
- Add `## Introduction` below the header. Save and Knit. 

```
---
title:  "Calibration report"
author: "your name"
date:   "date"
output: "word_document"
---

## Introduction

```

The double hashtag `##` is markdown for a second-level heading in the output document. I will introduce markdown syntax as needed, but RStudio provides a handy reference for [Markdown basics](http://rmarkdown.rstudio.com/authoring_basics.html).  

- Add the following text to the report introduction (copy-paste works fine). 

<pre><code>Calibrating a *load cell* (a sensor for measuring uniaxial force) yields two main results: a calibration equation relating output voltage (mV) to input force (lb); and an estimate of sensor accuracy as a percentage of full span. In this report, I present the test results for an Omega LCL-005 load cell calibrated following the ANSI/ISA procedure.
</code></pre>

The asterisks around *load cell* are markdown for italics. 

- Add the following snippet to the Rmd file to place the image file in the document. 

```
![Figure 1. Applying a force to the load cell using a precision weight](load-cell-setup.png)
```
The square brackets enclose the figure caption and the parentheses enclose the file path to the image file. In this case, the Rmd and image file are in the same directory, so no additional relative path information is needed. 

<a href = "#header">[back to top]</a>


### Making a data table



 
 
 





<a href = "#header">[back to top]</a>

