library(shiny)

shinyUI(
    fluidPage(
        titlePanel("Seja rápido!"),
        sidebarLayout(
            sidebarPanel(
                h5("Qual o resultado da soma?"),
                textOutput("expr"),
                uiOutput("uiRadio"),
                actionButton(inputId="goButton", label="Novo!"),
                hr(),
                actionButton(inputId="goResults", label="Resultados!")
            ),
            mainPanel(
                verbatimTextOutput("result"),
                plotOutput("plotRes")
            )
        )
    )
)
