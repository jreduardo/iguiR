require(shiny)

choi <- c("Poisson"="poisson",
          "Binomial"="binomial",
          "Beta"="beta",
          "Gamma"="gamma",
          "Normal"="normal")

shinyUI(
    fluidPage(
        titlePanel("Distribuições de probabilidade"),
        sidebarPanel(
            selectInput(inputId="dist",
                        label="Distribuição",
                        choices=choi),
            uiOutput("ui")
        ),
        mainPanel(
            plotOutput("plot")
        )
    )
)