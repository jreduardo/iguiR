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


##--------------------------------------------------------------------------------------------------
## Gráfico de perspectiva + grids
x <- 1:10
y <- 1:10
z <- matrix(outer(x - 5, y - 5) + rnorm(100), 10, 10)

open3d()
persp3d(x, y, z, col = "red", alpha = 0.7, aspect = c(1, 1, 0.5))
grid3d(c("x", "y", "z"))


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
