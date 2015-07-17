library(shiny)

col <- c(Turquesa="#00CC99",
         Azul="#0066FF",
         Rosa="#FF3399",
         Laranja="#FF6600",
         Roxo="#660066",
         "Verde limão"="#99FF33")

shinyUI(
    fluidPage(
            sidebarPanel(
                sliderInput(inputId="nclass",
                            label="Número de classes:",
                            min=1, max=30, step=1, value=10),
                radioButtons(inputId = "color", label = "Escolha uma cor",
                             choices = col)
            ),
            mainPanel(
                plotOutput("hist.reactive")
            )
    )
)
