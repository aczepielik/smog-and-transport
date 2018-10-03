#!/usr/bin/env Rscript

message(paste0(as.character(Sys.time()), ': Start of data downloading \n ***'))

#Initialnizing script
script <- readr::read_lines('download-pm.sh')
temp_script <- script

# Parsing arguments
cmd_args <- commandArgs(trailingOnly = TRUE)
t <-  seq(as.Date(cmd_args[1]), as.Date(cmd_args[2]), by = 'day')

# Download-for-given-day function
download_json <- function(t){
  if(!('Date' %in% class(t))){
    stop('Input must be a Date')
  } else {
    char_t <- as.character(t, format = '%d.%m.%Y')
    temp_script[3] <- gsub(pattern = 'DATA', replacement = char_t, script[3])
    
    readr::write_lines(temp_script, 'download-pm.sh')
    
    system('./download-pm.sh')
    message(paste("\n Downloaded data from", as.character(t)))
    Sys.sleep(5)
  }}

# Download for all days
for(i in seq_along(t)) download_json(t[[i]])

message(paste(as.character(Sys.time()), 'Downloaded PM10 pollution data related to interval from', cmd_args[[1]], 'to', cmd_args[[2]], '\n \n'))

readr::write_lines(script, 'download-pm.sh')

