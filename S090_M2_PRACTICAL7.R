print("Name: S095 madesh")

library(readr)

data <- read_csv("R/StudentsPerformance.csv")

data$`parental level of education` <- 
  as.factor(data$`parental level of education`)

anova_result <- aov(
  `math score` ~ `parental level of education`,
  data = data
)

summary(anova_result)
