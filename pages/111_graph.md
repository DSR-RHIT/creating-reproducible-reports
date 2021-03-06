---
layout: page
title: "create the calibration graph"
---





How to use this tutorial 

- ![](../resources/images/text-icon.png)<!-- --> *add text*: type the prose verbatim into the Rmd file 
- ![](../resources/images/code-icon.png)<!-- --> *add code*: insert a code chunk, then transcribe the R code 
- ![](../resources/images/knit-icon.png)<!-- --> *knit* after each addition. 
- *Install* packages one time only
- *Load* a package using `library()` every session

Packages used in this tutorial  

- readr
- ggplot2

### open a new Rmd script

Open a new Rmd file, and name it `03_calibr_graph.Rmd`. Save it to the `scripts` directory.

Edit the YAML header:  

    ---
    title: "Load-cell calibration --- graph"
    author: "your name"
    date: "date"
    output: html_document
    ---

Delete the rest of the pre-populated text. Insert knitr setup code

![](../resources/images/code-icon.png)<!-- --> 

    library(knitr)
    opts_knit$set(root.dir = '../')
    opts_chunk$set(echo = TRUE,  collapse = TRUE)

Knowing the packages we'll be using, we can load them right away, near the top of the file.

![](../resources/images/code-icon.png)<!-- -->


```r
# load packages
library(readr)
library(ggplot2)
```

You will most likely encounter three main graphical systems in R: `base graphics`, `lattice`, and `ggplot2`. We'll use `ggplot2`, written by the [nerd famous Hadley Wickham](http://priceonomics.com/hadley-wickham-the-man-who-revolutionized-r/), and currently the most popular R graphics system. 

You should learn to recognize syntax from the other systems too. With so many code samples online, you will eventually want to copy someone's code as a basis for a new graph, and you can't use, say, `lattice` syntax in a `ggplot2` environment. To illustrate the difference in the three systems, scatter plots are drawn using: 

- `plot(x, y, ...)` in `base`
- `xyplot(y ~ x, ...)` in `lattice` 
- `geom_point(aes(x, y, ...))` in `ggplot2`

Robert Kabacoff, the author of the online reference [Quick-R](http://www.statmethods.net/) and the book [R in Action  2/e](https://www.manning.com/books/r-in-action-second-edition) (if you buy one book to help you learn R, I recommend this one), summarizes R graphics systems [here](http://www.slideshare.net/kabacoff/r-for-data-visualization-and-graphics-31577136?next_slideshow=1). Also, an anonymous blogger compares lattice to ggplot2 in a series of posts [here](https://learnr.wordpress.com/2009/08/26/ggplot2-version-of-figures-in-lattice-multivariate-data-visualization-with-r-final-part/). 

Having used `lattice` for years now, I am a novice `ggplot2` user too, but I'm convinced it's the package to learn --- all the cool kids are using it. 

### data 

![](../resources/images/text-icon.png)<!-- -->

    # Data

    Read the tidy data set.

![](../resources/images/code-icon.png)<!-- -->


```r
graph_data <- read_csv("data/02_calibr_data-tidy.csv")
str(graph_data)
```

### check yourself

Confer with a neighbor.

1. How many variables in this data frame?
2. Which variables do we use in the calibration graph?

### building a graph in layers

![](../resources/images/text-icon.png)<!-- -->

    # Building the graph in layers

    Just show the data. 

![](../resources/images/code-icon.png)<!-- -->


```r
calibr_graph <- ggplot(data = graph_data, aes(x = input_lb, y = output_mV)) +
	geom_point()

print(calibr_graph)
```

Learning ggplot2

- `data = ...` assigns the data frame on which `ggplot` operates
- `aes()` is the **aes**thetic mapping, indicating which of the variables in the data frame are used for `x` and `y` coordinates of the scatter plot
- `+` is the syntax for "add the next layer"
- `geom_point()` is a **geom**etric object. We use points because we're drawing a scatterplot

That's all it takes to obtain a basic scatterplot. If you don't care for the default graphic settings, don't worry, I'll show you how to edit basic settings.

![](../resources/images/text-icon.png)<!-- -->

    Draw the regression line. 

![](../resources/images/code-icon.png)<!-- -->


```r
calibr_graph <- ggplot(data = graph_data, aes(x = input_lb, y = output_mV)) +
	geom_smooth(method = 'lm') + 
	geom_point()

print(calibr_graph)
```

Learning ggplot2

- `geom_smooth()` computes and draws a fitted curve and confidence interval
- `method` assigns the type of curve fit, `lm` is a linear model

### check yourself

Confer with a neighbor

1. Explain why I inserted `geom_line()` before  `geom_point()`

### changing the attributes of the graphical elements

![](../resources/images/text-icon.png)<!-- -->

    # Changing the attributes of the graphical elements

    Start with the line and the data markers. 

![](../resources/images/code-icon.png)<!-- -->


```r
calibr_graph <- ggplot(data = graph_data, aes(x = input_lb, y = output_mV)) +
	geom_smooth(method = 'lm', se = FALSE, color = 'gray70',  size = 0.5) + 
	geom_point(size = 1.5, shape = 21, stroke = 0.7, color = 'black', fill = 'gray70')

print(calibr_graph)
```

Learning ggplot2

- `se = FALSE` turns off the confidence interval band
- `geom_smooth()` arguments edit the line color and size (line width in mm).
- `geom_point()` arguments edit  the data marker size (diameter in mm),  [shape](http://docs.ggplot2.org/current/vignettes/ggplot2-specs.html), stroke and color (outer circle), and fill color.

R has 657 built-in named colors such as `gray70` and `black` I've used here. You can see the full list of color names by typing `colors()` in the Console. View the colors by name  [here](http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf).

![](../resources/images/text-icon.png)<!-- -->

    Edit the axis labels. 

![](../resources/images/code-icon.png)<!-- -->


```r
calibr_graph <- calibr_graph + 
	xlab("Applied force (lb)") + 
	ylab("Sensor reading (mV)")
```

Learning ggplot2

- This chunk could be read "Assign `calibr_graph` to itself, add a layer for the x-axis label, `xlab()`, and add a layer for the y-axis label, `ylab()`."

![](../resources/images/text-icon.png)<!-- -->

    Edit the locations of the axis markings to match the test points. 

![](../resources/images/code-icon.png)<!-- -->


```r
calibr_graph <- calibr_graph + 
	scale_x_continuous(breaks = seq(from = 0.5, to = 4.5, by = 1)) +
	scale_y_continuous(breaks = seq(from = 10, to = 90, by = 20))
print(calibr_graph)
```

Learning R

- `breaks` is ggplot2 syntax for tick mark locations
- Sequences have the form `seq (from = ..., to = ..., by = ...)` as shown here. You can shorten the code by omitting the *key* words as long as the *values* are in the order shown. For example, for the y-scale markings I could have written `seq(10, 90, 20)`. 

![](../resources/images/text-icon.png)<!-- -->

    Assign a different theme. 

![](../resources/images/code-icon.png)<!-- -->


```r
calibr_graph <- calibr_graph + 
	theme_light()
print(calibr_graph)
```

Learning ggplot2

- A theme, in ggplot2, is a collection of settings that controls the appearance of the graph. Example images of the built-in themes are [here](http://docs.ggplot2.org/current/ggtheme.html).
- Additional themes are available in the [ggthemes package](https://github.com/jrnold/ggthemes), including themes inspired by Stephen Few, Edward Tufte, The Economist magazine, and even the classic 2003 ugly gray charts in Excel ("for ironic purposes only").

![](../resources/images/text-icon.png)<!-- -->

    Edit the theme.  

![](../resources/images/code-icon.png)<!-- -->


```r
calibr_graph <- calibr_graph +
        theme(panel.grid.minor = element_blank(), axis.ticks.length = unit(2, "mm"))

print(calibr_graph)
```

Learning ggplot2

- `element_blank()` turns off the minor grid lines
- `axis.ticks.length` edits the length of the axis tick marks

The ability to edit or create a theme is the essential tool for customizing graphs in `ggplot2`. I've show two small customizations; the full list is given [here](http://rstudio-pubs-static.s3.amazonaws.com/3364_d1a578f521174152b46b19d0c83cbe7e.html).

### one code chunk would have sufficed 

We've written out the layers in separate code chunks for clarity, but they could have been assembled into one code chunk, giving you an idea of how compact and readable (well, once you've learned the grammar) the `ggplot2` syntax can be. 

![](../resources/images/code-icon.png)<!-- --> (optional)
 

```r
calibr_graph <- ggplot(graph_data, aes(input_lb, output_mV)) +
	geom_smooth(method = 'lm', se = FALSE, color = 'gray70',  size = 0.5) + 
	geom_point(size = 1.5, stroke = 0.7, shape = 21, color = 'black', fill= 'gray70') +
	xlab("Applied force (lb)") + 
	ylab("Sensor reading (mV)") +
	scale_x_continuous(breaks = seq(0.5, 4.5, 1)) +
	scale_y_continuous(breaks = seq(10, 90, 20)) +
	theme_light() +
	theme(panel.grid.minor = element_blank(), axis.ticks.length = unit(2, "mm"))

print(calibr_graph)
```

Learn ggplot2. Earlier, we shortened the `seq()` function by writing the arguments in a particular order. We can do the same with other functions:

- From `ggplot()`, you can omit `data = `, leaving the data frame name
- From `aes()`, you can omit `x = ` and `y = `, leaving the x-variable and y-variable names in that order

### print to file 

![](../resources/images/text-icon.png)<!-- -->

    # Print to file  

![](../resources/images/code-icon.png)<!-- -->


```r
# print to file
ggsave("results/03_calibr_graph.png", plot = calibr_graph, 
			 width = 6, height = 4, units = "in", dpi = 300)
```

Learning ggplot2

- Save to the `results` directory because the graph will be used in a report
- `dpi = 300` for using in a print document
- `dpi` $\times$ `width` and `dpi` $\times$ `height` in inches yields screen dimension in pixels (72 ppi for web resolution is a  [myth](http://www.photoshopessentials.com/essentials/the-72-ppi-web-resolution-myth/)).



### check yourself

Your directories should contain these files:

    data\
      |-- 007_wide-data.csv
      |-- 01_calibr_data_active-report.csv
      `-- 02_calibr_data-tidy.csv

    reports\
    
    resources\
      `-- load-cell-setup-786x989px.png 
      
    results\
      |-- 01_calibr_data-wide.csv 
      `-- 03_calibr_graph.png
      
    scripts\
      |-- 01_calibr_data-wide.Rmd 
      |-- 02_calibr_data-tidy.Rmd 
      `-- 03_calibr_graph.Rmd


### graph extras

There's much more we can do to bring the graph up to publication standards.

I've prepared a (completely optional) tutorial that develops some [graph extras](116_graph-extras.html)  for those of you who want to know MORE and you want it NOW.  Topics include:

- Jitter the data markers to reduce printing overlap and set a random seed so jittering is repeatable
- Use the results table to dynamically assign units to the axis labels and set  tick mark locations
- Use the results table to dynamically edit the calibration equation and print it on the graph
- Format the calibration equation for significant figures
- Change font sizes


---
Back [tidy the data](110_tidy-data.html)<br>
Next [perform a linear regression](112_regression.html)


