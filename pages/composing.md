---
layout: page
title:  tutorial
tagline: composing the report
---

### Creating a heading 


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



