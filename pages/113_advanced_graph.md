---
layout: page
title: "advanced graph topics"
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

This was saved to the results directory earlier


```r
results_table <- read_csv("results/03_calibr_regression_results-table.csv")
results_table
```

Extract the numbers and units we want. 


```r
# the slope value appears in the regression equation
slope_df    <- filter(results_table, item == 'slope')
slope_value <- slope_df$value

# the intercept value appears in the regression equation
intercept_df    <- filter(results_table, item == 'intercept')
intercept_value <- intercept_df$value

# input units appear in the x-axis label
input_range_df <- filter(results_table, item == 'input_range')
input_units    <- input_range_df$units

# output units appear in the y-axis label
output_span_df <- filter(results_table, item == 'output_span')
output_units   <- output_span_df$units

# check the results
slope_value
intercept_value
input_units
output_units
```


### recreate the basic graph. 


```r
graph_data <- read_csv("results/03_calibr_regression_graph-data.csv")
calibr_graph <- ggplot(data = graph_data) +
	geom_line(aes(x = input_lb, y = fit_mV), size = 0.4, color = 'gray70') + 
	geom_point(aes(x = input_lb, y = output_mV), size = 2, 
						 stroke = 0.7, shape = 21, color = 'black', fill= 'gray70') + 
	xlab("Applied force (lb)") + 
	ylab("Sensor reading (mV)") +
	scale_x_continuous(breaks = seq(from = 0.5, to = 4.5, by = 1)) +
	scale_y_continuous(breaks = seq(from = 10, to = 90, by = 20)) +
	theme_light() +
	theme(panel.grid.minor = element_blank())

# print to output	
print(calibr_graph)
```



### jitter

Add the `position` argument to `geom_point()`, Play with `width` and `height` until jitter is useful but not overdone. 

Next add `set.seed()` before the graph is created. An easy way to set a seed is to use a number based on today's date, e.g., `set.seed(20160824)`. After setting the seed, you may have to tweak the jitter `width` and `height` again. 


```r
# one new line to set the seed
set.seed(20160824)

calibr_graph <- ggplot(data = graph_data) +
	geom_line(aes(x = input_lb, y = fit_mV), size = 0.4, color = 'gray70') + 
	geom_point(aes(x = input_lb, y = output_mV), size = 2, 
						 stroke = 0.7, shape = 21, color = 'black', fill= 'gray70', 
						 
						 # one new line to use the jitter function
						 position = position_jitter(width = 0.08, height = 0)) + 
	
	xlab("Applied force (lb)") + 
	ylab("Sensor reading (mV)") +
	scale_x_continuous(breaks = seq(from = 0.5, to = 4.5, by = 1)) +
	scale_y_continuous(breaks = seq(from = 10, to = 90, by = 20)) +
	theme_light() +
	theme(panel.grid.minor = element_blank())

# print to output	
print(calibr_graph)
```

### axis units from the data table

If he units change in the analysis and are correctly saved to file, then that change can propagate here without manually editing the file. 

Before the graph, create a x-label string and y-label string using `paste0`. Those strings then become the arguments of the `xlab()` and `ylab()` functions. 


```r
set.seed(20160824)

# two new lines
my_xlab <- paste0("Applied force (", input_units, ")")
my_ylab <- paste0("Sensor reading (", output_units, ")")

calibr_graph <- ggplot(data = graph_data) +
	geom_line(aes(x = input_lb, y = fit_mV), size = 0.4, color = 'gray70') + 
	geom_point(aes(x = input_lb, y = output_mV), size = 2, 
						 stroke = 0.7, shape = 21, color = 'black', fill= 'gray70', 
						 position = position_jitter(width = 0.08, height = 0)) + 

	# two edited lines	
	xlab(my_xlab) + 
	ylab(my_ylab) +
	
	scale_x_continuous(breaks = seq(from = 0.5, to = 4.5, by = 1)) +
	scale_y_continuous(breaks = seq(from = 10, to = 90, by = 20)) +
	theme_light() +
	theme(panel.grid.minor = element_blank())

# print to output	
print(calibr_graph)
```

### axis tick marks from the data

Find the unique values in the input forces and sort them. 


```r
x_test_seq <- sort(unique(graph_data$input_lb))
x_test_seq
```

Find the equivalent (nominal) values in the output mV readings. Sort and round to the nearest 10 mV (to be used as tick mark locations). 


```r
# round to the nearest 10
y_nominal_seq <- sort(unique(graph_data$fit_mV))
y_nominal_seq <- plyr::round_any(y_nominal_seq, 10)
y_nominal_seq
```


```r
set.seed(20160824)
my_xlab <- paste0("Applied force (", input_units, ")")
my_ylab <- paste0("Sensor reading (", output_units, ")")
calibr_graph <- ggplot(data = graph_data) +
	geom_line(aes(x = input_lb, y = fit_mV), size = 0.4, color = 'gray70') + 
	geom_point(aes(x = input_lb, y = output_mV), size = 2, 
						 stroke = 0.7, shape = 21, color = 'black', fill= 'gray70', 
						 position = position_jitter(width = 0.08, height = 0)) + 
	xlab(my_xlab) + 
	ylab(my_ylab) +

	# edit two lines
	scale_x_continuous(breaks = x_test_seq) +
	scale_y_continuous(breaks = y_nominal_seq) +
	
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

# one new line to define the calibration equation
calibr_eqn <- paste0("y = ", sprintf("%.3f", slope_value), 
										 " x + ", sprintf("%.3f", intercept_value)) 

calibr_graph <- ggplot(data = graph_data) +
	geom_line(aes(x = input_lb, y = fit_mV), size = 0.4, color = 'gray70') + 
	geom_point(aes(x = input_lb, y = output_mV), size = 2, 
						 stroke = 0.7, shape = 21, color = 'black', fill= 'gray70', 
						 position = position_jitter(width = 0.08, height = 0)) + 
	xlab(my_xlab) + 
	ylab(my_ylab) +
	scale_x_continuous(breaks = x_test_seq) +
	scale_y_continuous(breaks = y_nominal_seq) +

	# one new function to add the calibration equation
	annotate("text", x = min(graph_data$input_lb), 
					 y = max(graph_data$output_mV), label = calibr_eqn, 
					 family = "serif", fontface = "italic", 
					 hjust = "left", vjust = "top") + 

	theme_light() +
	theme(panel.grid.minor = element_blank())
		
# print to output	
print(calibr_graph)
```

### font sizing

Lastly, we edit the font sizes used by editing the theme. We add two lines, one inside the annotate function (size units are mm) and one inside the theme function (units are points). 


```r
set.seed(20160824)
my_xlab <- paste0("Applied force (", input_units, ")")
my_ylab <- paste0("Sensor reading (", output_units, ")")
calibr_eqn <- paste0("y = ", sprintf("%.3f", slope_value), 
										 " x + ", sprintf("%.3f", intercept_value)) 
calibr_graph <- ggplot(data = graph_data) +
	geom_line(aes(x = input_lb, y = fit_mV), size = 0.4, color = 'gray70') + 
	geom_point(aes(x = input_lb, y = output_mV), size = 1.5, 
						 stroke = 0.7, shape = 21, color = 'black', fill= 'gray70', 
						 position = position_jitter(width = 0.08, height = 0)) + 
	xlab(my_xlab) + 
	ylab(my_ylab) +
	scale_x_continuous(breaks = x_test_seq) +
	scale_y_continuous(breaks = y_nominal_seq) +
	annotate("text", x = min(graph_data$input_lb), 
					 y = max(graph_data$output_mV), label = calibr_eqn, 
					 family = "serif", fontface = "italic", 
					 hjust = "left", vjust = "top",
					 
					 # add size spec in mm (convert using 2.85 pt/mm)
					 size = 11/2.85) + 
	
	theme_light() +
	theme(panel.grid.minor = element_blank(), 
				
				# add size spec in points for all other text
				axis.text  = element_text(size = 10), 
				axis.title = element_text(size = 10)
				)

# print to output	
print(calibr_graph)

ggsave("results/113_advanced_graph.png", plot = calibr_graph, 
			 width = 6, height = 4, units = "in", dpi = 300)
```

