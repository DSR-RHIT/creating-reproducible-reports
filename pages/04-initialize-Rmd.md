---
layout: page
title:  tutorial
tagline: initializing the Rmd report file
---

### Launch the RStudio Project environment 

In your workshop main directory, find the file with the *.Rproj* suffix. It will have the same name as the directory. I'll refer to this file as  *workshop.Rproj*. 

- Launch your *workshop.Rproj*.  

### Create an Rmd file 

From RStudio,  

- File --> New File --> R Markdown 
- Output Format --> Word 
- Save As --> _load-cell-calibr-report.Rmd_ (in the workshop main directory)

The Rmd file is pre-populated with prose and some markdown syntax. Edit the header (called a *YAML* header): 

- Change the title to _Calibration report_
- Output should be *word_document* (if Word is not installed on your machine, change the output to _html_) 
- Save

```
---
title: Calibration report
author: your name
date: date
output: word_document
---
```

### Render Rmd to docx 

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

We can dispense with the default prose. In the Rmd file, 

- Delete everything below the YAML header 
- Save and Knit 





--- 
Now go to the page about [adding headings and images](headings-and-images.html) 
