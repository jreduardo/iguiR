library(shiny)

x <- precip
ht <- hist(x)

shinyServer(
    function(input, output){
        output$hist.reactive <- renderPlot({
            m <- input$mar
            par(mar=c(m, m, 1, 1))
            plot(ht, col="#660066",
                 main=NULL, axes=FALSE, ann=FALSE,
                 xaxt="n", yaxt="n")
            box(bty="L")
            axis(side=1, cex.axis=input$cexaxis)
            axis(side=2, cex.axis=input$cexaxis)
            title(ylab="Frequência absoluta",
                  xlab="Precipitação",
                  line=input$line)
        })
    })
