##=============================================================================
## Interactive Graphical User Interfaces with R
## RBRAS/SEAGRO 2015
##
##=============================================================================

##=============================================================================
## gWidgets
require(gWidgets)
require(gWidgetstcltk)
options(guiToolkit = "tcltk")

##--------------------------------------------
## Exemplo apresentação (gslider)

x <- precip
a <- extendrange(x, f=0.05)

hist.reactive <- function(...){
    bks <- seq(a[1], a[2], length.out=svalue(nclass)+1)
    hist(x, breaks=bks)
}

w <- gwindow("Histograma", width = 300, height = 300)
g <- gframe(text="Escolha o número de classes:", container=w)
nclass <- gslider(from=1, to=30, by=1, value=10,
                  container=g, handler=hist.reactive)


##--------------------------------------------
## Exemplo adicional (gradio)

col <- c(Turquesa="#00CC99",
         Azul="#0066FF",
         Rosa="#FF3399",
         Laranja="#FF6600",
         Roxo="#660066",
         "Verde limão"="#99FF33")

hist.reactive <- function(...){
    bks <- seq(a[1], a[2], length.out=svalue(nclass)+1)
    hist(x, breaks=bks,
         col = col[svalue(color)])
}

w <- gwindow("Histograma", width = 300, height = 300)
g <- gframe(text="Escolha o número de classes:", container=w)
nclass <- gslider(from=1, to=30, by=1, value=10,
                  container=g, handler=hist.reactive)
color <- gradio(items = names(col),
                container = w, handler = hist.reactive)

##--------------------------------------------
## Exemplos avançados

source("https://raw.githubusercontent.com/JrEduardo/iguiR/master/gWidgets/probDistributions.R")
source("https://raw.githubusercontent.com/JrEduardo/iguiR/master/gWidgets/poderNormal.R")
source("https://raw.githubusercontent.com/JrEduardo/iguiR/master/gWidgets/testHipFlipCoin.R")

