library(dplyr)
library(readr)

# Load dataset
df <- read_csv("R/exams.csv")

# Rename math score as Marks (to keep logic similar)
df <- df %>% rename(Marks = `math score`)

# Summary statistics
print("Summary of Marks:")
summary(df$Marks)

# Descriptive statistics (base R alternative)
print("Descriptive statistics of Marks:")
mean(df$Marks)
sd(df$Marks)
min(df$Marks)
max(df$Marks)

# Frequency table: Test preparation course
prep_counts <- table(df$`test preparation course`)
print("Frequency Table: Test Preparation Course")
print(prep_counts)

# Data frame format
prep_df <- df %>% count(`test preparation course`)
print("Test Preparation Course Frequency (Data Frame Format)")
print(prep_df)

# Create Marks groups (Low / Medium / High)
df$Marks_Group <- cut(
  df$Marks,
  breaks = 3,
  labels = c("Low", "Medium", "High")
)

print("Cross Tabulation: Test Prep Course vs Marks Group")
cross_tab <- table(df$`test preparation course`, df$Marks_Group)
print(cross_tab)

# One-sample t-test: Is mean Marks different from 50?
print("One-sample t-test: Marks vs mu = 50")
t_test_one <- t.test(df$Marks, mu = 50)
print(t_test_one)

# Independent t-test: Marks by test preparation course
print("Independent t-test: Marks by Test Preparation Course")
t_test_two <- t.test(
  Marks ~ `test preparation course`,
  data = df
)
print(t_test_two)

# Paired t-test: Math vs Reading scores
print("Paired t-test: Math vs Reading Scores")
t_test_paired <- t.test(
  df$`math score`,
  df$`reading score`,
  paired = TRUE
)
print(t_test_paired)

