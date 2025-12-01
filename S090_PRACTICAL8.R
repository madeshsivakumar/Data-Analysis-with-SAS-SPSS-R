# ==============================================================================
# R Script: Handling Missing Values (Data Cleaning)
# Dataset: Retail Product Data (converted to use the uploaded data.csv)
# ==============================================================================

# Load necessary libraries
# install.packages("dplyr")
# install.packages("tidyr")
library(dplyr)
library(tidyr) # Contains replace_na()

# ==============================================================================
# 1. CREATE AND IMPORT DATASET
# ==============================================================================
# Note: 'na.strings = c("", "NA")' tells R to treat empty strings and "NA" as NA (Missing Values).

# Read dataset (the uploaded file is named "data.csv")
retail_df <- read.csv("data.csv", na.strings = c("", "NA"), stringsAsFactors = FALSE)

# The uploaded CSV has columns like:
# InvoiceNo, StockCode, Description, Quantity, InvoiceDate, UnitPrice, CustomerID, Country
# To match the original script's expected column names (Category, Discount, Stock, Price, Rating),
# we create mapping columns so the rest of the script can remain unchanged.

# Map columns:
# Category <- Description
# Price    <- UnitPrice
# Stock    <- Quantity (as character to allow "Check Warehouse" replacement)
# Discount <- (create an explicit Discount column which may contain NAs in source)
# (Rating is not present in this dataset; left absent as in the original script we didn't modify Rating)

retail_df <- retail_df %>%
  mutate(
    Category = Description,
    Price = UnitPrice,
    Stock = as.character(Quantity),
    Discount = NA  # no discount field in this CSV; create it so replace_na can operate
  )

print("--- 1. Original Data (First 6 Rows) ---")
print(head(retail_df))

# Check how many NAs are in each column
print("--- Count of Missing Values per Column ---")
print(colSums(is.na(retail_df)))

# ==============================================================================
# 2. METHOD A: REMOVE MISSING VALUES (na.omit)
# ==============================================================================
# This is the "nuclear option". If a row has even ONE missing value, it is deleted.

clean_omit <- na.omit(retail_df)

print("--- 2. Data after na.omit() ---")
print(paste("Original rows:", nrow(retail_df)))
print(paste("Rows remaining:", nrow(clean_omit)))
print(head(clean_omit))


# ==============================================================================
# 3. METHOD B: REPLACE MISSING VALUES (replace_na)
# ==============================================================================
# This is the "surgical option". We fill missing values with logical defaults.
# Strategy:
# 1. Category: Fill missing with "Unknown"
# 2. Discount: Fill missing with 0 (Assumption: No data = no discount)
# 3. Stock: Fill missing with "Check Warehouse"
# 4. Price: Fill missing with the Mean (Average) Price

# Calculate average price (ignoring NAs) to use for filling
avg_price <- mean(retail_df$Price, na.rm = TRUE)

clean_replace <- retail_df %>%
  replace_na(list(
    Category = "Unknown",
    Discount = 0,
    Stock = "Check Warehouse",
    Price = avg_price
  ))

print("--- 3. Data after replace_na() ---")
# Check row 3 specifically: In original data, Price might have been NA. Now it should be the average.
print(clean_replace[3, ])
print(head(clean_replace))

# Verify no NAs exist in the columns we cleaned (except any columns we intentionally didn't touch)
print("--- Remaining NAs after replacement ---")
print(colSums(is.na(clean_replace)))
