require(rpanel)

rp.loess <- function(y, x, n=20, er=0, ...){
    annotations <- function(m0, y){
        mtext(side=3, adj=0, line=1.5,
              text=sprintf("H trace: %0.2f", m0$trace.hat))
        mtext(side=3, adj=0, line=0.5,
              text=sprintf("Equivalent num. param.: %0.2f", m0$enp))
        r2 <- 100*cor(fitted(m0), y)^2
        mtext(side=3, adj=1, line=1.5,
              text=sprintf("R²: %0.2f", r2))
    }
    draw.loess <- function(panel){
        with(panel,
             {
                 m0 <- loess(y~x, span=span, degree=degree,
                             family="gaussian")
                 erx <- extendrange(x, f=er)
                 xx <- seq(erx[1], erx[2], length.out=200)
                 yy <- predict(m0, newdata=data.frame(x=xx))
                 a <- abs(x-x0)
                 if(span < 1){
                     q <- as.integer(span*length(x))
                     d <- sort(a)[q]
                 } else {
                     q <- length(x)
                     d <- max(abs(x-x0))*sqrt(span)
                 }
                 w <- rep(0, length(x))
                 s <- a <= d
                 w[s] <- (1-(a[s]/d)^3)^3
                 i <- as.integer(s)
                 xl <- range(x)
                 xl[1] <- ifelse(x0 - d>xl[1], x0-d, xl[1])
                 xl[2] <- ifelse(x0 + d<xl[2], x0+d, xl[2])
                 f0 <- function(...){
                     y.pred <- sum(w*y)/sum(w)
                     segments(xl[1], y.pred, xl[2], y.pred, col=2,
                              ...)
                 }
                 f1 <- function(...){
                     m <- lm(y ~ poly(x, degree=1), weights=w)
                     y.pred <- predict(m, newdata=list(x=xl))
                     segments(xl[1], y.pred[1], xl[2], y.pred[2], col=2,
                              ...)
                 }
                 f2 <- function(...){
                     m <- lm(y~poly(x, degree=as.integer(degree)), weights=w)
                     x.pred <- seq(xl[1], xl[2], length.out=n)
                     y.pred <- predict(m, newdata=list(x=x.pred))
                     lines(x.pred, y.pred, col=2, ...)
                 }
                 plot(x, y, pch=2*(!s)+1, cex=i*3*w+1,
                      xlim=extendrange(x, f=er),
                      ylim=extendrange(y, f=er), ...)
                 lines(yy~xx)
                 abline(v=c(x0, xl), lty=c(2,3,3))
                 annotations(m0, y)
                 mtext(side=3, adj=1, line=0.5,
                       text=sprintf("Number of obs. used/total: %i/%i",
                           sum(w>0), length(y)))
                 switch(findInterval(degree, c(-Inf, 1, 2, Inf)),
                        "0"=f0(), "1"=f1(), "2"=f2())
             })
        panel
    }
    xr <- extendrange(x, f=er)
    panel <- rp.control(x=x, y=y, n=n, er=er)
    rp.doublebutton(panel, variable=degree, action=draw.loess, showvalue=TRUE,
                    step=1, initval=0, range=c(0, 2), title="Degree")
    rp.slider(panel, variable=x0, action=draw.loess,
              from=xr[1], to=xr[2], initval=median(range(x)),
              showvalue=TRUE, title="x-value")
    rp.slider(panel, variable=span, action=draw.loess,
              from=0, to=1.5, initval=0.75,
              showvalue=TRUE, title="span")
    rp.do(panel, action=draw.loess)
}

rp.loess(x=cars$speed, y=cars$dist, n=25, er=0.2)
rp.loess(x=rock$area, y=rock$peri, n=25)
rp.loess(x=faithful$eruptions, y=faithful$waiting, er=0.3)
rp.loess(x=ca$hora, y=ca$temp, er=0.3)
