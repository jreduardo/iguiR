library(shiny)

x <- precip
ht <- hist(x)

shinyServer(
    function(input, output){
        output$hist.reactive <- renderPlot({
            f <- as.integer(input$fnt)
            plot(ht,
                 family=input$fml,
                 font=as.integer(input$fnt),
                 col="#FF9200",
                 main=NULL,
                 ylab="Frequência absoluta",
                 xlab="Precipitação")
        })
    })
