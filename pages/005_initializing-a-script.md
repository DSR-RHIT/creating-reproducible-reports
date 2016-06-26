---
layout: page
title: initializing a script
---

[//]: this is a comment in Rmd




### create an R markdown script 

In your workshop main directory, 

- Launch your *rr-workshop.Rproj* 
- File --> New File --> R Markdown 
- Output Format -> HTML 
- Save As --> to the `scripts/` directory, using the filename  `007_introducing-the-topic.Rmd` 

The Rmd file is pre-populated with prose and some markdown syntax. Edit the meta-data header:

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



### including R code 

To include R code in an Rmd document, you place the code in a *code chunk*. A code chunk begins with  ````{r}` and ends with `````.  In RStudio, you can insert these delimiters using the *Insert a new code chunk* button ![insert-code-chunk-icon](../resources/images/insert-code-chunk-icon.png). 

When I write this: 

![](../resources/images/insert-code-chunk-icon.png) 

```r
summary(cars)
```

you type this: 

<pre class="r"><code>```{r}
summary(cars)
<code>```</code>
</code></pre>


### output to alternative formats 

If you have MS Word installed on your machine (or Libre/Open Office on Unix-alikes), you can render the Rmd to Word using the Knit pull-down menu.

- ![knit html icon](../resources/images/knit-word-icon.png) 

If you have TeX installed on your machine (MiKTeX on Windows, MacTeX 2013+ on OS X, TeX Live 2013+ on Unix-alikes), you can render the Rmd to PDF 

- ![knit html icon](../resources/images/knit-pdf-icon.png) 

We'll use HTML output for analysis and later switch to Word output for a client report. For now, 

- ![knit html icon](../resources/images/knit-html-icon.png) 




### cleanup  

In the Rmd file, 

- Keep the meta-data header 
- Delete all the rest of the pre-populated text

In the directory, 

- Delete the docx and pdf output files (if any), leaving the directory with: 

```
scripts\
  |-- 007_introducing-the-topic.html 
  `-- 007_introducing-the-topic.Rmd 
```


--- 



