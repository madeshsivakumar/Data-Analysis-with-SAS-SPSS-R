# =============================================================================
# R Script: Identifying and Handling Duplicates
# Function: distinct() from the dplyr package
# =============================================================================

# Load the library
library(dplyr)

# =============================================================================
# 1. SETUP: Create a Dataset with Intentional Duplicates
# - Row 1 and Row 6 are EXACT duplicates (Same OrderID, Customer, and Product)
# - Row 2 and Row 3 are EXACT duplicates
# - Row 5 and Row 7 share the same Customer ("wizzy"), but bought different products
orders_df <- data.frame(
  OrderID = c(101, 102, 102, 103, 104, 101, 104),
  Customer = c("madesh", "skizzy", "skizzy", "baby", "wizzy", "madesh", "wizzy"),
  Product = c("Laptop", "Phone", "Phone", "Tablet", "Monitor", "Laptop", "Mouse")
)
print("--- 1. Original Dataset (7 rows) ---")
print(orders_df)

# =============================================================================
# 2. IDENTIFYING DUPLICATES (Before removing them)
# Use group_by() + count() to find rows that appear more than once (exact duplicates)
duplicates_report <- orders_df %>%
  group_by(OrderID, Customer, Product) %>%
  count() %>%        # Counts occurrences
  filter(n > 1)      # Keeps only rows that appear more than once
print("--- 2. Identification Report (Rows that are duplicated) ---")
print(duplicates_report)

# =============================================================================
# 3. HANDLING DUPLICATES: Exact Matches
# Scenario: Remove rows where EVERY column is identical.
# Result: rows with exact duplicates (e.g., rows for OrderID 101 and 102) are de-duplicated.
# Dinesh (OrderID 104) remains twice because Products differ ("Monitor" vs "Mouse").
clean_exact <- orders_df %>%
  distinct()
print("--- 3. Removed Exact Duplicates (distinct) ---")
print(clean_exact)

# =============================================================================
# 4. HANDLING DUPLICATES: Specific Columns (.keep_all = TRUE)
# Scenario: We want a list of UNIQUE CUSTOMERS.
# If a customer appears multiple times, keep the first occurrence and keep all columns.
# Use .keep_all = TRUE to retain OrderID and Product for that first occurrence.
unique_customers <- orders_df %>%
  distinct(Customer, .keep_all = TRUE)
print("--- 4. Unique Customers Only (keep first occurrence of each Customer) ---")
print(unique_customers)

