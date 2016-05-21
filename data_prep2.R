# add per hand the missing long and lat
library("dplyr")
library("opencage")
load("who_aq_data.RData")
which(data$City == "Nabih Saleh")
data[106, "latitude"] <- 26.18238
data[106, "longitude"] <- 50.58430

which(data$City == "Ras Hayan")
data[107, "latitude"] <- 26.0313874
data[107, "longitude"] <- 50.6094348

which(data$City == "Nelson Airshed A")
data[1822, "latitude"] <- -41.09941
data[1822, "longitude"] <- 173.4289

which(data$City == "New York-Northern New Jersey-Long Island, NY-NJ-PA")
data[2829, "latitude"] <- -73.98658
data[2829, "longitude"] <- 40.7306

which(data$City == "Ceasaria")
data[1400, "latitude"] <- 32.49581
data[1400, "longitude"] <- 34.88964

which(data$City == "Karmey Yossef")
data[1410, "latitude"] <- 31.84543
data[1410, "longitude"] <- 34.92073

which(data$City == "Kiryat Malahi")
data[1415, "latitude"] <- 31.73147
data[1415, "longitude"] <- 34.74348

filter(data, latitude == 100)

readr::write_csv(data, path = "WHO_AQ_data_geocoded.csv")
save(data, file = "who_aq_data2.RData")