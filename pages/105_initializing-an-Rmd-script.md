---
layout: page
title: "initializing an Rmd script"
---





Packages used in this tutorial 

- knitr

How to use this tutorial 

- ![](../resources/images/text-icon.png)<!-- --> *add text*: type the prose verbatim into the Rmd file 
- ![](../resources/images/code-icon.png)<!-- --> *add code*: insert a code chunk then transcribe the R code 
- ![](../resources/images/knit-icon.png)<!-- --> *Knit* after each addition. 

### open a new R markdown script 

In your workshop main directory, 

- Launch your project `rr-workshop.Rproj` 
- `File > New File > R Markdown` 
- `Output Format > HTML` 
- `Save As...` to the `scripts/` directory with filename `01_calibr_data-wide.Rmd`  

The Rmd file is pre-populated with prose and some markdown syntax. Edit the meta-data header:

![](../resources/images/text-icon.png)<!-- --> (Editing the pre-populated YAML header.)

    ---
    title: "Load-cell calibration --- data in wide form"
    author: "your name"
    date: "2016-08-24"
    output: html_document
    ---

### render the script 

*Knit* the Rmd file to create the output document using one of 3 options: 

1. Click the button ![](../resources/images/knit-html.png)<!-- -->
1. Use the menu `File` > `Knit Document`
1. Use a keyboard shortcut `Ctrl + Shift + K`

The output should appear in the RStudio Viewer pane. If you compare the pre-populated Rmd file with the rendered output document, you'll see example of commonly-needed syntax to:  

- write headings and paragraphs 
- include executable chunks of R code 
- link to a URL 
- mark bold text  
- create a graph 

We'll see most of these Rmd structures again as we work through the tutorials. 


### output to alternative formats 

If you have MS Word installed on your machine (or Libre/Open Office on Unix-alikes), you can render the Rmd to Word using the Knit pull-down menu. We'll use Word later for a client report. 

- ![](../resources/images/knit-word.png)<!-- -->

If you have TeX installed on your machine (MiKTeX on Windows, MacTeX 2013+ on OS X, TeX Live 2013+ on Unix-alikes), you can render the Rmd to PDF.

- ![](../resources/images/knit-pdf.png)<!-- -->

We'll use HTML output for most of our exploratory work---it renders quickly and we can ignore pagination. So for now, please use: 

- ![](../resources/images/knit-html.png)<!-- -->


### cleanup  

In the Rmd file, 

- Delete the pre-populated text, leaving only the YAML header
- Save

In the `scripts/` directory, 

- Delete the docx and pdf output files (if any) 

### initializing knitr

To include R code in our Rmd file, we place them in a *code chunk*. A code chunk opens and closes with 

<pre><code>```{r}

<code>```</code>
</code></pre>

and we write the R code in between.  Insert the delimiters using 

- ![](../resources/images/insert-code.png) icon
- `Ctrl + Alt + I` keyboard shortcut
- Type the delimiters directly ("back ticks", not single-quotes)

The first code chunk we'll write comes at the top of the file, just after the YAML header. This code sets some options for the `knitr` package 

![](../resources/images/code-icon.png)<!-- --> 

    library(knitr)
    opts_knit$set(root.dir = '../')
    opts_chunk$set(echo = TRUE)

Learning R and knitr:

- `library()` loads the `knitr` package
- `root.dir = '../'` sets the working directory for `knitr` to match the working directory for the RStudio project.  
- `echo = TRUE` applies to all subsequent code chunks in the script,  printing your R code verbatim to the output document---useful during exploratory computing. 

Edit the code chunk header as follows:

    {r, setup, include = FALSE}

- `setup` is a chunk label. Labels are optional, but if used, every label must be unique.
- `include = FALSE` suppresses printing for this chunk. The code runs, but no results are not displayed. 

Writing readable code

- One space on either side of `=`
- No space before a comma, one space after a comma (just like written English) 

Save and Knit. 

### check yourself

Your directories should contain these files:

    data\
      `-- 007_wide-data.csv

    reports\
    
    resources\
      `-- load-cell-setup-786x989px.png 
      
    results\
      
    scripts\
      |-- 01_calibr_data-wide.html
      `-- 01_calibr_data-wide.Rmd 




---
Back [getting organized](104_getting-organized.html)<br>
Next [examine the data in wide form](109_examine-wide-data.html)




