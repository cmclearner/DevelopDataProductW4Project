
library(shiny)

shinyUI(fluidPage(
  
  
  titlePanel("Predict Assault Rate from Murder Rate in US, 1973"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("sliderMR", "Murder Rate:", 0, 20, value=7),
      checkboxInput("showmodel1", "Show/Hide Model 1", value=TRUE),
      checkboxInput("showmodel2", "Show/Hide Model 2", value=TRUE)
    ),
    
    mainPanel(
      plotOutput("distPlot"),
      h3("Predict Assault Rate from Model 1"),
      textOutput("pred1"),
      h3("Predict Assault Rate from Model 2"),
      textOutput("pred2")
    )
  )
))