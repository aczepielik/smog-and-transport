---
title: Smog and Transport
author: Adam Czepielik
date: '2018-10-03'
---

This repository contains files (their copies, to be accurate) related to my blog post [*Smog and transport resolution in Kraków*](https://www.aczepielik.github.io/en/smog). The post is based on my assignment paper, which was actually my first analytical project I did so it contains bunch of hard-coded ellements

 1. What can I find here?
	
	- report.Rmd is a copy of the blog post mentioned above, to put all things in one place
	- download-pm.sh, scrapping-pm.R and extracting-pm.R are scripts for downloading data about PM 10 pollution during given time period
	- *.Rdata files are data frames made with scripts mentioned above, which I use in analysis.
	- data-files/ folder contains raw *json files, just downloaded, used to make data frames.
	- Attachment 1.pdf is a letter I've received from the City Hall as a response to my request for data. It contains informations about free transport anoucements. It also contains errors.

 2. What is missing?

	Meteorological data. I downloaded them from the Institute of Meteorology and Water Management's website, but I am not entitled to redistribute them. If you are interested in replication of this analysis, please use this [link](https://dane.imgw.pl/data/dane_pomiarowo_obserwacyjne/dane_meteorologiczne/dobowe/klimat/) and look for k_d_t files in *.zip archives. Don't hesitate to contact me if you need further instructions, especially if you don't speak Polish.

 3. How to use scripts?
Place them in the same catalogue. 
Prepare catalogue *data-files* and *pm* inside it.
Run scrapping-pm.R from shell with two arguments: first day of a period you are interested in, last day of a period you are interestd in. Specify dates in 2018-10-03 format.
Run extracting-pm.R without any arguments.
