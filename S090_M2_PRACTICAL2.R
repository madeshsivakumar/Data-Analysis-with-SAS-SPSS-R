library(dplyr)

df <- read_csv("R/random_stock_market_dataset.csv")

# Frequency tables
open_counts <- table(df$Open)
print("Frequency Table: Open Prices")
print(open_counts)

volume_counts <- table(df$Volume)
print("Frequency Table: Volume")
print(volume_counts)

close_counts <- table(df$Close)
print("Frequency Table: Close Prices")
print(close_counts)

# Data frame format counts
open_df <- df %>% count(Open)
print("Open Price Frequency (Data Frame Format)")
print(open_df)

volume_df <- df %>% count(Volume)
print("Volume Frequency (Data Frame Format)")
print(volume_df)

close_df <- df %>% count(Close)
print("Close Price Frequency (Data Frame Format)")
print(close_df)

# Proportion tables
open_prop <- prop.table(open_counts)
print("Proportion Table: Open Prices")
print(open_prop)

volume_prop <- prop.table(volume_counts)
print("Proportion Table: Volume")
print(volume_prop)

close_prop <- prop.table(close_counts)
print("Proportion Table: Close Prices")
print(close_prop)

