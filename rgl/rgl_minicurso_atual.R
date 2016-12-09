##--------------------------------------------------------------------------------------------------
## Requerindo pacote rgl
require(rgl)

##--------------------------------------------------------------------------------------------------
## Divide a janela gráfica: gráfico 3d + gráfico 2D
x <- rnorm(100)
y <- rnorm(100)
z <- rnorm(100)
open3d()
par3d(windowRect = c(100, 100, 612, 612))
Sys.sleep(0.1)
parent <- currentSubscene3d()
mfrow3d(2, 2)
plot3d(x, y, z)
next3d(reuse = FALSE)
bgplot3d(plot(y, z))
next3d(reuse = FALSE)
bgplot3d(plot(x, z))
next3d(reuse = FALSE)
legend3d("center", c("Pontos 2D", "Pontos 3D"), pch = c(1, 16))
useSubscene3d(parent)



##--------------------------------------------------------------------------------------------------
## Gráfico de perspectiva + grids
x <- 1:10
y <- 1:10
z <- matrix(outer(x - 5, y - 5) + rnorm(100), 10, 10)

open3d()
persp3d(x, y, z, col = "red", alpha = 0.7, aspect = c(1, 1, 0.5))
grid3d(c("x", "y", "z"))


##--------------------------------------------------------------------------------------------------
## Gráfico com os três eixos com as interfaces rgl e 3d
x <- c(0, 1, 0, 0)
y <- c(0, 0, 1, 0)
z <- c(0, 0, 0, 1)
labels <- c("Origem", "X", "Y", "Z")
i <- c(1, 2, 1, 3, 1, 4)

# Interface rgl
rgl.open()
rgl.texts(x, y, z, labels)
rgl.texts(1, 1, 1, "Coordenadas rgl")
rgl.lines(x[i], y[i], z[i])

# Interface 3D
open3d()
text3d(x, y, z, labels)
text3d(1, 1, 1, "Coordenadas 3D")
segments3d(x[i], y[i], z[i])

##--------------------------------------------------------------------------------------------------
## Plot de pontos + adição de eixos xyz
open3d()
x <- sort(rnorm(1000))
y <- rnorm(1000)
z <- rnorm(1000) + atan2(x,y)
plot3d(x, y, z, col=rainbow(1000))
abclines3d(0, 0, 0, a = diag(3), col = "black")


##--------------------------------------------------------------------------------------------------
## Mudando aspectos dos pontos
p <- plot3d(rnorm(100), rnorm(100), rnorm(100), type = "s", col = "red")
rgl.attrib.count(p["data"], "vertices")
rgl.attrib(p["data"], "vertices", last = 10)


# diferentes ambientes para plotagem dos pontos
rgl.open()
rgl.points(rnorm(100), rnorm(100), rnorm(100))
rgl.bbox(color = c("#333377", "white"), emission = "#333377",
         specular = "#3333FF", shininess = 5, alpha = 0.8 )

open3d()
points3d(rnorm(100), rnorm(100), rnorm(100))
bbox3d(color = c("#333377", "black"), emission = "#333377",
       specular = "#3333FF", shininess = 5, alpha = 0.8)


# Apenas pontos, sem marcações de eixos
rgl.open()
rgl.points(rnorm(1000), rnorm(1000), rnorm(1000), color = heat.colors(1000))
rgl.bringtotop(stay = TRUE)


# pontos + inserção de um quadrado
open3d()
points3d(rnorm(100), rnorm(100), rnorm(100))
if (interactive() || !.Platform$OS == "unix") {
  # Calcula um quadrado na metade do display e plota ele
  square <- rgl.window2user(c(0.25, 0.25, 0.75, 0.75, 0.25),
                            c(0.25, 0.75, 0.75, 0.25, 0.25), 0.5)
  par3d(ignoreExtent = TRUE)
  lines3d(square)
  par3d(ignoreExtent = FALSE)
}

##--------------------------------------------------------------------------------------------------
## Mostra plano de regressão com z como variável dependente
open3d()
x <- rnorm(100)
y <- rnorm(100)
z <- 0.2*x - 0.3*y + rnorm(100, sd = 0.3)
fit <- lm(z ~ x + y)
plot3d(x, y, z, type = "s", col = "red", size = 1)
coefs <- coef(fit)
a <- coefs["x"]
b <- coefs["y"]
c <- -1
d <- coefs["(Intercept)"]
planes3d(a, b, c, d, alpha = 0.5)

open3d()
ids <- plot3d(x, y, z, type = "s", col = "red", size = 1, forceClipregion = TRUE)
useSubscene3d(ids["clipregion"])
clipplanes3d(a, b, c, d)


##--------------------------------------------------------------------------------------------------
## Pontos + elipsóide: normal trivariada
# Gráfico de uma amostra aleatória e um elipsóide representando a concentração correspondente Ã 
# região de probabilidade 95% para uma distribuição trivariada

if (requireNamespace("MASS")) {
  Sigma <- matrix(c(10, 3, 0, 3, 2, 0, 0, 0, 1), 3, 3)
  Mean <- 1:3
  x <- MASS::mvrnorm(1000, Mean, Sigma)
  open3d()
  plot3d(x, box = FALSE, xlab="x", ylab="y", zlab="z")
  plot3d( ellipse3d(Sigma, centre = Mean), col = "green", alpha = 0.5, add = TRUE)
}

##--------------------------------------------------------------------------------------------------
## Região de confianÃ§a dos coeficientes de regressão
# Representa a região de confianÃ§a de 90% estimada e conjunta para os coeficientes de reg das variáveis
# displacement e cylinder, do conjunto mtcars

data(mtcars)
fit <- lm(mpg ~ disp + cyl , mtcars)
open3d()
plot3d(ellipse3d(fit, level = 0.90), col = "blue", alpha = 0.5, aspect = TRUE)


##--------------------------------------------------------------------------------------------------
## Permite a identificação de alguns pontos e desenha-os com uma cor diferente

# Identificando pontos
xyz <- cbind(rnorm(20), rnorm(20), rnorm(20))
ids <- plot3d( xyz )
if (interactive()) {
  # Clique próximo ao ponto a se selecionado e coloque uma esferra nele
  # Aperte ESC para sair
  selectpoints3d(ids["data"],
                 multiple = function(x) {
                   spheres3d(x, color = "red", alpha = 0.3, radius = 0.2)
                   TRUE
                 })
  # Isto retorna os pontos
  selectpoints3d(ids["data"], value = FALSE,
                 multiple = function(ids) {
                   spheres3d(xyz[ids[, "index"], , drop = FALSE], color = "blue",
                             alpha = 0.3, radius = 0.2)
                   TRUE
                 })
}
# Objeto com ponto selecionado
ids


##--------------------------------------------------------------------------------------------------
## Salva no diretório atual o gráfico gerado nas seguintes extenções
x <- y <- seq(-10, 10, length = 20)
z <- outer(x, y, function(x, y) x^2 + y^2)
persp3d(x, y, z, col = 'lightblue')
title3d("Usando texto em Latex", col = 'red', line = 3)
rgl.postscript("persp3da.ps", "ps", drawText = FALSE)
rgl.postscript("persp3da.pdf", "pdf", drawText = FALSE)
rgl.postscript("persp3da.tex", "tex")
rgl.pop()
title3d("Usando texto ps/pdf", col = 'red', line = 3)
rgl.postscript("persp3db.ps", "ps")
rgl.postscript("persp3db.pdf", "pdf")
rgl.postscript("persp3db.tex", "tex", drawText = FALSE)


##--------------------------------------------------------------------------------------------------
## Construindo a superficie da perspectiva de uma vulcão
data(volcano)
y <- 2 * volcano # uma matriz
x <- 10 * (1:nrow(y)) # eixo de plotagem (S to N)
z <- 10 * (1:ncol(y)) # eixo de plotagem (E to W)
ylim <- range(y)
ylen <- ylim[2] - ylim[1] + 1
colorlut <- terrain.colors(ylen)
col <- colorlut[ y - ylim[1] + 1 ]
rgl.open()
rgl.surface(x, z, y, color = col, back = "lines")


open3d()
z <- 2 * volcano
x <- 10 * (1:nrow(z))
y <- 10 * (1:ncol(z))
persp3d(x, y, z, col = "green3", aspect = "iso")
s <- scene3d()

# Aumentando
s$par3d$windowRect <- 1.5*s$par3d$windowRect
# e plotando novamente
plot3d(s)


##--------------------------------------------------------------------------------------------------
# Mostra o globo terrestre com subcamadas até o interior da terra
lat <- matrix(seq(90, -90, len = 50)*pi/180, 50, 50, byrow = TRUE)
long <- matrix(seq(-180, 180, len = 50)*pi/180, 50, 50)
r <- 6378.1 # radius of Earth in km
x <- r*cos(lat)*cos(long)
y <- r*cos(lat)*sin(long)
z <- r*sin(lat)
open3d()
obj <- surface3d(x, y, z, col = "white",
                 texture = system.file("textures/worldsmall.png", package = "rgl"),
                 specular = "black", axes = FALSE, box = FALSE, xlab = "", ylab = "", zlab = "",
                 normal_x = x, normal_y = y, normal_z = z)
cols <- c(rep("chocolate4", 4), rep("burlywood1", 4), "darkgoldenrod1")
rs <- c(6350, 5639, 4928.5, 4207, 3486,
        (3486 + 2351)/2, 2351, (2351 + 1216)/2, 1216)
for (i in seq_along(rs))
  obj <- c(obj, spheres3d(0, 0, col = cols[i], radius = rs[i]))
root <- currentSubscene3d()
newSubscene3d("inherit", "inherit", "inherit", copyShapes = TRUE, parent = root)
clipplanes3d(1, 0, 0, 0)
newSubscene3d("inherit", "inherit", "inherit", copyShapes = TRUE, parent = root)
clipplanes3d(0, 1, 0, 0)
newSubscene3d("inherit", "inherit", "inherit", copyShapes = TRUE, parent = root)
clipplanes3d(0, 0, 1, 0)
# Now delete the objects from the root subscene, to reveal the clipping planes
useSubscene3d(root)
delFromSubscene3d(obj)


##--------------------------------------------------------------------------------------------------
## animação: rotaciona objeto por 10 segundos
rgl.open()
shade3d(oh3d(), color = "red")
start <- proc.time()[3]
while ((i <- 36*(proc.time()[3] - start)) < 360) {
  rgl.viewpoint(i, i/4);
}


##--------------------------------------------------------------------------------------------------
## Para movimentação do objeto em várias direções
open3d()
plot3d( cube3d(col = "green") )
M <- par3d("userMatrix")
if (!rgl.useNULL())
  play3d(par3dinterp(time = (0:2)*0.75,
                     userMatrix = list(M,
                                       rotate3d(M, pi/2, 1, 0, 0),
                                       rotate3d(M, pi/2, 0, 1, 0))),
         duration = 3 )

movie3d(spin3d(), duration = 5)


##--------------------------------------------------------------------------------------------------
## Cria uma pagina html com uma foto da figura
plot3d(rnorm(100), rnorm(100), rnorm(100), type = "s", col = "red")
# Este escreve uma cópia em diretório temporário 'WebGL', e em seguida, exibe-o
filename <- writeWebGL(dir = file.path(tempdir(), "webGL"),
                       width = 500, reuse = TRUE)
# Mostra ao atributo "reuse"
attr(filename, "reuse")
# Mostra a imagem em um browser
if (interactive())
  browseURL(paste0("file://", filename))



##--------------------------------------------------------------------------------------------------
## Gráficos de pontos com diferentes visualizações

cone3d <- function(base,tip,rad,n=30,...) {
  degvec <- seq(0, 2*pi, length=n)
  ax <- tip - base
  ## O que fazer se ax[1]==0?
  if (ax[1]!=0) {
    p1 <- c(-ax[2]/ax[1],1,0)
    p1 <- p1/sqrt(sum(p1^2))
    if (p1[1]!=0) {
      p2 <- c(-p1[2]/p1[1],1,0)
      p2[3] <- -sum(p2*ax)
      p2 <- p2/sqrt(sum(p2^2))
    } else {
      p2 <- c(0,0,1)
    }
  } else if (ax[2]!=0) {
    p1 <- c(0,-ax[3]/ax[2],1)
    p1 <- p1/sqrt(sum(p1^2))
    if (p1[1]!=0) {
      p2 <- c(0,-p1[3]/p1[2],1)
      p2[3] <- -sum(p2*ax)
      p2 <- p2/sqrt(sum(p2^2))
    } else {
      p2 <- c(1,0,0)
    }
  } else {
    p1 <- c(0,1,0); p2 <- c(1,0,0)
  }
  ecoord2 <- function(theta) {
    base+rad*(cos(theta)*p1+sin(theta)*p2)
  }
  for (i in 1:(n-1)) {
    li <- ecoord2(degvec[i])
    lj <- ecoord2(degvec[i+1])
    triangles3d(c(li[1],lj[1],tip[1]),c(li[2],lj[2],tip[2]),c(li[3],lj[3],tip[3]),...)
  }
}

lollipop3d <- function(data.x,data.y,data.z,surf.fun,surf.n=50,
                       xlim=range(data.x),
                       ylim=range(data.y),
                       zlim=range(data.z),
                       asp=c(y=1,z=1),
                       xlab=deparse(substitute(x)),
                       ylab=deparse(substitute(y)),
                       zlab=deparse(substitute(z)),
                       alpha.surf=0.4,
                       col.surf=fg,col.stem=c(fg,fg),
                       col.pt="gray",type.surf="line",ptsize,
                       lwd.stem=2,lit=TRUE,bg="white",fg="black",
                       col.axes=fg,col.axlabs=fg,
                       axis.arrow=TRUE,axis.labels=TRUE,
                       box.col=bg,
                       axes=c("lines","box")) {
  axes <- match.arg(axes)
  col.stem <- rep(col.stem,length=2)
  x.ticks <- pretty(xlim)
  x.ticks <- x.ticks[x.ticks>=min(xlim) & x.ticks<=max(xlim)]
  x.ticklabs <- if (axis.labels) as.character(x.ticks) else NULL
  y.ticks <- pretty(ylim)
  y.ticks <- y.ticks[y.ticks>=min(ylim) & y.ticks<=max(ylim)]
  y.ticklabs <- if (axis.labels) as.character(y.ticks) else NULL
  z.ticks <- pretty(zlim)
  z.ticks <- z.ticks[z.ticks>=min(zlim) & z.ticks<=max(zlim)]
  z.ticklabs <- if (axis.labels) as.character(z.ticks) else NULL
  if (!missing(surf.fun)) {
    surf.x <- seq(xlim[1],xlim[2],length=surf.n)
    surf.y <- seq(ylim[1],ylim[2],length=surf.n)
    surf.z <- outer(surf.x, surf.y,surf.fun)  ## exige surf.fun seja vetorizada
    z.interc <- surf.fun(data.x,data.y)
    zdiff <- diff(range(c(surf.z,data.z)))
  } else {
    z.interc <- rep(min(data.z),length(data.x))
    zdiff <- diff(range(data.z))
  }
  xdiff <- diff(xlim)
  ydiff <- diff(ylim)
  y.adj <- if (asp[1]<=0) 1 else asp[1]*xdiff/ydiff
  data.y <- y.adj*data.y
  y.ticks <- y.adj*y.ticks
  ylim <- ylim*y.adj
  ydiff <- diff(ylim)
  z.adj <- if (asp[2]<=0) 1 else asp[2]*xdiff/zdiff
  data.z <- z.adj*data.z
  if (!missing(surf.fun)) {
    surf.y <- y.adj*surf.y
    surf.z <- z.adj*surf.z
  }
  z.interc <- z.adj*z.interc
  z.ticks <- z.adj*z.ticks
  zlim <- z.adj*zlim
  open3d()
  clear3d("all")
  light3d()
  bg3d(color=c(bg,fg))
  if (!missing(surf.fun))
    surface3d(surf.x,surf.y,surf.z,alpha=alpha.surf,
              front=type.surf,back=type.surf,
              col=col.surf,lit=lit)
  if (missing(ptsize)) ptsize <- 0.02*xdiff
  ## draw points
  spheres3d(data.x,data.y,data.z,r=ptsize,lit=lit,color=col.pt)
  ## draw lollipops
  apply(cbind(data.x,data.y,data.z,z.interc),1,
        function(X) {
          lines3d(x=rep(X[1],2),
                  y=rep(X[2],2),
                  z=c(X[3],X[4]),
                  col=ifelse(X[3]>X[4],col.stem[1],
                             col.stem[2]),lwd=lwd.stem)
        })
  bbox <- par3d("bbox")
  if (axes=="box") {
    bbox3d(xat=x.ticks,xlab=x.ticklabs,
           yat=y.ticks,ylab=y.ticklabs,
           zat=z.ticks,zlab=z.ticklabs,lit=lit)
  } else if (axes=="lines") { ## estabelece as linhas dos eixos
    bbox <- par3d("bbox")
    axis3d(edge="x",at=x.ticks,labels=x.ticklabs,
           col=col.axes,arrow=axis.arrow)
    axis3d(edge="y",at=y.ticks,labels=y.ticklabs,
           col=col.axes,arrow=axis.arrow)
    axis3d(edge="z",at=z.ticks,labels=z.ticklabs,
           col=col.axes,arrow=axis.arrow)
    box3d(col=col.axes)
  }
  decorate3d(xlab=xlab, ylab=ylab, zlab=zlab, box=FALSE, axes=FALSE, col=col.axlabs)
}

x <- 1:5
y <- x*10
z <- (x+y)/20
open3d()
spheres3d(x,y,z)
axes3d()
set.seed(1001)
x <- runif(30)
y <- runif(30,max=2)
dfun <- function(x,y) { 2*x+3*y+2*x*y+3*y^2 }
z <- dfun(x,y)+rnorm(30,sd=0.5)
## Apenas lollipop
lollipop3d(x,y,z)

## lollipops + SuperfÃ­cie teórica

lollipop3d(x,y,z,dfun,col.pt="red",col.stem=c("red","blue"))
## lollipops + ajuste de regressão

linmodel <- lm(z ~ x+y)
dfun <- function(x,y) {predict(linmodel,newdata=data.frame(x=x,y=y))}
lollipop3d(x,y,z,dfun,col.pt="red",col.stem=c("red","blue"))


##--------------------------------------------------------------------------------------------------
## Demos do pacote rgl
demo(hist3d)
demo(abundance)
demo(regression)
demo(lsystem)
demo(subdivision)
demo(bivar) # Exige a biblioteca MASS


##--------------------------------------------------------------------------------------------------
# demo: regression
# author: Daniel Adler

rgl.demo.regression <- function(n=100,xa=3,za=8,xb=0.02,zb=0.01,xlim=c(0,100),zlim=c(0,100)) {

  rgl.clear("all")
  rgl.bg(sphere = TRUE, color = c("black", "green"), lit = FALSE, size=2, alpha=0.2, back = "lines")
  rgl.light()
  rgl.bbox()

  x  <- runif(n,min=xlim[1],max=xlim[2])
  z  <- runif(n,min=zlim[1],max=zlim[2])
  ex <- rnorm(n,sd=3)
  ez <- rnorm(n,sd=2)

  esty  <- (xa+xb*x) * (za+zb*z) + ex + ez

  rgl.spheres(x,esty,z,color="gray",radius=1.5,specular="green",
              texture=system.file("textures/bump_dust.png",package="rgl"),
              texmipmap=T, texminfilter="linear.mipmap.linear")

  regx  <- seq(xlim[1],xlim[2],len=100)
  regz  <- seq(zlim[1],zlim[2],len=100)
  regy  <- (xa+regx*xb) %*% t(za+regz*zb)

  rgl.surface(regx,regz,regy,color="blue",alpha=0.5,shininess=128)
  # rgl.surface(regx,regz,regy,color="blue",front="lines",back="lines")

  lx <- c(xlim[1],xlim[2],xlim[2],xlim[1])
  lz <- c(zlim[1],zlim[1],zlim[2],zlim[2])
  f <- function(x,z) { return ( (xa+x*xb) * t(za+z*zb) ) }
  ly <- f(lx,lz)

  rgl.quads(lx,ly,lz,color="red",size=5,front="lines",back="lines",lit=FALSE)
}

rgl.open()
rgl.demo.regression()



##--------------------------------------------------------------------------------------------------
# RGL-Demo: animal abundance
# Authors: Oleg Nenadic, Daniel Adler


rgl.demo.abundance <- function()
{
  open3d()
  clear3d("all")          # remove todas as formas, luzes, limites, e restaurar ponto de vista

  # Ambiente de setup
  bg3d(col="#cccccc")     # configuração do fundo
  light3d()               # configuração head-light

  # Importando dados
  terrain <- dget(system.file("demodata/region.dat",package="rgl"))
  pop <- dget(system.file("demodata/population.dat",package="rgl"))

  # Define cores para o terreno
  zlim <- range(terrain)
  zlen <- zlim[2] - zlim[1] + 1
  colorlut <- terrain.colors(82)
  col1 <- colorlut[9*sqrt(3.6*(terrain-zlim[1])+2)]

  # Definir a cor azul (água) para regiÃµes com zero "altitude"
  col1[terrain==0]<-"#0000FF"

  # Adicionar forma da superfÃ­cie de terreno (ou seja, densidade populacional):
  surface3d(
    1:100,seq(1,60,length=100),terrain,
    col=col1,spec="#000000", ambient="#333333", back="lines"
  )

  # Define cores para as populações simuladas (machos: azul, fêmeas: vermelho):
  col2<-pop[,4]
  col2[col2==0]<-"#3333ff"
  col2[col2==1]<-"#ff3333"

  # Adiciona populações simuladas no formato de esferas
  spheres3d(
    pop[,1],
    pop[,2],
    terrain[cbind( ceiling(pop[,1]),ceiling(pop[,2]*10/6))] + 0.5,
    radius=0.2*pop[,3], col=col2, alpha=(1-(pop[,5])/10 )
  )

}
rgl.demo.abundance()



##--------------------------------------------------------------------------------------------------
# rgl demo: rgl-bivar.r
# author: Daniel Adler

rgl.demo.bivar <- function()
{
  require(MASS);

  # parÃ¢metros:
  n<-50; ngrid<-40

  # Gerando amostras:
  set.seed(31415)
  x<-rnorm(n); y<-rnorm(n)

  # estima uma superfÃ­cie com densidade não-paramétrica via kernel smoothing
  denobj<-kde2d(x, y, n=ngrid)
  den.z <-denobj$z

  # gera uma superfÃ­cie de densidade paramétrica de uma distribuição normal bivariada
  xgrid <- denobj$x
  ygrid <- denobj$y
  bi.z <- dnorm(xgrid)%*%t(dnorm(ygrid))

  # visualizar:
  zscale<-20

  # Nova janela
  open3d()

  # cenário limpo:
  clear3d("all")

  # setup env:
  bg3d(color="#887777")
  light3d()

  # Desenha os dados simulados como esferas sobre a linha de base
  spheres3d(x,y,rep(0,n),radius=0.1,color="#CCCCFF")

  # Desenha uma densidade não-parétrica
  surface3d(xgrid,ygrid,den.z*zscale,color="#FF2222",alpha=0.5)

  # Desenha uma densidade paramétrica
  surface3d(xgrid,ygrid,bi.z*zscale,color="#CCCCFF",front="lines")
}

rgl.demo.bivar()



##--------------------------------------------------------------------------------------------------
# RGL-Demo: environment mapping
# Author: Daniel Adler

rgl.demo.envmap <- function()
{
  open3d()
  # Cenário limpo:
  clear3d("all")
  light3d()
  bg3d(sphere=T, color="white", back="filled"
       , texture=system.file("textures/refmap.png",package="rgl")
  )
  data(volcano)

  surface3d( 10*1:nrow(volcano),10*1:ncol(volcano),5*volcano
             , texture=system.file("textures/refmap.png",package="rgl")
             , texenvmap=TRUE
             , color = "white"
  )
}
rgl.demo.envmap()



##--------------------------------------------------------------------------------------------------
## Movimenta logo do pacote rgl
wave <- function(time) {
  x <- seq(0,2, len=100)

  wavefn <- function(x) x * sin(-5*time + 1.5 * (x/2) * 2*pi)/10
  deriv <- function(x) (wavefn(x + 0.01) - wavefn(x - 0.01))/0.02

  arclen <- cumsum(sqrt(1 + deriv(x)^2))*(x[2]-x[1])
  keep <- arclen < 2
  x <- x[keep]
  y <- matrix(wavefn(x), length(x),20)
  z <- matrix(seq(0,1, len=20), length(x), 20, byrow=TRUE)
  arclen <- arclen[keep]

  par3d(skipRedraw = TRUE)
  if (nrow(rgl.ids())) rgl.pop()
  surface3d(x,y,z, texture_s=matrix(arclen/2, length(x), 20), texture_t=z, col="white")
  c(list(skipRedraw = FALSE), spin(time))
}

open3d()
material3d(texture = system.file("textures","rgl2.png", package="rgl"))
spin <- spin3d(rpm=6,axis=c(0,0,1))
if (!rgl.useNULL())
  play3d(wave, 10, startTime = 5)



##--------------------------------------------------------------------------------------------------
## histograma

# Exige as funções 'binplot' and 'hist3d':

binplot.3d<-function(x,y,z,alpha=1,topcol="#ff0000",sidecol="#aaaaaa")
{
  save <- par3d(skipRedraw=TRUE)
  on.exit(par3d(save))

  x1<-c(rep(c(x[1],x[2],x[2],x[1]),3),rep(x[1],4),rep(x[2],4))
  z1<-c(rep(0,4),rep(c(0,0,z,z),4))
  y1<-c(y[1],y[1],y[2],y[2],rep(y[1],4),rep(y[2],4),rep(c(y[1],y[2],y[2],y[1]),2))
  x2<-c(rep(c(x[1],x[1],x[2],x[2]),2),rep(c(x[1],x[2],rep(x[1],3),rep(x[2],3)),2))
  z2<-c(rep(c(0,z),4),rep(0,8),rep(z,8) )
  y2<-c(rep(y[1],4),rep(y[2],4),rep(c(rep(y[1],3),rep(y[2],3),y[1],y[2]),2) )
  rgl.quads(x1,z1,y1,col=rep(sidecol,each=4),alpha=alpha)
  rgl.quads(c(x[1],x[2],x[2],x[1]),rep(z,4),c(y[1],y[1],y[2],y[2]),
            col=rep(topcol,each=4),alpha=1)
  rgl.lines(x2,z2,y2,col="#000000")
}

hist3d<-function(x,y=NULL,nclass="auto",alpha=1,col="#ff0000",scale=10)
{
  save <- par3d(skipRedraw=TRUE)
  on.exit(par3d(save))
  xy <- xy.coords(x,y)
  x <- xy$x
  y <- xy$y
  n<-length(x)
  if (nclass == "auto") { nclass<-ceiling(sqrt(nclass.Sturges(x))) }
  breaks.x <- seq(min(x),max(x),length=(nclass+1))
  breaks.y <- seq(min(y),max(y),length=(nclass+1))
  z<-matrix(0,(nclass),(nclass))
  for (i in 1:nclass)
  {
    for (j in 1:nclass)
    {
      z[i, j] <- (1/n)*sum(x < breaks.x[i+1] & y < breaks.y[j+1] &
                             x >= breaks.x[i] & y >= breaks.y[j])
      binplot.3d(c(breaks.x[i],breaks.x[i+1]),c(breaks.y[j],breaks.y[j+1]),
                 scale*z[i,j],alpha=alpha,topcol=col)
    }
  }
}
rgl.open()

rgl.bg(color="gray")
rgl.light()

# Desenhando um 'bin' para as coordenadas dadas:
binplot.3d(c(-0.5,0.5),c(4.5,5.5),2,alpha=0.6)

# Definir o ponto de vista ('theta' e 'phi' tem o mesmo significado como na persp):
rgl.viewpoint(theta=40,phi=40)

# Escolhendo um fundo cinza claro:
rgl.bg(col="#cccccc")


## QUADS FORMING BIN:

# Aguardando a entrada de usuário para criar o próximo cenário:
# readline()

rgl.open()

# Definindo a transparência e as cores:
alpha<-0.7; topcol<-"#ff0000"; sidecol<-"#aaaaaa"

# Configurando coordenadas para os quads e adicionndo-os ao gráfico
y <- x <- c(-1,1); z<-4; of<-0.3
x12<-c(x[1],x[2],x[2],x[1]); x11<-rep(x[1],4); x22<-rep(x[2],4)
z00<-rep(0,4); z0z<-c(0,0,z,z); zzz<-rep(z,4); y11<-rep(y[1],4)
y1122<-c(y[1],y[1],y[2],y[2]); y12<-c(y[1],y[2],y[2],y[1]); y22<-rep(y[2],4)

rgl.quads(c(x12,x12,x11-of,x12,x22+of,x12),
          c(z00-of,rep(z0z,4),zzz+of),
          c(y1122,y11-of,y12,y22+of,y12,y1122),
          col=rep(c(rep(sidecol,5),topcol),each=4),alpha=c(rep(alpha,5),1))

# Configurando coordenadas para as linhas de borda dos quads e desenhando-os:
yl1<-c(y[1],y[2],y[1],y[2]); yl2<-c(y[1]-of,y[1]-of)
xl<-c(rep(x[1],8),rep(x[1]-of,8),rep(c(x[1],x[2]),8),rep(x[2],8),rep(x[2]+of,8))
zl<-c(0,z,0,z,z+of,z+of,-of,-of,0,0,z,z,0,z,0,z,rep(0,4),rep(z,4),rep(-of,4),
      rep(z+of,4),z+of,z+of,-of,-of,rep(c(0,z),4),0,0,z,z)
yl<-c(yl2,y[2]+of,y[2]+of,rep(c(y[1],y[2]),4),y[1],y[1],y[2],y[2],yl2,
      rep(y[2]+of,4),yl2,y[2],y[2],rep(y[1],4),y[2],y[2],yl1,yl2,y[2]+of,
      y[2]+of,y[1],y[1],y[2],y[2],yl1)

rgl.lines(xl,zl,yl,col="#000000")


## Histograma completo:

# Esperando a entrada do usuário para criar próximo cenário:
# readline()

rgl.open()

# Escolhendo um cinza claro de fundo:
rgl.bg(col="#cccccc")

# Configurando o rng para um valor fixo:
set.seed(1000)

# Desenhando um histograma 3d com 2.500 observações normalmente distribuÃ­das:
hist3d(rnorm(2500),rnorm(2500),alpha=0.4,nclass=7,scale=30)



##--------------------------------------------------------------------------------------------------
# demo: lsystem.r
# author: Daniel Adler

#
# Geometria
#

deg2rad <- function( degree ) {
  return( degree*pi/180 )
}

rotZ.m3x3 <- function( degree ) {
  kc <- cos(deg2rad(degree))
  ks <- sin(deg2rad(degree))
  return(
    matrix(
      c(
        kc, -ks,   0,
        ks,  kc,   0,
        0,   0,   1
      ),ncol=3,byrow=T
    )
  )
}

rotX.m3x3 <- function( degree ) {
  kc <- cos(deg2rad(degree))
  ks <- sin(deg2rad(degree))
  return(
    matrix(
      c(
        1,   0,   0,
        0,  kc, -ks,
        0,  ks,  kc
      ),ncol=3,byrow=T
    )
  )
}

rotY.m3x3 <- function( degree ) {
  kc <- cos(deg2rad(degree))
  ks <- sin(deg2rad(degree))
  return(
    matrix(
      c(
        kc,   0,   ks,
        0,   1,    0,
        -ks,   0,   kc
      ),ncol=3,byrow=T
    )
  )
}

rotZ <- function( v, degree ) {
  return ( rotZ.m3x3(degree) %*% v)
}

rotX <- function( v, degree ) {
  return ( rotX.m3x3(degree) %*% v)
}

rotY <- function( v, degree ) {
  return ( rotY.m3x3(degree) %*% v)
}


#
# gráficos tartaruga, implementação RGL:
#

turtle.init <- function(pos=c(0,0,0),head=0,pitch=90,roll=0,level=0) {
  rgl.clear("all")
  rgl.bg(color="black")
  rgl.light()
  return( list(pos=pos,head=head,pitch=pitch,roll=roll,level=level) )
}


turtle.move <- function(turtle, steps, color) {

  rm <- rotX.m3x3(turtle$pitch) %*% rotY.m3x3(turtle$head) %*% rotZ.m3x3(turtle$roll)

  from <- as.vector( turtle$pos )
  dir  <- rm %*% c(0,0,-1)
  to   <- from + dir * steps

  x <- c( from[1], to[1] )
  y <- c( from[2], to[2] )
  z <- c( from[3], to[3] )
  rgl.lines(x,y,z,col=color,size=1.5,alpha=0.5)
  turtle$pos <- to
  return (turtle)
}

turtle.pitch <- function(turtle, degree) {
  turtle$pitch <- turtle$pitch + degree
  return(turtle)
}

turtle.head <- function(turtle, degree) {
  turtle$head <- turtle$head + degree
  return(turtle)
}

turtle.roll <- function(turtle, degree) {
  turtle$roll <- turtle$roll + degree
  return(turtle)
}

#
# l-system general
#


lsystem.code <- function( x )
  substitute( x )

lsystem.gen <- function( x, grammar, levels=0 ) {
  code <- eval( substitute( substitute( REPLACE , grammar ), list(REPLACE=x) ) )
  if (levels)
    return( lsystem.gen( code , grammar , levels-1 ) )
  else
    return( code )
}

#
# l-system plot
#

lsystem.plot <- function( expr, level ) {
  turtle <- turtle.init(level=level)
  lsystem.eval( expr, turtle )
}

lsystem.eval <- function( expr, turtle ) {
  if ( length(expr) == 3 ) {
    turtle <- lsystem.eval( expr[[2]], turtle )
    turtle <- lsystem.eval( expr[[3]], turtle )
    turtle <- lsystem.eval( expr[[1]], turtle )
  } else if ( length(expr) == 2 ) {
    saved <- turtle
    turtle <- lsystem.eval( expr[[1]], turtle )
    turtle <- lsystem.eval( expr[[2]], turtle )
    turtle <- saved
  } else if ( length(expr) == 1 ) {
    if ( as.name(expr) == "stem" )      turtle <- turtle.move(turtle, 5, "brown")
    else if ( as.name(expr) == "short") turtle <- turtle.move(turtle, 5, "brown")
    else if ( as.name(expr) == "leaf" ) {
      rgl.spheres(turtle$pos[1],turtle$pos[2],turtle$pos[3],radius=0.1+turtle$level*0.3,color="green")
      rgl.sprites(turtle$pos[1],turtle$pos[2],turtle$pos[3],radius=0.5+turtle$level*0.3 ,color="green",texture=system.file("textures/particle.png",package="rgl"),textype="alpha",alpha=0.5)
    }
    else if ( as.name(expr) == "roll" ) turtle <- turtle.head(turtle, 60)
    else if ( as.name(expr) == "down" ) turtle <- turtle.pitch(turtle,10)
    else if ( as.name(expr) == "up" )   turtle <- turtle.pitch(turtle,-10)
    else if ( as.name(expr) == "left" ) turtle <- turtle.head(turtle, 1)
    else if ( as.name(expr) == "right") turtle <- turtle.head(turtle,-1.5)
    else if ( as.name(expr) == "turnleft") turtle <- turtle.head(turtle,20)
    else if ( as.name(expr) == "turnright") turtle <- turtle.head(turtle,-20)
    else if ( as.name(expr) == "turn") turtle <- turtle.roll(turtle,180)
  }
  return (turtle)
}


#
# Exemplo
#

simple <- function (level=0) {
  grammar <- list(
    stem=lsystem.code(
      stem-(up-stem-leaf)-stem-(down-stem-leaf)-stem-leaf
    )
  )
  plant <- lsystem.gen(lsystem.code(stem), grammar, level )
  lsystem.plot(plant,level)
}

rgl.demo.lsystem <- function (level=0) {
  gen   <- list(
    stem=lsystem.code(
      stem-left-stem-branch( turnleft-down-short-turnleft-down-stem-leaf)-right-right-stem--branch( turnright-up-short-turnright-up-short-turnright-short-stem-leaf)-left-left-left-stem-branch( turnleft-down-short-turnright-down-stem-leaf )-branch( up-turnright-short-up-turnleft-up-stem-leaf )
    )
  )
  plant <- lsystem.gen(lsystem.code(stem), gen, level )
  lsystem.plot(plant,level)
}

rgl.open()
rgl.demo.lsystem(level=1)

