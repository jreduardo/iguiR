require(shiny)

choi <- names(mtcars)

shinyUI(
    fluidPage(
        titlePanel("Tabela de dados mtcars"),
        sidebarPanel(
            checkboxGroupInput(inputId="variables",
                               label="Selecione as variáveis:",
                               choices=choi,
                               selected=choi[1:4])
        ),
        mainPanel(
            dataTableOutput("mtcarsTable")
        )
    )
)