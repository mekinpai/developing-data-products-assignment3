#
# This is the server logic of a Shiny web application.
# It will get the input from the UI and perform data manipulatiion and extraction.
# After that, it will plot the data points into an interactive map using leaflet.
#

## load the required libraries
library(shiny)
library(leaflet)

## Get the location data
if(!file.exists("th_postal_codes.csv")) {
    fileUrl <- "https://www.aggdata.com/download_sample.php?file=th_postal_codes.csv"
    download.file(fileUrl, destfile ="th_postal_codes.csv", method = "curl")
}
initial_location_data <- read.csv(file='th_postal_codes.csv', header =T)
initial_location_data$place <- paste(initial_location_data$Postal.Code
                                     ,initial_location_data$Place.Name, sep=" : ")

# Define server logic required to draw a location map
shinyServer(function(input, output, session) {
    
    
    ## reactive function to capture the changes in the state and place input boxes
    location_data <- reactive({
        
        if(input$place == "All Places") { ## when the users select the state they are interested in
            loc <- subset(initial_location_data, State == input$state)
            ## update the list of places in the interested state
            updateSelectInput(session,"place",choices=c("All Places",unique(loc$place))
                              ,selected = "All Places")
        } else {
            ## when the users select the place they are interested in
            loc <- subset(initial_location_data, place == input$place)
            ## when the user changes the state again, we need to refresh the list and the data
            if(input$state != loc$State){
                updateSelectInput(session,"place",choices=c("All Places",unique(loc$place))
                                  ,selected = "All Places") 
            }
        }
        loc
    })
    
    ## reactive function to capture user option to cluster the points in the map
    location_plot <- reactive({
        if(input$cluster){
            location_data() %>%
                leaflet() %>% 
                addTiles() %>%
                addMarkers(clusterOptions = markerClusterOptions()
                           , popup = location_data()$place)
        }else{
            location_data() %>%
                leaflet() %>% 
                addTiles() %>%
                addMarkers(popup = location_data()$place)
        }
    })
    
    ## plot the location map
    output$mapPlot <- renderLeaflet({
        location_plot()
    })
    
    
})
