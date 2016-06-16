# calibration data tidying

# load libraries
library(dplyr)
library(readr)
library(tidyr)
library(knitr)

# read the data, keep in wide form for the printed table
df_wide <- read_csv('reports/2016-08-example-calibr/load-cell-calibr-W3.csv')

# long form, used for the analysis, can omit the first column
df_long <- df_wide %>%
  select(-test_point)

# indices for gather cycles from wide to long form
cycle_cols <- grep('cycle', names(df_long))

# gather wide to long, producing a 2-column (x-y) data frame
df_long <- df_long %>%
  gather(cycle_no, output_mV, cycle_cols) %>%
  select(-cycle_no)

# delete rows with NA
keep_rows <- complete.cases(df_long)
df_long <- df_long[keep_rows, ]

df_long$observ <- 1:nrow(df_long)
df_long <- df_long %>%
  select(observ, input_lb, output_mV)

# values for reporting
n_cycles <- length(cycle_cols)
n_observ <- nrow(df_long)

kable(df_long)
