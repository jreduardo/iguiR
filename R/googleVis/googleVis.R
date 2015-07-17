##=============================================================================
## Interactive Graphical User Interfaces with R
## RBRAS/SEAGRO 2015
##
##=============================================================================

##=============================================================================
## googleVis
library(googleVis)

##--------------------------------------------
## Exemplo apresentação

x <- as.data.frame(precip)

graf <- gvisHistogram(x,
                      option = list(
                          title = "Precipitação",
                          vAxis = "{title:'Frequência'}",
                          hAxis = "{title:'Precipitação'}",
                          colors = "['red']",
                          legend = "none",
                          hAxis.gridlines.count = 10))

##--------------------------------------------
## Exportação

print(graf)

plot(graf)

cat(graf$html$chart, file="graf.html")
