# Load required library
library(writexl)
library(readr)

# 1. Read IPL CSV file
data <- read_csv("R/IPL_ball_by_ball_updated.csv", show_col_types = FALSE)

# 2. Create Runs and Dots correctly
data$Runs <- data$runs_off_bat + data$extras
data$Dots <- ifelse(data$runs_off_bat == 0 & data$extras == 0, 1, 0)

# 3. Perform Linear Regression
model <- lm(Runs ~ Dots, data = data)

# 4. Show statistical summary
summary(model)

# 5. Extract coefficients
results_df <- as.data.frame(summary(model)$coefficients)

# 6. Plot results
plot(data$Dots, data$Runs,
     main = "Regression: Dots vs Runs",
     xlab = "Dot Ball (1 = Dot, 0 = Non-Dot)",
     ylab = "Runs Conceded",
     pch = 16, col = "darkgreen")

# Add regression line
abline(model, col = "red", lwd = 2)

# 7. Save results to Excel
write_xlsx(results_df, "Regression_Results.xlsx")

