#
# This is the user-interface definition of a Shiny web application.
# This application will show the locations of each postal code in Thailand based on user's input.
# It allows the users to specify the interested state as well as the interested postal code (place).
# Users also have an option to cluster the data points on map into group.
# 
# Once the users specify the state they are interested in, the list of the postal code 
# will be changed dynamically.

## load the required libraries
library(shiny)
library(leaflet)

## load the location data
if(!file.exists("th_postal_codes.csv")) {
    fileUrl <- "https://www.aggdata.com/download_sample.php?file=th_postal_codes.csv"
    download.file(fileUrl, destfile ="th_postal_codes.csv", method = "curl")
}
location_data <- read.csv(file='th_postal_codes.csv', header =T, stringsAsFactors = F)
location_data$place <- paste(location_data$Postal.Code
                            ,location_data$Place.Name, sep=" : ")

## make the list of states and places
state_list <- c(unique(location_data$State))
place_list <- c("All Places",unique(location_data$place))

# Define UI for application that shows a location map
shinyUI(fluidPage(
    
    titlePanel("Locations In Thailand"),
    
    # Sidebar with two select inputs for state and place and another checkbox for clustering points option
    sidebarLayout(
        sidebarPanel(
            selectInput(
                "state",
                label = h3("Select interested state"),
                choices = state_list,
                selected = "Bangkok"
            ),
            selectInput(
                "place",
                label = h3("Select interested place"),
                choices = place_list,
                selected = "All Places"
            ),
            checkboxInput(
                "cluster",
                "Cluster Points",
                value=T
            )
        ),
        # Show a location map based on the select input
        mainPanel(
            leafletOutput("mapPlot", width = "100%", height = "800px")
        )
    )
))
