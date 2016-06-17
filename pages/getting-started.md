---
layout: page
title:  tutorial
tagline: getting started
---

### Setting up a directory tree

- If you haven't installed R and RStudio, [please do](https://github.com/DSR-RHIT/install-R-and-RStudio/blob/master/pages/install_R.md). 
- If you haven't created an RStudio project and the *.Renviron* file for the workshop, [please do](https://github.com/DSR-RHIT/install-R-and-RStudio/blob/master/pages/setup_R_project.md). 


In your main project directory (I'll call it *workshop* for convenience), create three folders (sub-directories)

- Create a *data* directory
- Create a *reports* directory
- Create a *scripts* directory

Your main directory for the workshop should look like this: 

```
workshop\
  |-- data\
  |-- reports\
  |-- scripts\
  |-- workshop.Rproj
  \-- .Renviron
```

### Download prepared files 
 
Navigate to my [workshop downloads](https://github.com/DSR-RHIT/creating-reproducible-reports/tree/gh-pages/assets/downloads) folder. To download a file, 

- Click the file name 
- Right-click Raw --> Save link as... 
- Save the CSV files to the *data* directory 
- Save the PNG file to the *reports* directory 

The data and reports directories should look like this. 

```
data\
  |-- load-cell-calibration-L3.csv
  \-- load-cell-calibration-L6.csv
  
reports\
  \-- load-cell-setup.png
```

Now go to the page about [initializing an Rmd file](initialize-Rmd.html)
