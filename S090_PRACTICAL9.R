#9. Performing text manipulation using  str_sub(), str_split() (R). import dataset.
# ==============================================================================
# R Script: Text Manipulation with stringr
# Functions: str_sub(), str_split()
# ==============================================================================

# Load necessary library
install.packages("stringr")
install.packages("tidyr") # for separating columns after splitting
library(stringr)
library(tidyr)
library(dplyr)

# ==============================================================================
# 1. CREATE DATASET
# ==============================================================================
# We are adding a 'SKU' column which is perfect for text manipulation practice.
# Format: "CATEGORY-PRODUCTID-YEAR" (e.g., "ELEC-5548-2023")

retail_data <- data.frame(
  SKU = c("ELEC-5548-2023", "HOME-3045-2022", "CLOT-4004-2023", "ELEC-4808-2021", "HOME-1817-2023"),
  Description = c("Electronics - Smart TV", "Home - Blender", "Clothing - TShirt", "Electronics - Laptop", "Home - Sofa"),
  Price = c(500, 45, 20, 900, 300)
)

print("--- Original Dataset ---")
print(retail_data)

# ==============================================================================
# 2. USING str_sub() (Substring)
# ==============================================================================
# Scenario: We want to extract specific parts of the SKU based on position.
# Syntax: str_sub(string, start, end)

# Example A: Extract the first 4 characters to get the Category Code
retail_data$Category_Code <- str_sub(retail_data$SKU, 1, 4)

# Example B: Extract the last 4 characters to get the Year
# We can use negative numbers to count from the end of the string.
retail_data$Year <- str_sub(retail_data$SKU, -4, -1)

print("--- Data after str_sub() ---")
print(retail_data %>% select(SKU, Category_Code, Year))

# ==============================================================================
# 3. USING str_split() (Split String)
# ==============================================================================
# Scenario: The 'Description' column combines Category and Item Name with " - ".
# We want to split this into two separate pieces.

# Method A: Basic Split (Result is a list, harder to view directly in a dataframe)
split_list <- str_split(retail_data$Description, " - ")
print("--- Basic Split Output (List format) ---")
print(split_list[[1]]) # Viewing the first item

# Method B: Split Fixed (Returns a matrix, easier to assign to columns)
# simplify = TRUE returns a matrix instead of a list
split_matrix <- str_split(retail_data$Description, " - ", simplify = TRUE)

# Assign the split parts to new columns
retail_data$Main_Cat <- split_matrix[, 1] # First column of matrix
retail_data$Sub_Cat  <- split_matrix[, 2] # Second column of matrix

print("--- Data after str_split() (Manual Assignment) ---")
print(retail_data %>% select(Description, Main_Cat, Sub_Cat))


# ==============================================================================
# 4. BONUS: The "Tidy" Way (separate)
# ==============================================================================
# In RStudio / Tidyverse, we often use `separate()` which uses str_split logic 
# but automatically handles the column creation for us.

tidy_data <- retail_data %>%
  separate(SKU, into = c("Dept", "ID", "Mfg_Year"), sep = "-")

print("--- Bonus: The 'separate' function (easier splitting) ---")
print(tidy_data %>% select(Dept, ID, Mfg_Year))

