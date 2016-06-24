---
layout: page
title:  tutorial
tagline: initializing an Rmd file
---


### create a file  for analysis 

In your workshop main directory, 

- Launch your *rr-workshop.Rproj* 
- File --> New File --> R Markdown 
- Output Format --> HTML 
- Save As --> *01\_calibration-analysis.Rmd* (in the scripts directory)

The Rmd file is pre-populated with prose and some markdown syntax. Edit the header (called a *YAML* header): 

- Change the title to *Calibration data analysis*
- Output should be *html_document* 
- Save

```
---
title: Calibration data analysis
author: your name
date: today's date
output: html_document
---
```



### render Rmd to html 

To *knit* the Rmd file and create the output document, 

- Save the file 
- Knit HTML 

The report should appear in the RStudio *Viewer* pane. 

*Save and Knit* anytime you want to see how your changes appear in the output. Remember, this is not a WYSIWYG environment---until you knit it, you won't see it. We could call it WYKIWYS (What You *Knit* Is What You *See*). 

The reports directory should look like this. 

```
reports\
  |-- load-cell-setup-smaller.png
  |-- 01_calibration-analysis.Rmd 
  `-- 01_calibration-analysis.html
```

We can dispense with the default prose. In the Rmd file, 

- Delete everything below the YAML header 
- Save and Knit 






### creating a heading 

I'll introduce R Markdown syntax as we need it in the report. For a quick reference to the most commnly used syntax, see RStudio's  [Markdown basics](http://rmarkdown.rstudio.com/authoring_basics.html). 

Markdown uses hashtags to indicate heading levels in the final document. 

- Add `## Introduction` below the header. 
- Add the text shown below to the report introduction (copy-paste from the web box to your Rmd document to save time). 
- Save and Knit. 

```
## Introduction

Calibrating a *load cell* (a sensor for measuring uniaxial force) yields two main results: a calibration equation relating output voltage (mV) to input force (lb); and an estimate of sensor accuracy as a percentage of full span. This report presents the test results for an Omega LCL-005 load cell calibrated following the ANSI/ISA procedure.

```



### inserting an external image

- Add the next paragraph to precede Figure 1. 
- Add the markdown syntax `![optional caption text](figures/img.png)` to import an image as shown
- Save and Knit 

```
The load-cell setup is shown in Figure 1. A known weight is suspended from the eye-hook, causing the thin-beam load cell to deform. A Wheatstone bridge on the beam detects the deformation and produces a voltage output signal that is  recorded.

![Figure 1. Applying a force to the load cell using a precision weight](load-cell-setup.png)
```

The square brackets enclose the figure caption and the parentheses enclose the file path to the image file. In this case, the Rmd and image file are in the same directory, so no additional relative path information is needed. 



--- 
Now go to the page about [adding headings and images](05-headings-and-images.html) 
