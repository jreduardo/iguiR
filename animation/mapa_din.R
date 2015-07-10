##--------------------------------------------------------------------------------------------------
## Gráfico de mapas dinâmicos

## Pacotes
library(animation)
library(RColorBrewer)
library(classInt)
library(spdep)
library(maptools)
library(sp)

## Diretório e objetos
setwd("C:/Users/Vanessa/Dropbox/Rbras/mini_curso/mapa_din")
load("pr.RData")
load("dat.RData")


saveHTML(
  for (t in 1:17) {
    if (t == 1) {
      i = 1:399
    }
    if (t > 1)
      (i = (1:399) + (t - 1) * 399)
    x <- (dat$predito[i]/dat$pop[i]) * 1e+05
    obs <- (dat$value[i]/dat$pop[i]) * 1e+05
    pal_raw <- c(brewer.pal(5, "Reds"))

    par(mfrow = c(1, 2), mar = c(1, 1, 2, 0), mgp = c(2, 0.5, 0))

    rkmeans7_BEL <- classIntervals(x, style = "fixed", fixedBreaks = c(0, 2, 10, 20, 40, Inf))
    rkmeans7_obs <- classIntervals(obs, style = "fixed", fixedBreaks = c(0, 2, 10, 20, 40, Inf))

    plot(pr, col = findColours(rkmeans7_obs, pal_raw), bg = "gray")
    cols <- findColours(rkmeans7_obs, pal_raw)
    brks = c(0, 2, 10, 20, 40, Inf)
    table <- attr(cols, "table")
    legtext <- paste(leglabs(brks, under = "Menor que", over = "Maior que",
                             between = "a"), " (", table, ")", sep = "")
    legend("bottomleft", fill = attr(cols, "palette"), legend = legtext,
           cex = 0.75, xpd = TRUE, x.inter = 0.3, xjust = 0,
           text.width = 1.2, yjust = 0, bty = "n", text.col = "black")
    legend("top", bty = "n", legend = paste("Observado", "Ano de", 1996 + t))

    plot(pr, col = findColours(rkmeans7_BEL, pal_raw), bg = "gray")
    cols <- findColours(rkmeans7_BEL, pal_raw)
    brks <- c(0, 2, 10, 20, 40, Inf)
    table <- attr(cols, "table")
    legtext <- paste(leglabs(brks, under = "Menor que", over = "Maior que",
                             between = "a"), " (", table, ")", sep = "")
    legend("bottomleft", fill = attr(cols, "palette"), legend = legtext,
           cex = 0.75, xpd = TRUE, x.inter = 0.3, xjust = 0,
           text.width = 1.2, yjust = 0, bty = "n", text.col = "black")
    legend("top", bty = "n", legend = paste("Predito", "Ano de", 1996 + t))

    ani.pause()
  }, verbose=FALSE)

