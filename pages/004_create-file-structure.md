---
layout: page
title:  tutorial
tagline: creating the file structure
---

### Setting up a directory tree

- If you haven't installed R and RStudio, [please do](002_pre-hw.html). 
- If you haven't created an RStudio project and the *.Renviron* file for the workshop, [please do](002_pre-hw.html). 


In your main project directory (I'll call it *rr-workshop* for convenience), create three folders (sub-directories)

- Create a *data* directory
- Create a *reports* directory
- Create a *scripts* directory

Your main directory for the workshop should look like this, but your folder name appears where I've used *rr-workshop*. 

```
rr-workshop\
  |-- data\
  |-- reports\
  |-- scripts\
  |-- rr-workshop.Rproj
  `-- .Renviron
```

### Download prepared files 
 
Navigate to my [workshop downloads](https://github.com/DSR-RHIT/creating-reproducible-reports/tree/gh-pages/resources) folder. To download a file, 

- Click the file name 
- Right-click Raw --> Save link as... 
- Save the CSV files to the *data* directory 
- Save the PNG file to the *reports* directory 

The data and reports directories should look like this. 

```
data\
  `-- 007_wide-data.csv
  
reports\
  `-- load-cell-setup-smaller.png
```

--- 
back [main page](../index.html)<br> 
back [initializing the Rmd file](005-start-script.html)