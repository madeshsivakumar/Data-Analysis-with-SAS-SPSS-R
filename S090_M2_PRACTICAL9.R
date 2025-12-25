print("Name: S095 MADESH")

data <- read_csv("R/CategoricalDataset.csv")

table_data <- table(data$`Team 1_India`, data$`Team 2_Pakistan`)

chisq_result <- chisq.test(table_data)
chisq_result

head(data)

