# Load necessary libraries (install once, not inside scripts usually)
# install.packages("lubridate")
# install.packages("dplyr")
library(lubridate)
library(dplyr)

# 1. SETUP: Create Sample Data
dates_df <- data.frame(
  Event_ID = 1:4,
  Date_String = c("2023-01-15", "2023-10-31", "2024-02-29", "2024-12-25"),
  stringsAsFactors = FALSE
)

# 2. PARSE AND EXTRACT
processed_data <- dates_df %>%
  mutate(
    # A. Parsing: Tell R this text is a date (Year-Month-Day)
    Actual_Date = ymd(Date_String),
    
    # B. Extraction Functions
    Year_Num     = year(Actual_Date),                              # Extract Year
    Month_Num    = month(Actual_Date),                             # Extract Month number (1-12)
    Month_Name   = month(Actual_Date, label = TRUE, abbr = TRUE),  # Jan, Feb, ...
    Day_Num      = day(Actual_Date),                               # Day of month (1-31)
    Weekday_Num  = wday(Actual_Date),                              # Day of week (1 = Sunday, 7 = Saturday)
    Weekday_Name = wday(Actual_Date, label = TRUE, abbr = FALSE),  # Full weekday name (Sunday, ...)
    Quarter      = quarter(Actual_Date),                           # Fiscal quarter (1-4)
    Day_of_Year  = yday(Actual_Date)                               # Day count in year (1-366)
  )

# Check for any parsing failures
if (any(is.na(processed_data$Actual_Date))) {
  warning("Some Date_String values failed to parse into Actual_Date. Check input values.")
}

print("--- Data with Extracted Date Components ---")
print(processed_data)

# 3. System Date : Handling "Now"
# Use explicit timezone if you want deterministic output, otherwise system timezone is used
current_time <- now(tzone = Sys.timezone())

print("--- Current Time Extraction ---")
print(paste("Current Year:", year(current_time)))
print(paste("Current Hour:", hour(current_time)))
print(paste("Current Minute:", minute(current_time)))
