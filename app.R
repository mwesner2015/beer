if("DT" %in% rownames(installed.packages()) == FALSE) {install.packages("DT")}
if("tidyr" %in% rownames(installed.packages()) == FALSE) {install.packages("tidyr")}
if("ggplot2" %in% rownames(installed.packages()) == FALSE) {install.packages("ggplot2")}
if("dplyr" %in% rownames(installed.packages()) == FALSE) {install.packages("dplyr")}
if("shiny" %in% rownames(installed.packages()) == FALSE) {install.packages("shiny")}
if("readr" %in% rownames(installed.packages()) == FALSE) {install.packages("readr")}

library(dplyr)
library(tidyr)
library(ggplot2)
library(DT)
library(shiny)
library(readr)



breweries <- read_csv("data/breweries.csv")
beers <- read_csv("data/beers.csv")

beers[is.na(beers)] = 0

clean_breweries = breweries %>%
  rename(brewery = name) %>%
  rename(brewery_id = X1) %>%
  mutate(brewery_id = brewery_id + 1)

clean_beer = beers %>%
  rename(beer = name)

beer = full_join(clean_breweries, clean_beer, by = 'brewery_id')
beer[[5]] = NULL
beer[[1]] = NULL
beer[["id"]] = NULL
beer = beer[!is.na(beer$brewery), ]

ui = fluidPage(
  navbarPage("Craft Beers", 
             tabPanel("Brewery finder",
                      titlePanel("Craft Beer in the US"),
                      
                      # Create a new Row in the UI for selectInputs
                      fluidRow(
                        column(4,
                               selectInput("brewery",
                                           "Choose a Brewery:",
                                           c("All",
                                             unique(as.character(beer$brewery)))),
                               selectInput("state",
                                           "Choose a State:",
                                           c("All",
                                             unique(as.character(beer$state)))),
                               selectInput("style",
                                           "Choose a Style:",
                                           c("All",
                                             unique(as.character(beer$style))))
                        
                               )
                      ),
                      # Create a new row for the table.
                      DT::dataTableOutput("table")
             ),
             
             tabPanel("Regression",
                      titlePanel("Linear Regression of abv and ibu"),
                      fluidRow(
                        column(7,
                          sidebarLayout(
                            sidebarPanel(
                              selectInput(inputId = "response", 
                                      label = "Choose a category", 
                                      choices = c("ibu", "ounces"))
                                    ),
                      mainPanel(
                        plotOutput("plot"),
                        verbatimTextOutput("analysis")
                      )
                    ) 
                  )   
             )     
             )
             )
)
server = function(input, output){
  # Filter data based on selections
  output$table = DT::renderDataTable(DT::datatable({
    data = beer
    if (input$brewery != "All") {
      data <- data[data$brewery == input$brewery,]}
    if (input$state != "All") {
      data <- data[data$state == input$state,]}
    if (input$style != "All") {
      data <- data[data$style == input$style,]}
    data
  }))
  
  output$plot = renderPlot(
    plot(abv ~ get(input$response), 
         xlab = input$response, ylab="abv", 
         data = beer)+
      abline(lm(abv~ get(input$response), data=beer))
  )
  output$analysis = renderPrint(
    summary(aov(abv ~ get(input$response) , data=beer))
  )
  
}
shinyApp(ui = ui, server = server)
