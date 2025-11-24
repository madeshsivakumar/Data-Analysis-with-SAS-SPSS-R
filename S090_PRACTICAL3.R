# Install necessary packages (run only once)
install.packages(c("readr", "psych"))

# Load libraries
library(readr)
library(psych)

# Load the dataset - updated path to the uploaded file
my_data <- read_csv("My Web Sites/insurance.csv")

# View the first few rows
head(my_data)

# View the last few rows
tail(my_data)

# Get dataset dimensions
dim(my_data)
cat("Dimensions (Rows, Columns): ", dim(my_data), "\n")

# Get structure
str(my_data)

# Summary statistics
summary(my_data)

# Column names
names(my_data)
cat("Column Names: ", names(my_data), "\n")

# Detailed descriptive statistics using psych
describe(my_data)

