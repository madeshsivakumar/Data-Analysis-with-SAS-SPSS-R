#==============================================================================
# R Script: Creating New Variables (Transformations & Calculations)
# Dataset: Superstore Sales Data
#==============================================================================

library(dplyr)
library(tidyr) # Used to clean the data first

# ==============================================================================
# 1. SETUP:  Import the Dataset
# ==============================================================================

# Import Superstore dataset
superstore_df <- read.csv("Downloads/dataset/Sample - Superstore.csv", na.strings = c("", "NA"))

# PRE-CLEANING:
# Transformations fail if numbers are missing (NA).
# Fill missing Sales/Discount/Profit with 0 for calculations demo
superstore_clean <- superstore_df %>%
  mutate(
    Sales = replace_na(Sales, 0),
    Discount = replace_na(Discount, 0),
    Profit = replace_na(Profit, 0)
  )

print("--- Cleaned Baseline Data ---")
print(head(superstore_clean[, c("Product.ID", "Category", "Sales", "Discount", "Profit")]))

#==============================================================================
# 2. METHOD A: ARITHMETIC CALCULATIONS
#==============================================================================
# Scenario: Calculate the 'Final_Sales' after applying discount
# Formula: Sales - (Sales * Discount)

superstore_calc <- superstore_clean %>%
  mutate(
    Discount_Amount = Sales * Discount,       # Discount column is already fractional in this dataset
    Final_Sales = Sales - Discount_Amount
  )

print("--- Method A: Arithmetic Results (Final Sales) ---")
print(superstore_calc %>% select(Sales, Discount, Final_Sales))

#==============================================================================
# 3. METHOD B: CONDITIONAL LOGIC (ifelse)
#==============================================================================
# Scenario: Create a 'Profit_Label' based on Profit value
# Logic: If Profit > 100, "High Profit", else "Low Profit"

superstore_logic <- superstore_clean %>%
  mutate(
    Profit_Label = ifelse(Profit > 100, "High Profit", "Low Profit"),
    Sales_Category = ifelse(Sales > 500, "Premium Sale", "Regular Sale")
  )

print("--- Method B: Logic Results (Labels) ---")
print(superstore_logic %>% select(Sales, Profit, Profit_Label, Sales_Category))

#==============================================================================
# 4. METHOD C: TEXT TRANSFORMATION (paste)
#==============================================================================
# Scenario: Create 'Product_Summary' combining Category and Product Name
superstore_text <- superstore_clean %>%
  mutate(
    Product_Summary = paste(Category, "product:", Product.Name, "with Sales $", Sales)
  )

print("--- Method C: Text Transformation ---")
print(head(superstore_text$Product_Summary))

#==============================================================================
# 5. ALL TOGETHER (The Standard Workflow)
#==============================================================================

final_superstore <- superstore_clean %>%
  mutate(
    Final_Sales = Sales - (Sales * Discount),
    Is_High_Value = ifelse(Final_Sales > 500, TRUE, FALSE),
    Status_Report = paste0("Profit: $", round(Profit, 2), " / Discount: ", Discount * 100, "%")
  )

print("--- Final Combined Dataset ---")
print(head(final_superstore[, c("Product.ID", "Category", "Final_Sales", "Is_High_Value", "Status_Report")]))