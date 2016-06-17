---
layout: page
title:  tutorial
tagline: composing the report
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

- Add the following text to the report introduction (copy-paste works fine). 

<pre><code>Calibrating a *load cell* (a sensor for measuring uniaxial force) yields two main results: a calibration equation relating output voltage (mV) to input force (lb); and an estimate of sensor accuracy as a percentage of full span. In this report, I present the test results for an Omega LCL-005 load cell calibrated following the ANSI/ISA procedure.
</code></pre>

The asterisks around *load cell* are markdown for italics. 

### Inserting an external image

- Add the next paragraph to precede Figure 1. 

<pre><code>The load-cell setup is shown in Figure 1. A known weight is suspended from the eyehook, causing the thin-beam load cell to deform. A Wheatstone bridge on the beam detects the deformation, producing a voltage signal we read with a meter. 
</code></pre>

- Add the following snippet to place the image file in the document. Save and Knit. 

```
![Figure 1. Applying a force to the load cell using a precision weight](load-cell-setup.png)
```
The square brackets enclose the figure caption and the parentheses enclose the file path to the image file. In this case, the Rmd and image file are in the same directory, so no additional relative path information is needed. 

### Applying a style reference 

You can control the formatting of the Word document by specifying a style reference. First, create the style reference document. 

- Save and Knit the current report Rmd file. 
- Save the Word document in the report directory using a new file name, e.g., *mystyles-01.docx* 

Now edit the Word styles you find there. For example, suppose we want to change the style of the report title. 

- Select the Home ribbon tab, Styles group, click the Styles window launcher (in the lower right corner of the group). 

![](../assets/images/styles-bar-02.png)



