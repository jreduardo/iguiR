# scp -r hist_* iguir@200.17.213.89:/home/iguir/ShinyApps

# setwd("~/ShinyApps/list")
url <- "http://200.17.213.89:3838" # insert your url,     example: http://200.17.213.89:3838
user <- Sys.info()["user"]

directory <- list.dirs(path = "../", full.names=FALSE, recursive=FALSE)
dontshow <- c("log", "list")
directory <- setdiff(directory, dontshow)

url.list <- lapply(directory,
                   function(x){
                       do.call(tags$a,
                               c(list(
                                   href=paste(url, user, x, sep="/"),
                                   target="_blank"),
                                 x))
                   })

css <- ifelse(Sys.info()["nodename"]=="academia",
              yes="../palatino.css",
              no="/home/walmes/Dropbox/shiny/palatino.css")

shinyUI(fluidPage(
    includeCSS(css),
    fluidRow(
        headerPanel("Aplicações em Shiny do grupo IguiR"),
        p("Material desenvolvido para o curso de interfaces gráficas com o R durante a 60 RBRAS em Presidente Prudente, SP."),
        hr(),
        h4("Exemplos básicos (toy examples)"),
        tags$ol(lapply(url.list, tags$li)),
        h4("Exemplos intermediários"),
        h4("Exemplos avançados"),
        hr()
    )
))
