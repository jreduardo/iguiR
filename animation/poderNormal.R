rm(list=ls())

pol <- function(m1, s, lim,
                col=rgb(0.5,0.5,0.5,0.5), border=NA, ...){
    xx <- seq(lim[1], lim[2],
              length.out=floor(100*diff(lim)/diff(par()$usr[1:2])))
    yy <- dnorm(xx, m1, s)
    xx <- c(lim[1], xx, lim[2])
    yy <- c(0, yy, 0)
    polygon(x=xx, y=yy, col=col, border=border, ...)
}

cau <- function(m0, s, lim, ...){
    parlim <- par()$usr[1:2]
    reglim <- lim
    ## Left.
    lim <- c(parlim[1], reglim[1])
    pol(m0, s, lim, ...)
    ## Right.
    lim <- c(reglim[2], parlim[2])
    pol(m0, s, lim, ...)
}

power <- function(m1, s, z){
    p <- pnorm(z, m1, s)
    diff(p)
}
power <- Vectorize(FUN=power, vectorize.args="m1")

m0 <- 0; m <- 0.5; s <- 1
alpha <- 0.9
p <- c(0, alpha)+(1-alpha)/2
z <- qnorm(p, m0, s)
mvals <- seq(-5, 5, by=0.1)
pwvals <- 1-power(mvals, s=1, z=z)

par(mfrow=c(2,1), mar=c(3,4,2,2))
curve(dnorm(x, m0, s), -5, 5,
      xlab=NA, ylab=NA,
      xaxt="n", yaxt="n")
axis(side=1, at=c(m0, m),
     labels=expression(mu[0], mu),
     tick=TRUE)
cau(m0, s, lim=z,
    col=rgb(0.95,0.15,0.15,0.75))
pol(m=m, s=s, lim=z)
curve(dnorm(x, m, s), add=TRUE, lty=2)
segments(x0=m0, x1=m0,
         y0=0, y1=dnorm(m0, m0, s))
segments(x0=m, x1=m,
         y0=0, y1=dnorm(m, m, s),
         lty=2)
title(main=expression(H[0]*":"~mu==mu[0]))
legend(y=sum(c(0,1.15)*par()$usr[3:4]),
       x=sum(c(0.1,0.79)*par()$usr[1:2]),
       xpd=TRUE, bty="n", fill=rgb(0.5,0.5,0.5,0.5),
       legend=sprintf("%0.4f", power(m1=m, s=s, z=z)))
plot(pwvals~mvals, ylim=c(0,1), type="l",
     xlab=NA, ylab=NA,
     xaxt="n", yaxt="n")
pw <- 1-power(m, s=1, z=z)
abline(v=0, h=1-alpha, lty=3)
abline(v=m, h=pw, lty=2)
axis(side=1, at=c(m0, m),
     labels=expression(mu[0], mu), tick=TRUE)
axis(side=2, at=pw, labels=sprintf("%0.4f", pw), las=2)

##-----------------------------------------------------------------------------

require(animation)

mseq <- seq(-5, 5, by=0.1)
int <- rep(0.1, length(mseq))
int[mseq==0] <- 2

saveGIF(interval=int,
        expr={
            for (m in mseq){
                par(mfrow=c(2,1), mar=c(3,4,2,2))
                curve(dnorm(x, m0, s), -5, 5,
                      xlab=NA, ylab=NA,
                      xaxt="n", yaxt="n")
                axis(side=1, at=c(m0, m),
                     labels=expression(mu[0], mu),
                     tick=TRUE)
                cau(m0, s, lim=z,
                    col=rgb(0.95,0.15,0.15,0.75))
                pol(m=m, s=s, lim=z)
                curve(dnorm(x, m, s), add=TRUE, lty=2)
                segments(x0=m0, x1=m0,
                         y0=0, y1=dnorm(m0, m0, s))
                segments(x0=m, x1=m,
                         y0=0, y1=dnorm(m, m, s),
                         lty=2)
                title(main=expression(H[0]*":"~mu==mu[0]))
                legend(y=sum(c(0,1.15)*par()$usr[3:4]),
                       x=sum(c(0.1,0.79)*par()$usr[1:2]),
                       xpd=TRUE, bty="n", fill=rgb(0.5,0.5,0.5,0.5),
                       legend=sprintf("%0.4f", power(m1=m, s=s, z=z)))
                plot(pwvals~mvals, ylim=c(0,1), type="l",
                     xlab=NA, ylab=NA,
                     xaxt="n", yaxt="n")
                pw <- 1-power(m, s=1, z=z)
                abline(v=0, h=1-alpha, lty=3)
                abline(v=m, h=pw, lty=2)
                axis(side=1, at=c(m0, m),
                     labels=expression(mu[0], mu), tick=TRUE)
                axis(side=2, at=pw, labels=sprintf("%0.4f", pw), las=2)
            }
        }) 
