# Load the dplyr package
library(dplyr)

# Load your dataset
students <- read.csv("/mnt/data/StudentsPerformance - StudentsPerformance.csv")

# Example 1: Sort by math.score (ascending)
students_sorted_math <- students |>
  arrange(math.score)

head(students_sorted_math, 5)

# Example 2: Sort by reading.score (descending)
students_sorted_reading_desc <- students |>
  arrange(desc(reading.score))

head(students_sorted_reading_desc, 5)

# Example 3: Sorting by Two Variables
# Primary: gender (alphabetical: female then male)
# Secondary: writing.score (descending)
students_sorted_gender_writing <- students |>
  arrange(gender, desc(writing.score))

head(students_sorted_gender_writing, 10)

# Example 4: Filter + Sort
# Filter students with high math scores (>90), then sort by writing.score (ascending)
high_math_sorted <- students |>
  filter(math.score > 90) |>
  arrange(writing.score)

cat("Top 5 high math scorers with lowest writing scores:\n")
print(high_math_sorted |> select(gender, math.score, writing.score) |> head(5))
