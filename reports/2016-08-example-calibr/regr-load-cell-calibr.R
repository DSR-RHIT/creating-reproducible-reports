# calibration report analysis

library(readr)

df_long <- read_csv('reports/2016-08-calibration/calibration-data-long.csv')

# perform the regression
regr_results <- lm(output_mV ~ input_lb, data = df_long)

# y-fitted values are used to graph the linear regression curve
y_fit <- regr_results$fitted.values

# span is needed to determine accuracy in percentage form
output_span  <- max(y_fit) - min(y_fit)

# selected regression results for printing to the document
regr_summ <- summary.lm(regr_results)
residuals <- regr_summ$residuals
intercept <- regr_summ$coefficients[1]
slope     <- regr_summ$coefficients[2]
adj_r_sq  <- regr_summ$adj.r.squared

# compute accuracy in mV and as a percentage for reporting
acc_plus  <- max(residuals)
acc_minus <- min(residuals)

acc_plus_pct  <- acc_plus / output_span * 100
acc_minus_pct <- acc_minus / output_span * 100

accuracy <- max(abs(c(acc_plus_pct, acc_minus_pct)))

# create a data frame for printing a table of results
Result <- c('slope', 'intercept', 'adjusted $R^2$', 'max residual', 'min residual')
Value  <- c(slope, intercept, adj_r_sq, acc_plus, acc_minus)
Units  <- c('mV/lb', 'mV', 'mV', 'mV', 'mV')
tabulated_results <- data.frame(Result, Value, Units)
