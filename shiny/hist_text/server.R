library(shiny)

x <- precip
ht <- hist(x)

shinyServer(
    function(input, output){
        output$hist.reactive <- renderPlot({
            plot(ht, col="#006666",
                 ylab="Frequência absoluta",
                 xlab="Precipitação",
                 main=input$main,
                 sub=input$sub)
        })
    })
