library(readr)
library(dplyr)

# ---- 1. Load files (adjust paths if necessary) ----
housing_df <- read_csv("R/Housing.csv", show_col_types = FALSE)
store_df   <- read_csv("R/superstore.csv", show_col_types = FALSE)

cat("--- Column Names ---\n")
cat("Housing columns:\n"); print(names(housing_df))
cat("Store columns:\n");   print(names(store_df))

# ---- 2. Prepare housing_clean ----
# Choose a categorical column for 'Species' and numeric for 'Height'
# Based on your housing columns: we'll use 'furnishingstatus' as Species and 'area' as Height
if (!all(c("furnishingstatus", "area") %in% names(housing_df))) {
  stop("Expected columns 'furnishingstatus' and/or 'area' not found in housing_df. Check column names.")
}

housing_clean <- housing_df %>%
  select(Species = furnishingstatus, Height = area) %>%
  mutate(
    Species = as.character(Species),
    Height  = as.numeric(Height)
  )

# ---- 3. Prepare store_clean ----
# Use Category as Species and Sales as Height (you already used these)
if (!all(c("Category", "Sales") %in% names(store_df))) {
  stop("Expected columns 'Category' and/or 'Sales' not found in store_df. Check column names.")
}

store_clean <- store_df %>%
  select(Species = Category, Height = Sales) %>%
  mutate(
    Species = as.character(Species),
    Height  = as.numeric(Height)
  )

# ---- 4. Optional: preview and clean NAs ----
cat("--- Housing preview ---\n"); print(head(housing_clean))
cat("--- Store preview ---\n");   print(head(store_clean))

# Remove rows where Height is NA (if any)
housing_clean <- housing_clean %>% filter(!is.na(Height))
store_clean   <- store_clean   %>% filter(!is.na(Height))

# ---- 5. Combine ----
combined_data <- bind_rows(housing_clean, store_clean)  # safer than rbind for tibbles

# ---- 6. Summary ----
cat("--- Combined Data Summary ---\n")
cat(paste("Housing rows:", nrow(housing_clean)), "\n")
cat(paste("Store   rows:", nrow(store_clean)), "\n")
cat(paste("Total rows (Expected):", nrow(housing_clean) + nrow(store_clean)), "\n")
cat(paste("Total rows (Actual):", nrow(combined_data)), "\n")

cat("--- HEAD of combined_data ---\n"); print(head(combined_data))
cat("--- TAIL of combined_data ---\n"); print(tail(combined_data))

