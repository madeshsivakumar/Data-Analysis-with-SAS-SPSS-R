# =====================================
# Logistic Regression using glm()
# IPL Ball-by-Ball Dataset (FINAL)
# =====================================

# Load libraries
library(readr)
library(dplyr)
library(writexl)

# Load CSV
data <- read_csv("R/IPL_ball_by_ball_updated.csv", show_col_types = FALSE)

# Convert BALL-LEVEL data to PLAYER-LEVEL data
player_data <- data %>%
  group_by(striker) %>%
  summarise(
    runs = sum(runs_off_bat, na.rm = TRUE)
  ) %>%
  arrange(desc(runs))

# Create ranking and binary outcome
player_data$pos <- rank(-player_data$runs, ties.method = "first")
player_data$Top5 <- ifelse(player_data$pos <= 5, 1, 0)
player_data$Top5 <- as.factor(player_data$Top5)

# Logistic Regression Model
logistic_model <- glm(Top5 ~ runs,
                      data = player_data,
                      family = binomial)

# Model Summary
model_summary <- summary(logistic_model)
print(model_summary)

# Plot
par(mfrow = c(1, 1))
par(mar = c(5, 5, 4, 2))

plot(player_data$runs,
     as.numeric(as.character(player_data$Top5)),
     main = "Logistic Regression: Runs vs Top 5 (IPL)",
     xlab = "Total Runs",
     ylab = "Top 5 Player (1 = Yes, 0 = No)",
     pch = 16,
     col = "darkgreen")

curve(
  predict(logistic_model,
          newdata = data.frame(runs = x),
          type = "response"),
  add = TRUE,
  col = "red",
  lwd = 2
)

# Extract coefficients
results_df <- as.data.frame(model_summary$coefficients)

# Export results
write.csv(results_df,
          "logistic_regression_results.csv",
          row.names = TRUE)

write_xlsx(results_df,
           "logistic_regression_results.xlsx")

pdf("logistic_regression_summary.pdf")
plot(player_data$runs,
     as.numeric(as.character(player_data$Top5)),
     main = "Logistic Regression Analysis",
     xlab = "Total Runs",
     ylab = "Top 5 Player",
     pch = 16,
     col = "darkgreen")
curve(
  predict(logistic_model,
          newdata = data.frame(runs = x),
          type = "response"),
  add = TRUE,
  col = "red",
  lwd = 2
)
dev.off()
