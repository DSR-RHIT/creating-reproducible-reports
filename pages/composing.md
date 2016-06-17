---
layout: page
title:  tutorial
tagline: composing the report
---

### Creating a heading 


- Add `## Introduction` below the header. Save and Knit. 

```
---
title:  Calibration report
author: your name
date:   date
output: word_document
---

## Introduction

```

The double hashtag `##` is markdown for a second-level heading in the output document. (RStudio provides a handy reference for [Markdown basics](http://rmarkdown.rstudio.com/authoring_basics.html).) 


- Add the following text to the report introduction (copy-paste works fine). 

<pre><code>Calibrating a *load cell* (a sensor for measuring uniaxial force) yields two main results: a calibration equation relating output voltage (mV) to input force (lb); and an estimate of sensor accuracy as a percentage of full span. In this report, I present the test results for an Omega LCL-005 load cell calibrated following the ANSI/ISA procedure.
</code></pre>

The asterisks around *load cell* are markdown for italics. 

### Inserting an external image


- Add the following snippet to the Rmd file to place the image file in the document. 

```
![Figure 1. Applying a force to the load cell using a precision weight](load-cell-setup.png)
```
The square brackets enclose the figure caption and the parentheses enclose the file path to the image file. In this case, the Rmd and image file are in the same directory, so no additional relative path information is needed. 



