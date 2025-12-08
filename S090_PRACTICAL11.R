library(dplyr)
library(tidyr)

# ==============================================================================
# 1. SETUP: Create and Import Data (fixed)
# ==============================================================================

# Use readr::read_csv (explicit) and correct 'na' argument
df <- readr::read_csv("R/flipkart_com-ecommerce_sample.csv", na = c("", "NA")) %>%
  mutate(InvoiceIndex = row_number())

# Print column names so you can confirm what's actually in the file
cat("--- Columns in the imported CSV ---\n")
print(colnames(df))

# Try to keep only the columns of interest if they exist (avoids select() errors)
df <- df %>% select(InvoiceIndex, any_of(c("Product.line", "Unit.price", "Tax.5.")))

cat("--- 1. Original Wide Data ---\n")
print(head(df))

# ==============================================================================
# 2. PIVOT_LONGER (Wide to Long) - robust to missing pivot columns
# ==============================================================================

pivot_cols <- intersect(names(df), c("Unit.price", "Tax.5."))

if (length(pivot_cols) == 0) {
  cat("Warning: No pivot columns (Unit.price or Tax.5.) found - skipping pivot_longer\n")
  long_df <- df   # fallback: keep original
} else {
  long_df <- df %>%
    pivot_longer(
      cols = any_of(pivot_cols),
      names_to = "Metric",
      values_to = "Value"
    )
  cat("--- 2. Long Format (pivot_longer) ---\n")
  print(head(long_df, 6))
}

# ==============================================================================
# 3. PIVOT_WIDER (Long to Wide) - only if we actually created long_df with Metric
# ==============================================================================

if ("Metric" %in% names(long_df)) {
  wide_df <- long_df %>%
    pivot_wider(
      names_from = Metric,
      values_from = Value
    )
  cat("--- 3. Wide Format (Back to Original) ---\n")
  print(head(wide_df))
} else {
  cat("Skipping pivot_wider because long format was not created.\n")
}

# ==============================================================================
# 4. ADVANCED EXAMPLE (Reshaping for Reporting) - robust to missing Product.line / Unit.price
# ==============================================================================

if (!("Product.line" %in% names(df))) {
  cat("Note: 'Product.line' not present - creating placeholder 'Product.line' = 'Unknown'\n")
  df <- df %>% mutate(Product.line = "Unknown")
}

if (!("Unit.price" %in% names(df))) {
  cat("Note: 'Unit.price' not present - creating placeholder 'Unit.price' = NA_real_'\n")
  df <- df %>% mutate(Unit.price = NA_real_)
}

df_clean <- df %>%
  mutate(Product.line = ifelse(is.na(Product.line) | Product.line == "", "Unknown", Product.line))

category_pivot <- df_clean %>%
  select(InvoiceIndex, Product.line, Unit.price) %>%
  pivot_wider(
    names_from = Product.line,
    values_from = Unit.price
  )

cat("--- 4. Category Pivot (Spreading Categories) ---\n")
print(head(category_pivot))

