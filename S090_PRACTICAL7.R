#7.  Selecting and dropping variables using select() in R. 
# ==============================================================================
# 1. IMPORT DATASET
# ==============================================================================
library(dplyr) # select() is part of the dplyr package

# Import the CSV file
housing <- read.csv("netflix_titles.csv")

print("--- Original Dataset (First 3 rows) ---")
print(head(housing, 3))

# ==============================================================================
# 2. SELECTING VARIABLES (Keeping Columns)
# ==============================================================================

# Method A: Select specific columns by name
# Scenario: We only want the Crime rate (crim), Rooms (rm), and Value (medv)
# (Mapped to Netflix: type, title, release_year)
selected_cols <- housing %>%
  select(type, title, release_year)

print("--- Selected Specific Columns ---")
print(head(selected_cols, 3))

# Method B: Select a range of adjacent columns
# Scenario: Select everything from 'crim' to 'nox'
# (Mapped to Netflix: type:title:rating)
range_cols <- housing %>%
  select(type:rating)

print("--- Selected Range of Columns ---")
print(head(range_cols, 3))

# Method C: Select using helper functions (e.g., starts_with)
# Scenario: Select columns that start with "r" (rm, rad)
# (Netflix columns starting with 'r' include: release_year, rating)
starts_with_r <- housing %>%
  select(starts_with("r"))

print("--- Selected columns starting with 'r' ---")
print(head(starts_with_r, 3))

# ==============================================================================
# 3. DROPPING VARIABLES (Removing Columns)
# ==============================================================================
# We use the minus sign (-) to remove variables

# Method A: Drop a single specific column
# Scenario: Remove the 'chas'
# (Mapped to Netflix: drop 'country')
dropped_one <- housing %>%
  select(-country)

print("--- Dataset with 'country' dropped ---")
print(names(dropped_one)) # Printing names to verify it's gone

# Method B: Drop multiple columns
# Scenario: Remove 'zn' and 'indus'
# (Mapped to Netflix: drop 'cast' and 'director')
dropped_multiple <- housing %>%
  select(-cast, -director)

print("--- Dataset with 'cast' and 'director' dropped ---")
print(names(dropped_multiple))

# Method C: Drop a range of columns
# Scenario: Remove everything from 'age' to 'tax'
# (Mapped to Netflix: duration ??? listed_in)
dropped_range <- housing %>%
  select(-(duration:listed_in))

print("--- Dataset with range 'duration' to 'listed_in' dropped ---")
print(names(dropped_range))
