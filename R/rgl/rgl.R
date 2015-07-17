##=============================================================================
## Interactive Graphical User Interfaces with R
## RBRAS/SEAGRO 2015
##
##=============================================================================

##=============================================================================
## rgl
library(rgl)

##--------------------------------------------
## Exemplo 

dnorm2d <- function(x, y){
     mvtnorm::dmvnorm(x = cbind(x, y), sigma = diag(2))
}

X <- seq(-4, 4, length = 30)
Y <- seq(-4, 4, length = 30)
fxy <- outer(X, Y, dnorm2d)

plot3d(X, Y, fxy, type = "l")

persp3d(X, Y, fxy)


##--------------------------------------------
## Exportação

snapshot3d("fig3d.png")

rgl.postscript("fig3d.pdf", "pdf")

movie3d(spin3d(), duration = 5, dir=getwd())

writeWebGL()

