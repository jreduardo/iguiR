require(shiny)
require(xtable)

shinyServer(
    function(input, output){
        output$summaryAov <- renderPrint({
            m0 <- lm(Fertility~1+.,
                     data=swiss[,c("Fertility", input$variables)])
            print(xtable(anova(m0)), type="html")
        })
    })
