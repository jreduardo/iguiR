library(shiny)

library(compoisson)

shinyServer(
    function(input, output){
        
        x <- reactive({
            rnorm(n = input$n, mean = input$mu, sd = sqrt(input$va))
        })
      
        output$graf1 <- renderPlot({
            plot(x())
        })
      
        output$graf2 <- renderPlot({
            hist(x())
        })
        
        output$graf3 <- renderPlot({
            qqnorm(x())
        })
    })
