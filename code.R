library("openxlsx")
library("dplyr")
library("opencage")
file <- "data/WHO_AAP_database_May2016_v3web.xlsx"
data <- read.xlsx(file, sheet = 2, startRow = 3)
data <- tbl_df(data)
View(data)