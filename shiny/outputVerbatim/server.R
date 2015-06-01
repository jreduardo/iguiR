require(shiny)

shinyServer(
    function(input, output){
        output$summaryLm <- renderPrint({
            m0 <- lm(Fertility~1+.,
                     data=swiss[,c("Fertility", input$variables)])
            summary(m0)
        })
    })
