---
layout: page
title: "graph extras"
---




```r
library(readr)
library(plyr)
suppressPackageStartupMessages(library(dplyr))
library(ggplot2)
```

Topics: 

- Jitter the data markers to reduce printing overlap and set a random seed so jittering is repeatable 
- Use the results table to dynamically assign units to the axis labels and set  tick mark locations
- Use the results table to dynamically edit the calibration equation and print it on the graph
- Format the calibration equation for significant figures
- Change font sizes

### retrieve data we saved earlier

Extract the numbers and units we want. 


```r
# itemized results that are cited in the report 
results      <- read_csv('results/04_calibr_outcomes.csv')

# extract numbers and units
slope        <- results$num[results$item == "slope"]
intercept    <- results$num[results$item == "intercept"]
accuracy     <- results$num[results$item == "accuracy"]
resid_bound  <- results$num[results$item == "resid_bound"]
input_min    <- results$num[results$item == "input_min"]
input_max    <- results$num[results$item == "input_max"]
output_min   <- results$num[results$item == "output_min"]
output_max   <- results$num[results$item == "output_max"]
input_units  <- results$unit[results$item == "input_max"]
output_units <- results$unit[results$item == "output_max"]

# compute range and span
output_span <- output_max - output_min
input_range_fraction <- round(input_max / 5 * 100, 1)
```


### recreate the basic graph. 


```r
graph_data <- read_csv("data/02_calibr_data-tidy.csv")

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

### jitter

Add the `position` argument to `geom_point()`, Play with `width` and `height` until jitter is useful but not overdone. 

Next add `set.seed()` before the graph is created. An easy way to set a seed is to use a number based on today's date, e.g., `set.seed(20160824)`. After setting the seed, you may have to tweak the jitter `width` and `height` again. 


```r
set.seed(20160824) # ===== NEW LINE

calibr_graph <- ggplot(graph_data, aes(input_lb, output_mV)) +
    geom_smooth(method = 'lm', se = FALSE, color = 'gray70',  size = 0.5) + 
    geom_point(size = 1.5, stroke = 0.7, shape = 21, color = 'black', fill= 'gray70', position = position_jitter(width = 0.08, height = 0)) + # ===== ADD POSITION ARGUMENT
    xlab("Applied force (lb)") + 
    ylab("Sensor reading (mV)") +
    scale_x_continuous(breaks = seq(0.5, 4.5, 1)) +
    scale_y_continuous(breaks = seq(10, 90, 20)) +
    theme_light() +
    theme(panel.grid.minor = element_blank(), axis.ticks.length = unit(2, "mm"))

print(calibr_graph)
```

### axis units from the data table

If he units change in the analysis and are correctly saved to file, then that change can propagate here without manually editing the file. 

Before the graph, create a x-label string and y-label string using `paste0`. Those strings then become the arguments of the `xlab()` and `ylab()` functions. 


```r
set.seed(20160824)

my_xlab <- paste0("Applied force (", input_units, ")") # ===== NEW LINE
my_ylab <- paste0("Sensor reading (", output_units, ")") # ===== NEW LINE

calibr_graph <- ggplot(graph_data, aes(input_lb, output_mV)) +
    geom_smooth(method = 'lm', se = FALSE, color = 'gray70',  size = 0.5) + 
    geom_point(size = 1.5, stroke = 0.7, shape = 21, color = 'black', fill= 'gray70', position = position_jitter(width = 0.08, height = 0)) + 
  xlab(my_xlab) + # ===== EDITED LINE
  ylab(my_ylab) + # ===== EDITED LINE
	scale_x_continuous(breaks = seq(from = 0.5, to = 4.5, by = 1)) +
	scale_y_continuous(breaks = seq(from = 10, to = 90, by = 20)) +
	theme_light() +
	theme(panel.grid.minor = element_blank())

print(calibr_graph)
```

### axis tick marks from the data

Find the unique values in the input forces and sort them. 


```r
x_test_seq <- sort(unique(graph_data$input_lb))
x_test_seq
## [1] 0.5 1.5 2.5 3.5 4.5
```

Find the equivalent (nominal) values in the output mV readings. Sort and round to the nearest 10 mV (to be used as tick mark locations). 


```r
# round to the nearest 10
y_nominal_seq <- sort(unique(plyr::round_any(graph_data$output_mV, 10)))
y_nominal_seq
## [1] 10 30 50 70 90
```


```r
set.seed(20160824)

my_xlab <- paste0("Applied force (", input_units, ")")
my_ylab <- paste0("Sensor reading (", output_units, ")")

calibr_graph <- ggplot(graph_data, aes(input_lb, output_mV)) +
    geom_smooth(method = 'lm', se = FALSE, color = 'gray70',  size = 0.5) + 
    geom_point(size = 1.5, stroke = 0.7, shape = 21, color = 'black', fill= 'gray70', position = position_jitter(width = 0.08, height = 0)) + 
	xlab(my_xlab) + 
	ylab(my_ylab) +
  scale_x_continuous(breaks = x_test_seq) +  # ===== EDITED LINE
  scale_y_continuous(breaks = y_nominal_seq) +  # ===== EDITED LINE
	theme_light() +
	theme(panel.grid.minor = element_blank())

print(calibr_graph)
```


### adding the calibration equation

Create the text string and use `sprintf()` syntax to control significant figures.

Use the `annotate()` function to add the text to the plot, positioning it using the minimum x-value and the maximum y-value (upper-left quadrant of plot).  


```r
set.seed(20160824)

my_xlab <- paste0("Applied force (", input_units, ")")
my_ylab <- paste0("Sensor reading (", output_units, ")")

calibr_eqn <- paste0("y = ", sprintf("%.3f", slope), " x + ", sprintf("%.3f", intercept)) # ===== NEW LINE

calibr_graph <- ggplot(graph_data, aes(input_lb, output_mV)) +
    geom_smooth(method = 'lm', se = FALSE, color = 'gray70',  size = 0.5) + 
    geom_point(size = 1.5, stroke = 0.7, shape = 21, color = 'black', fill= 'gray70', position = position_jitter(width = 0.08, height = 0)) + 
	xlab(my_xlab) + 
	ylab(my_ylab) +
	scale_x_continuous(breaks = x_test_seq) +
	scale_y_continuous(breaks = y_nominal_seq) +
  annotate("text", x = min(graph_data$input_lb), y = max(graph_data$output_mV), label = calibr_eqn, family = "serif", fontface = "italic", hjust = "left", vjust = "top") +  # ===== NEW LINE
	theme_light() +
	theme(panel.grid.minor = element_blank())
		
print(calibr_graph)
```

### font sizing

Lastly, we edit the font sizes used by editing the theme. We add two lines, one inside the annotate function (size units are mm) and one inside the theme function (units are points). 


```r
set.seed(20160824)

my_xlab <- paste0("Applied force (", input_units, ")")
my_ylab <- paste0("Sensor reading (", output_units, ")")

calibr_eqn <- paste0("y = ", sprintf("%.3f", slope), " x + ", sprintf("%.3f", intercept)) 

calibr_graph <- ggplot(graph_data, aes(input_lb, output_mV)) +
    geom_smooth(method = 'lm', se = FALSE, color = 'gray70',  size = 0.5) + 
    geom_point(size = 1.5, stroke = 0.7, shape = 21, color = 'black', fill= 'gray70', position = position_jitter(width = 0.08, height = 0)) + 
	xlab(my_xlab) + 
	ylab(my_ylab) +
	scale_x_continuous(breaks = x_test_seq) +
	scale_y_continuous(breaks = y_nominal_seq) +
	annotate("text", x = input_min, y = output_max, label = calibr_eqn, family = "serif", fontface = "italic", hjust = "left", vjust = "top", size = 11/2.85) + # ===== ADD SIZE ARGUMENTS in mm (convert using 2.85 pt/mm)
	theme_light() +
	theme(panel.grid.minor = element_blank(), axis.text  = element_text(size = 10), axis.title = element_text(size = 10)) # ===== ADD SIZE ARGUMENTS in points

print(calibr_graph)

ggsave("results/114_advanced_graph.png", plot = calibr_graph, 
			 width = 6, height = 4, units = "in", dpi = 300)
```



---

Back [formatting docx](115_formatting.html)<br>
Next [main page](../index.html)
