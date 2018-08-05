Developing Data Products - Week 4 Assignment
========================================================
author: Mekin Lertanuntasuk
date: August 5th, 2018
autosize: true

Overview
========================================================

This project is part of the developing data products course on Coursera.org.

The aims of the project are to:
- Create an interactive Shiny application that visualizes the locations in Thailand based on user's inputs
- Create a pitch presentation about the Shiny application using RStudio Presenter.

All of the codes related with the project can be found at
<https://github.com/mekinpai/developing-data-products-assignment3>

Data
========================================================

We are using the free location data from <https://www.aggdata.com/> which contains the latitude and longitude information for all 770 postal codes in Thailand.It also contains the State and Place name for each postal code.




```r
str(location_data)
```

```
'data.frame':	770 obs. of  5 variables:
 $ Postal.Code: int  10100 10110 10120 10140 10150 10160 10170 10200 10210 10220 ...
 $ Place.Name : chr  "Samphanthawong" "Wattana" "Bang Kholame" "Thung Khru" ...
 $ State      : chr  "Bangkok" "Bangkok" "Bangkok" "Bangkok" ...
 $ Latitude   : num  13.7 13.7 13.7 13.7 13.7 ...
 $ Longitude  : num  100 100 100 100 100 ...
```

Shiny application - Leaflet Package
========================================================

The shiny application makes use of the leaflet package in visualizing the location data on Map. 

Using only Leaflet package, users wouldn't have the ability to filter for only the state/place they are interested in


<iframe src="map_leaflet.html" style="position:absolute;height:70%;width:100%"></iframe>

Shiny application
========================================================

The Shiny application built helps solve the problem. It can be found [here](https://mekinpaii.shinyapps.io/developing-data-products-assignment3/)

<img src="Assignment4-figure/Shiny Example.png" style="position:absolute;height:90%;width:100%"></img>

