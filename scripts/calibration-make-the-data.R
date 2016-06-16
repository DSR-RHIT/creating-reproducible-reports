# make up some calibration data for a 0-5 lb load cell
# 
# 2016-06-09
# RAL

library(dplyr)
library(readr)
library(tidyr)
library(knitr)

# functions
up_data <- function(seed, cycle) {
  direction <- 'up'
  input_lb  <- sort(input_lb, decreasing = FALSE)
  test_point <- 1:length(input_lb)
  set.seed(seed)
  output_mV <- round(jitter(input_lb * sensitivity, 0.4), 1)
  up_data <- data.frame(cycle, test_point, direction, input_lb, output_mV
                        , stringsAsFactors = FALSE)
}

down_data <- function(seed, cycle) {
  direction <- 'dn'
  input_lb  <- sort(input_lb, decreasing = TRUE)
  test_point <- length(input_lb) + c(1:length(input_lb))
  set.seed(seed)
  output_mV <- round(jitter(input_lb * sensitivity, 0.4), 1)
  down_data <- data.frame(cycle, test_point, direction, input_lb, output_mV
                          , stringsAsFactors = FALSE)
}

one_cycle <- function(seed, cycle){
  seed  <- seed + 1
  up    <- up_data(seed, cycle)
  seed  <- seed + 1
  down  <- down_data(seed, cycle)
  df    <- rbind(up[-1, ], down[-1, ])
  return_list <- list(df, seed)
}

clean_dataset <- function(df, ncycle, from_to){
  df <- df %>%
    filter(cycle %in% 1:ncycle) # eliminate rows for the short set
  n_rows     <- dim(df)[1]
  n_in_cycle <- n_rows / ncycle
  start_at   <- from_to
  end_at     <- start_at + n_in_cycle * (ncycle - 1)
  new_length <- end_at - start_at + 1
  df <- df[start_at:end_at, ] %>%
    mutate(observ = 1:new_length) %>%
    select(observ, cycle, test_point, direction
           , input_lb, input_lb, output_mV)
  df_up <- df %>%
    filter(direction == 'up') %>%
    mutate(test_point = test_point + 1)
  df_dn <- df %>%
    filter(direction == 'dn') %>% 
    mutate(test_point = n_in_cycle - test_point + 1)
  df <- rbind(df_up, df_dn) %>%
    arrange(observ)
  df
}

# sensor parameters
input_lb <- seq(0.5, 4.5, 1) # lb
sensitivity <- 20 # mV/lb

# calibration cycles
from_to     <- 2 # test point at which cycles begin and end
few_cycles  <- 3
more_cycles <- 6

# initialize the data frame
seed  <- 20160824
cycle <- 1
return_list <- one_cycle(seed, cycle)
df <- data.frame(return_list[1])

# add the remaining cycles
for(jj in 2:more_cycles){
  seed        <- unlist(return_list[2])
  return_list <- one_cycle(seed, cycle = jj)
  next_df     <- data.frame(return_list[1])
  df          <- rbind(df, next_df)
}

# rationalize the test_points
points <- df[ , 'test_point', drop = FALSE]
unique_values <- unique(points)
row.names(unique_values) <- NULL
unique_values$ordering <- as.numeric(row.names(unique_values))
df <- left_join(df, unique_values, by = 'test_point') %>%
  select(-test_point) %>%
  rename(test_point = ordering) %>%
  select(test_point, cycle, direction, input_lb, input_lb, output_mV)

# truncate the data set to desired length and add observation N
data_few_cycles  <- clean_dataset(df, ncycle = few_cycles, from_to)
data_more_cycles <- clean_dataset(df, ncycle = more_cycles, from_to)


# write to file
write_csv(data_few_cycles, 'print-pages/calibration-data.csv')
write_csv(data_more_cycles, 'print-pages/calibration-data-more-cycles.csv')

kable(data_few_cycles)



# turn the long form data into common tables
table_few_cycles <- data_few_cycles %>%
  select(-observ) %>%
  mutate(cycle = paste0('cycle', cycle, '_mV')) %>%
  spread(cycle, output_mV) %>%
  arrange(desc(direction), test_point)
table_few_cycles[4:8, ] <- arrange(table_few_cycles[4:8, ], desc(test_point))
table_few_cycles <- table_few_cycles %>%
  mutate(test_point = paste(test_point, direction)) %>%
  select(-direction)
names(table_few_cycles) <- c('test_point', 'input_lb'
                             , 'cycle1_mV', 'cycle2_mV', 'cycle3_mV')

table_more_cycles <- data_more_cycles %>%
  mutate(cycle = paste0('cycle', cycle, '_mV')) %>%
  select(-observ) %>%
  spread(cycle, output_mV) %>%
  arrange(desc(direction), test_point)
table_more_cycles[4:8, ] <- arrange(table_more_cycles[4:8, ], desc(test_point))
table_more_cycles <- table_more_cycles %>%
  mutate(test_point = paste(test_point, direction)) %>%
  select(-direction)
names(table_more_cycles) <- c('test_point', 'input_lb'
                              , 'cycle1_mV', 'cycle2_mV', 'cycle3_mV'
                              , 'cycle4_mV', 'cycle5_mV', 'cycle6_mV')

write_csv(table_few_cycles, 'print-pages/calibration-table.csv')
write_csv(table_more_cycles, 'print-pages/calibration-table-more-cycles.csv')

kable(table_few_cycles)
# last line


# License BSD-3-clause
#
# Copyright (c) 2016, Richard Layton
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
#   
#   1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
# 
# 2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
# 
# 3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
# 
# This software is provided by the copyright holders and contributors "as is" and any express or implied warranties, including, but not limited to, the implied warranties of merchantability and fitness for a particular purpose are disclaimed. In no event shall the copyright holder or contributors be liable for any direct, indirect, incidental, special, exemplary, or consequential damages (including, but not limited to, procurement of substitute goods or services; loss of use, data, or profits; or business interruption) however caused and on any theory of liability, whether in contract, strict liability, or tort (including negligence or otherwise) arising in any way out of the use of this software, even if advised of the possibility of such damage.


