##=============================================================================
## Interactive Graphical User Interfaces with R
## RBRAS/SEAGRO 2015
##
##=============================================================================

##=============================================================================
## Animation
require(animation)

##--------------------------------------------
## Exemplo apresentação
x <- precip
a <- extendrange(x)

ani.options(interval = 0.3)
for(i in 1:30){
    bks <- seq(a[1], a[2], length.out = i + 1)
    hist(x, breaks = bks)
    ani.pause()
}

##--------------------------------------------
## Exemplo para exportação

ani.options(interval = 0.3)
for(i in 1:26){
    plot(x = i, y = 1, pch = LETTERS[i],
         xlim = c(1, 26), cex = 4)
    ani.pause()
}

saveGIF({
    for(i in 1:26){
        plot(x = i, y = 1, pch = LETTERS[i],
             xlim = c(1, 26), cex = 4)
    }}, interval = 0.1)

saveVideo({
    for(i in 1:26){
        plot(x = i, y = 1, pch = LETTERS[i],
             xlim = c(1, 26), cex = 4)
    }}, interval = 0.1)

saveSWF({
    for(i in 1:26){
        plot(x = i, y = 1, pch = LETTERS[i],
             xlim = c(1, 26), cex = 4)
        ani.pause()
    }}, interval = 0.1)

saveLatex({
    for(i in 1:26){
        plot(x = i, y = 1, pch = LETTERS[i],
             xlim = c(1, 26), cex = 4)
    }}, interval = 0.1,
          ani.width = 7, 
          ani.height = 7,
          ani.dev = "pdf",
          ani.type = "pdf")

saveHTML({
    for(i in 1:26){
        plot(x = i, y = 1, pch = LETTERS[i],
             xlim = c(1, 26), cex = 4)
    }}, interval = 0.1)
