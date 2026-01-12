# =====================================
# ONE SINGLE COMPLETE R CODE (NO ggplot2)
# =====================================

# Load required libraries
library(ggplot2)
library(dplyr)
library(readr)

# Load Iris dataset
iris_data <- read_csv("R/Iris.csv")

# -------------------------------------
# 1. Scatter Plot
# -------------------------------------
plot(
  iris_data$SepalLengthCm,
  iris_data$PetalLengthCm,
  col = as.numeric(iris_data$Species),
  pch = 19,
  xlab = "Sepal Length (cm)",
  ylab = "Petal Length (cm)",
  main = "Scatter Plot: Sepal Length vs Petal Length"
)

legend("topleft",
       legend = unique(iris_data$Species),
       col = 1:length(unique(iris_data$Species)),
       pch = 19)

# -------------------------------------
# 2. Pie Chart
# -------------------------------------
species_count <- table(iris_data$Species)

pie(
  species_count,
  main = "Pie Chart: Iris Species Distribution",
  col = c("skyblue", "pink", "lightgreen")
)

# -------------------------------------
# 3. High-Low Chart
# -------------------------------------
high_low_data <- iris_data %>%
  group_by(Species) %>%
  summarise(
    High = max(SepalLengthCm),
    Low = min(SepalLengthCm)
  )

plot(
  1:nrow(high_low_data),
  high_low_data$High,
  ylim = range(c(high_low_data$Low, high_low_data$High)),
  xaxt = "n",
  xlab = "Species",
  ylab = "Sepal Length (cm)",
  main = "High-Low Chart: Sepal Length Range",
  pch = 19
)

segments(
  x0 = 1:nrow(high_low_data),
  y0 = high_low_data$Low,
  x1 = 1:nrow(high_low_data),
  y1 = high_low_data$High,
  lwd = 3,
  col = "blue"
)

axis(1, at = 1:nrow(high_low_data), labels = high_low_data$Species)

