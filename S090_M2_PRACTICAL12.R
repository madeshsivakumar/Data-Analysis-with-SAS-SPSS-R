# Load required library
library(readr)

# Load the dataset
data <- read_csv("R/2015.csv")

# Select only numeric columns
numeric_data <- data[sapply(data, is.numeric)]

# Generate correlation matrix
correlation_matrix <- cor(
  numeric_data,
  use = "complete.obs",
  method = "pearson"
)

# Display correlation matrix (TABLE output)
print(correlation_matrix)

# -------------------------------------
# OPTIONAL GRAPH (Heatmap)
# -------------------------------------
heatmap(
  correlation_matrix,
  main = "Correlation Matrix Heatmap",
  col = heat.colors(64),
  symm = TRUE
)

