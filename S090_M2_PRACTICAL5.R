library(dplyr)

df <- read_csv("R/employee_salary_dataset.csv")

head(df)
str(df)
summary(df)

df$salary <- as.numeric(as.character(df$salary))
df$performance_score <- as.numeric(as.character(df$performance_score))

df <- df %>% filter(!is.na(salary), !is.na(performance_score))

summary(df$performance_score)

quality_freq <- table(df$performance_score)
print(quality_freq)

quality_count <- df %>% count(performance_score)
print(quality_count)

quality_salary_crosstab <- table(
  df$performance_score,
  df$salary >= median(df$salary)
)
print(quality_salary_crosstab)

t.test(df$performance_score, mu = mean(df$performance_score))

df$Salary_Group <- ifelse(df$salary >= median(df$salary), "High", "Low")
df$Salary_Group <- factor(df$Salary_Group)

t.test(performance_score ~ Salary_Group, data = df)

set.seed(123)
df$performance_before <- df$performance_score + rnorm(
  nrow(df), mean = 0, sd = 0.5
)

t.test(df$performance_score, df$performance_before, paired = TRUE)

