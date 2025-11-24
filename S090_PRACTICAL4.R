install.packages("dplyr")

library(dplyr)
library(readr)  # For efficient reading

# Load your Housing.csv file
housing <- read_csv("My Web Sites/Housing.csv")

# Quick look at the data structure
head(housing)

# ---------------------------------------------------------
# Method 1: Using subset() - Base R
# ---------------------------------------------------------

# Example 1: Single Condition
# Filter for houses where price is greater than 10 million

high_price_subset <- subset(housing, price > 10000000)

cat("Number of high-price houses (price > 10M):", nrow(high_price_subset), "\n")
summary(high_price_subset$price)

# Example 2: Multiple Conditions (AND)
# Houses with price > 10M AND area > 8000

large_highprice_subset <- subset(housing, price > 10000000 & area > 8000)

cat("Number of large, high-price houses:", nrow(large_highprice_subset), "\n")
head(large_highprice_subset)

# Example 3: Multiple Conditions (OR)
# Houses that have a guest room OR have air conditioning

special_houses_subset <- subset(housing, guestroom == "yes" | airconditioning == "yes")

cat("Number of special houses (guestroom OR AC):", nrow(special_houses_subset), "\n")
head(special_houses_subset)

# ---------------------------------------------------------
# Method 2: Using dplyr::filter()
# ---------------------------------------------------------

# Example 1: Single Condition (Using Pipe Operator)
# Filter for houses with more than 3 bathrooms

many_bathrooms <- housing |>
  filter(bathrooms > 3)

cat("Number of houses with > 3 bathrooms:", nrow(many_bathrooms), "\n")
summary(many_bathrooms$bathrooms)

# Example 2: Multiple Conditions (Comma-separated = AND)
# Houses on the main road AND with basement

mainroad_basement <- housing |>
  filter(mainroad == "yes", basement == "yes")

cat("Houses on main road with basement:", nrow(mainroad_basement), "\n")
head(mainroad_basement)

# Example 3: Using %in% for values in a set
# Houses with furnishing status "furnished" OR "semi-furnished"

furnished_subset <- housing |>
  filter(furnishingstatus %in% c("furnished", "semi-furnished"))

cat("Number of furnished or semi-furnished houses:", nrow(furnished_subset), "\n")
table(furnished_subset$furnishingstatus)

