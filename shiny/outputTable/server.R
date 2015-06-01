require(shiny)

shinyServer(
    function(input, output){
        output$mtcarsTable <- renderDataTable({
            mtcars[,input$variables]
        },
        options=list(orderClasses=TRUE))
    })

