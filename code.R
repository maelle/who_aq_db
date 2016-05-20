library("openxlsx")
library("dplyr")
library("tidyr")
library("opencage")
library("countrycode")
library("purrr")
file <- "data/WHO_AAP_database_May2016_v3web.xlsx"
data <- read.xlsx(file, sheet = 2, startRow = 3)
data <- tbl_df(data)

##################################################################
# Transform country code
##################################################################

data <- mutate(data,
               countrycode = countrycode(iso3,"iso3c","iso2c"))
data <- separate(data, temporal_coverage,
                 c("PM10_temporal_coverage",
                   "PM25_temporal_coverage"), sep =";")

##################################################################
# Transform temporal coverage
##################################################################
data <- mutate(data,
               PM10_temporal_coverage = gsub("PM10:", "", PM10_temporal_coverage),
               PM25_temporal_coverage = gsub("PM2\\.5:", "", PM25_temporal_coverage))

data <- mutate(data, 
               PM10_annually_rep = grepl("annually re", PM10_temporal_coverage), 
               PM25_annually_rep = grepl("annually re", PM25_temporal_coverage))
data <- mutate(data, 
               PM10_more_75 = grepl(">75", PM10_temporal_coverage), 
               PM25_more_75 = grepl(">75", PM25_temporal_coverage))

##################################################################
# Transform stations information
##################################################################
# do by grepl
# information not well organized
sum(grepl(" urban", data$PM25_stations))
sum(grepl("pre-urban", data$PM25_stations))
# suburban
# industrial
# traffic
# residential
# commercial
# rural

##################################################################
# Geocoding
##################################################################
data <- mutate(data,
               latitude = 100,
               longitude = 100)
# take the first one, shouldn't be far away and ok at this scale!
for(i in 1:nrow(data)){
  print(i)
  results <- opencage_forward(placename = data$City[i],
                              country = data$countrycode[i])$results
  if(!is.null(results)){
    data$latitude[i] <- results$geometry.lat[1]
    data$longitude[i] <- results$geometry.lng[1]
  }
  
}
save(data, file = "who_aq_data.RData")
##################################################################
# Visualization
##################################################################
# 2 maps, 1 for PM10 and 1 for PM25
# for cities with *measured* data
# colour depending on year of data

