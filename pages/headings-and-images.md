---
layout: page
title:  tutorial
tagline: adding headings and images
---

I'll introduce R Markdown syntax as we need it in the report. For a quick reference to the most commnly used syntax, see RStudio's  [Markdown basics](http://rmarkdown.rstudio.com/authoring_basics.html). 

### Creating a heading 

Markdown uses hashtags to indicate heading levels in the final document. 

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

- Add the following text to the report introduction (copy-paste from the web box to your Rmd document to save time). 
- Save and Knit 

<pre><code>Calibrating a *load cell* (a sensor for measuring uniaxial force) yields two main results: a calibration equation relating output voltage (mV) to input force (lb); and an estimate of sensor accuracy as a percentage of full span. This report presents the test results for an Omega LCL-005 load cell calibrated following the ANSI/ISA procedure.
</code></pre>

The asterisks around *load cell* are markdown for italics. 

### Inserting an external image

- Add the next paragraph to precede Figure 1. 
- Save and Knit 

<pre><code>The load-cell setup is shown in Figure 1. A known weight is suspended from the eye-hook, causing the thin-beam load cell to deform. A Wheatstone bridge on the beam detects the deformation and produces a voltage output signal that is  recorded.
</code></pre>

- Add the following snippet to place the image file in the document. 
- Save and Knit. 

```
![Figure 1. Applying a force to the load cell using a precision weight](load-cell-setup.png)
```
The square brackets enclose the figure caption and the parentheses enclose the file path to the image file. In this case, the Rmd and image file are in the same directory, so no additional relative path information is needed. 

--- 
Now go to the page about [specifying a style reference](style-reference.html)










