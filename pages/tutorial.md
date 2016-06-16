# tutorial

### Launching an  R project 

If you haven't installed R and RStudio, [please do](https://github.com/DSR-RHIT/install-R-and-RStudio/blob/master/pages/install_R.md). 

If you haven't created an RStudio project for the workshop, [please do](https://github.com/DSR-RHIT/install-R-and-RStudio/blob/master/pages/setup_R_project.md). 

Your main project directory should look like this (with the directory name you selected where I've written "workshop")

```
workshop\
  \-- workshop.Rproj
```

To launch the project, click _workshop.Rproj_,  or from RStudio, File --> Open Project. 



### Starting the report 

To start, 

- File --> New File --> R Markdown 
- Output Format --> Word 
- Save As --> _load-cell-calibr-report.Rmd_ (in the workshop main directory)

The project directory tree is now:

```
workshop\
  |-- load-cell-calibr-report.Rmd
  \-- workshop.Rproj
```



The file is pre-populated with default text and markup. Edit the header (called a *YAML* header): 

- Change the title to _Calibration report_
- Output should be *word_document* (if Word is not installed on your machine, change the output to _html_ and save)

```
---
title: "Calibration report"
author: "Your Name"
date: "Today's Date"
output: word_document
---
```

To *knit* the document and create the Word file, 

- Knit Word 

A Word document should appear. Do not edit the Word document. Make all revisions in the R Markdown file. (The only exception to this rule is when you create a Word styles template---more on this later.)

In the Rmd file, 

- Delete everything below the YAML header
- Add a second-level heading *## Introduction*
- Save
- Knit Word to see the changes in the Word document

<pre><code>---
title: "Calibration report"
author: "Your Name"
date: "Today's Date"
output: word_document
<code>---</code>

<code>```</code>{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
<code>```</code>

<code>## Introduction</code>

</code></pre>

<a href = "#header">back to top</a>
 
### Add some prose 

Let's add some text to the report (you may copy this text and paste it into your Rmd file). The asterisks around *load cell* are the markup for *italics*. 

    Calibrating a *load cell* (a sensor for measuring uniaxial force) yields two main results: a calibration equation relating output voltage (mV) to input force (lb); and an estimate of sensor accuracy as a percentage of full span. In this report, I present the test results for an Omega LCL-005 load cell calibrated following the ANSI/ISA procedure.






 <a href = "#header">back to top</a>
 
 









