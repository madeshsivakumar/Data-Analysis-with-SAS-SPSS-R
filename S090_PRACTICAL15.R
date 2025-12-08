# =============================================================================
# R Script: Generating Basic Summaries
# Functions: str() and summary()
# Dataset: Retail Product Data (Simulated)
# =============================================================================

# 1. SETUP: Create Sample Data
# We create a dataframe with mixed data types (Numeric, Character, Logical, NA)
retail_df <- data.frame(
  ID = 1:6,
  Category = c("Electronics", "Home", "Electronics", "Clothing", "Home", "Clothing"),
  Price = c(500.50, 45.00, 900.00, NA, 300.00, 25.00),  # Note the NA
  In_Stock = c(TRUE, TRUE, FALSE, TRUE, FALSE, TRUE),
  Rating = c(4.5, 3.8, 4.9, 4.0, 3.5, 4.2),
  stringsAsFactors = FALSE
)
print("--- Data Loaded ---")
print(retail_df)

# 2. USING str() (Structure)
# Purpose: Compactly display the internal structure of the R object.
print("--- OUTPUT OF str() ---")
str(retail_df)

# 3. USING summary() (Statistical Summary)
# Purpose: detailed summary statistics for each column.
print("--- OUTPUT OF summary() [Before Factor Conversion] ---")
summary(retail_df)

# 4. IMPROVING summary() WITH FACTORS
# By default Category is character here; convert to factor to get counts per level.
print("--- Category counts (before factor conversion) ---")
print(table(retail_df$Category))

retail_df$Category <- as.factor(retail_df$Category)
print("--- OUTPUT OF summary() [After Factor Conversion] ---")
summary(retail_df)

# 5. Accessing Specific Summaries
# Sometimes you only want single values; use na.rm = TRUE when needed.
avg_rating <- mean(retail_df$Rating, na.rm = TRUE)
max_price  <- max(retail_df$Price, na.rm = TRUE)  # na.rm ignores the missing value

print(sprintf("Average Rating: %.2f", avg_rating))
print(sprintf("Highest Price: %.2f", max_price))

