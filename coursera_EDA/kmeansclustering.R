#k-means clustering- example

set.seed(1234) #난수 발생 시드
par(mar =c(0,0,0,0)) #plot 바깥 마진
x <- rnorm(12, mean=rep(1:3,each=4),sd=0.2) #랜덤변수함수 12개 평균은 1~3 표준편차 0.2
y <- rnorm(12, mean=rep(c(1,2,1),each=4),sd=0.2)
plot(x,y,col='blue',pch=19,cex=2)
text(x+0.05,y+0.05,labels = as.character(1:12))

dataFrame <- data.frame(x,y)
kmeansObj <- kmeans(dataFrame, centers=3) #kmeans 함
names(kmeansObj)

kmeansObj$cluster
kmeansObj$centers

par(mar = rep(0.2,4))
plot(x,y,col=kmeansObj$cluster,pch=19,cex=2)
points(kmeansObj$centers,col=1:3,pch=3,cex=3,lwd=3)
