library(shiny)

x <- precip
ht <- hist(x)

# names(par()$family)
# names(pdfFonts())
# apropos("fonts")

# font     The font "face" (1=plain, 2=bold, 3=italic, 4=bold-italic)

# text(1, 1, "Works just like it does now", font=2)
# text(1, 1, "Same effect as above", font=list(face="italic"))
# text(1, 1, "Same effect as above", font=list(face=2))
# text(1, 1, "Change the font just for this text",
#      font=list(family="Helvetica", face="bold-italic"))
# text(1:4, 1:4, paste("Font face", 1:4, "for this text"),
#      font=list(family="Courier New", face=1:4))

shinyServer(
    function(input, output){
        output$hist.reactive <- renderPlot({
#             par(family=input$fml)
#             par(font=input$fnt)
#             par(font=3)
            plot(ht,
                 family=input$fml,
#                  family="Helvetica",
                 col="#FF9200",
                 main=NULL,
                 ylab="Frequência absoluta",
                 xlab="Precipitação",
#                  ann=FALSE,
axes=FALSE)
#             axis(side=1, font=input$fnt)
        })
    })
