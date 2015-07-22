##=============================================================================
## Interactive Graphical User Interfaces with R
## RBRAS/SEAGRO 2015
##
##=============================================================================

##=============================================================================
## rgl
require(rgl)

##--------------------------------------------
## Exemplo PDF

## Diagrama de dispersão.
with(rock, plot(x=area, y=peri))           ## graphics
with(rock, plot3d(x=area, y=peri, z=perm)) ## rgl


## Superfície.
fun <- function(x, y){
    sin(sqrt(x^2+y^2))/sqrt(x^2+y^2)
}

x <- y <- seq(-8, 8, by=0.25)
z <- outer(x, y, fun)

persp(x=x, y=y, z=z)   ## graphics
persp3d(x=x, y=y, z=z) ## rgl

##--------------------------------------------
## Exportação

## Não fechar a janela do openGL.
snapshot3d("fig3d-1.png")
rgl.postscript(filename="fig3d.pdf", fmt="pdf")
writeWebGL() ## exporta para webGL.

##--------------------------------------------
## Exemplo 2

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

## writeWebGL()

