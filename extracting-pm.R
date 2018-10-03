#!/usr/bin/env Rscript

library(jsonlite)
library(dplyr)
library(purrr)

day_files <- list.files('data-files/pm/')

station_names <- c('Krasińskiego', 'Piastów',
                   'Wadów', 'Telimeny','Złoty_Róg',
                   'Kurdwanów', 'Dietla', 'Nowa_Huta')  

# Place to save data
hourly <- data.frame(matrix(ncol = 9, nrow = 0))

hourly[, 1] <- as.POSIXct(hourly[, 1])
for(i in 2:9) hourly[, i] <- as.numeric(hourly[, i])
names(hourly) <- c('time', station_names)


daily <- data.frame(matrix(ncol = 9, nrow = 0))

daily[, 1] <- as.Date(daily[, 1])
for(i in 2:9) daily[, i] <- as.numeric(daily[, i])
names(daily) <- c('time', station_names)


# functions to extract hourly measurements

extract <- function(station, file_name){
  if(is_empty(station)){
    day_name <- gsub('.json', '', file_name) %>% as.Date(format = '%d.%m.%Y')
    data.frame(time = seq(as.POSIXct(day_name) - 2*3600, as.POSIXct(day_name) + 23*3600, by = 'hour'),
               pm = rep(NA, 26) %>% as.numeric())
  } else {
    data.frame(
      time = station[, 1] %>% as.numeric() %>% as.POSIXct(origin = '1970-01-01'),
      pm = station[, 2] %>% as.numeric()
    )
  }
}

add_Hourly <- function(day_record, file_name){
  df <- map(day_record$data, extract, file_name)
  df <- Reduce(function(...) full_join(..., by = 'time'), df)
  names(df) <- c('time', station_names)
  df
}


#function to extract averaged data

add_Daily <- function(day_record, file_name){
  tstamp <- list(gsub('.json', '', file_name) %>% as.Date(format = '%d.%m.%Y'))
  
  df <- day_record$avg$avg %>% as.numeric() %>% append(tstamp, 0) %>% data.frame()
  names(df) <- c('time', station_names)
  
  return(df)
}

## Making data sets
add_Record <- function(file_name){
  day_record <- fromJSON(paste0('data-files/pm/', file_name)) %>% `$`('data') %>% `$`('series')

  daily <<- union(daily, add_Daily(day_record, file_name))
  hourly <<-  union(hourly, add_Hourly(day_record, file_name))
}

walk(day_files, add_Record)
daily <- arrange(daily, time)
hourly <- arrange(hourly, time)


save(daily, file = 'daily_records.Rdata')
save(hourly, file = 'hourly_records.Rdata')