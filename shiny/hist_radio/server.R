library(shiny)

x <- precip
ht <- hist(x)

shinyServer(
    function(input, output){
        output$hist.reactive <- renderPlot({
            plot(ht,
                 col=input$col,
                 main=NULL,
                 ylab="Frequência absoluta",
                 xlab="Precipitação")
        })
    })
