library(shiny)

shinyServer(function(input, output) {
  USArrests$Murdersp <- ifelse(USArrests$Murder - 7 > 0, USArrests$Murder - 7, 0)
  model1 <- lm(Assault ~ Murder, data = USArrests)
  model2 <- lm(Assault ~ Murder + Murdersp, data = USArrests)
  
  model1pred <- reactive({
    MRInput <- input$sliderMR
    predict(model1, newdata = data.frame(Murder = MRInput))
    
  })
  
  model2pred <- reactive({
    MRInput <- input$sliderMR
    predict(model2, newdata = 
              data.frame(Murder = MRInput,
                         Murdersp = ifelse(MRInput - 7 > 0,
                                           MRInput - 7, 0)))
  })
  
  output$distPlot <- renderPlot({
    MRInput <- input$sliderMR
    
    plot(USArrests$Murder, USArrests$Assault, 
         ylab="Assault Rate (per 100,000)", xlab="Murder Rate (per 100,000)")
    if(input$showmodel1){
      abline(model1, col="gold", lwd=2)
    }
    if(input$showmodel2){
      model2lines <- predict(model2, newdata = data.frame(
        Murder = 5:20, Murdersp = ifelse(5:20 - 7 > 0, 5:20 - 7, 0)
      ))
      lines(5:20, model2lines, col="black", lwd=2)
    }
      points(MRInput, model1pred(), col="gold", pch=16, cex=2)
      points(MRInput, model2pred(), col="black", pch=16, cex=2)
    
    })
  
  output$pred1 <- renderText({
    model1pred()
  })
  
  output$pred2 <- renderText({
    model2pred()
  })
})