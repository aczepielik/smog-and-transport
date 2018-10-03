#!/bin/bash

curl 'http://monitoring.krakow.pios.gov.pl/dane-pomiarowe/pobierz' --data 'query={"measType":"Auto","viewType":"Parameter","dateRange":"Day","date":"DATA","viewTypeEntityId":"pm10","channels":[46,1747,1921,1914,1752,148,1723,57]}' -o data-files/pm/DATA.json | tee -a log.txt

