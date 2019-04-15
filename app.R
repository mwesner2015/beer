if("DT" %in% rownames(installed.packages()) == FALSE) {install.packages("DT")}
if("tidyr" %in% rownames(installed.packages()) == FALSE) {install.packages("tidyr")}
if("ggplot2" %in% rownames(installed.packages()) == FALSE) {install.packages("ggplot2")}
if("dplyr" %in% rownames(installed.packages()) == FALSE) {install.packages("dplyr")}
if("shiny" %in% rownames(installed.packages()) == FALSE) {install.packages("shiny")}
if("readr" %in% rownames(installed.packages()) == FALSE) {install.packages("readr")}
if("reshape" %in% rownames(installed.packages()) == FALSE) {install.packages("reshape")}
library(dplyr)
library(tidyr)
library(ggplot2)
library(DT)
library(shiny)
library(readr)
library(reshape)

breweries <- read_csv("data/breweries.csv")
beers <- read_csv("data/beers.csv")

beers = select(beers,-X1)
beers[is.na(beers)] <- 0


beers[is.na(beers)] <- 0

clean_breweries = breweries %>%
  rename(brewery = name) %>%
  rename(brewery_id = X1) %>%
  mutate(brewery_id = brewery_id + 1)

clean_beer = beers %>%
  rename(beer = name)

beer = full_join(clean_breweries, clean_beer, by = 'brewery_id')

ui = fluidPage(
  titlePanel("Craft Beer in the US"),
  
  # Create a new Row in the UI for selectInputs
  fluidRow(
    column(4,
           selectInput("brewery",
                       "Choose a Brewery:",
                       c("All",
                         unique(as.character(beer$brewery))))
    )
  ),
  # Create a new row for the table.
  DT::dataTableOutput("table")
)

server = function(input, output) {
  
  # Filter data based on selections
  output$table <- DT::renderDataTable(DT::datatable({
    data = beer
    if (input$brewery != "All") {
      data <- data[data$brewery == input$brewery,]
    }
    data
  }))
  
}
shinyApp(ui = ui, server = server)
