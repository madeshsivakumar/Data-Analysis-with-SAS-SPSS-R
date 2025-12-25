print("Name: S090 madesh")

data <- read_csv("R/insurance.csv")

data$sex <- as.factor(data$sex)
data$smoker <- as.factor(data$smoker)

anova_result <- aov(charges ~ sex * smoker, data = data)

summary(anova_result)

head(data)

