---
layout: page
title:  tutorial
tagline: initializing an R Markdown file
---

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

The reports directory should look like this. 

```
reports\
  |-- load-cell-setup.png
  |-- load-cell-calibr-report.Rmd 
  \-- load-cell-calibr-report.docx
```








Now go to the page about ...
