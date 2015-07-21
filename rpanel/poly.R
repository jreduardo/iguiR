require(rpanel)

rp.poly <- function(y, x, er=0){
    annotations <- function(m0){
        mtext(side=3, adj=0, line=1.5,
              text=sprintf("X rank: %i", m0$rank))
        mtext(side=3, adj=0, line=0.5,
              text=sprintf("Residual DF: %i", m0$df.residual))
        press <- sum((residuals(m0)/(1-hatvalues(m0)))^2)
        mtext(side=3, adj=1, line=0.5,
              text=sprintf("PRESS: %0.2f", press))
        sm0 <- summary(m0)
        lastcoef <- sprintf("High term p-value: %0.5f",
                            sm0$coeff[length(coef(m0)), 4])
        mtext(side=3, adj=1, line=2.5, text=lastcoef)
        mtext(side=3, adj=1, line=1.5,
              text=sprintf("R² (adj. R²): %0.2f (%0.2f)",
                  100*sm0$r.squared, 100*sm0$adj.r.squared))
    }
    draw.poly <- function(panel){
        with(panel,
             {
                 m0 <- lm(y~poly(x, degree=degree))
                 xr <- extendrange(x, f=er)
                 yr <- extendrange(y, f=er)
                 xx <- seq(xr[1], xr[2], length.out=200)
                 cb <- predict(m0, newdata=data.frame(x=xx),
                               interval="confidence")
                 plot(y~x, xlim=xr, ylim=yr)
                 matlines(xx, cb, lty=c(1,2,2), col=1)
                 annotations(m0)
             })
        panel
    }
    maxd <- length(unique(x))-1
    panel <- rp.control(x=x, y=y, er=er)
    rp.doublebutton(panel, variable=degree,
                    action=draw.poly, showvalue=TRUE,
                    step=1, initval=1,
                    range=c(1, maxd),
                    title="Degree of polynomial")
    rp.do(panel, action=draw.poly)
}

rp.poly(x=rock$area, y=rock$peri, er=0.3)
rp.poly(x=cars$speed, y=cars$dist, er=0.3)
rp.poly(x=faithful$eruptions, y=faithful$waiting, er=0.3)
rp.poly(x=ca$hora, y=ca$temp, er=0.3)
