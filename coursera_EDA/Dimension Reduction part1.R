#Dimension Reduction part1

#matrix data

set.seed(12345)
par(mar=rep(0,2,4))
dataMatrix <- matrix(rnorm(400),nrow=40)
image(1:10,1:40,t(dataMatrix)[,nrow(dataMatrix):1])

par(mar=rep(0.2,4))
heatmap(dataMatrix)

#패턴 추가
set.seed(678910)
for(i in 1:40){
  #flip a coin
  coinFlip <- rbinom(1,size=1,prob=0.5)
  #coinFlip이 1이면 if 문 수행
  if(coinFlip){
    dataMatrix[i,] <- dataMatrix[i,]+rep(c(0,3),each=5)
  }
}

par(mar=rep(0.2,4))
image(1:10,1:40,t(dataMatrix)[,nrow(dataMatrix):1])

heatmap(dataMatrix)

hh <- hclust(dist(dataMatrix)) #패턴을 준 테이터의 거리를 구해 분류함
dataMatrixOrdered <- dataMatrix[hh$order,] # 분류된 것을 정렬하여 dataMatrixOrdered에 저장
par(mfrow=c(1,3),mar=rep(3,4))
image(t(dataMatrixOrdered)[,nrow(dataMatrixOrdered):1])
plot(rowMeans(dataMatrixOrdered),40:1,xlab = "Row Mean",ylab="Row",pch=19)
plot(colMeans(dataMatrixOrdered),xlab="Column",ylab="Column Mean",pch=19)

svd1 <- svd(scale(dataMatrixOrdered))
par(mfrow=c(1,3))
image(t(dataMatrixOrdered)[,nrow(dataMatrixOrdered):1])
plot(svd1$u[,1],40:1,xlab="Row",ylab="First left singular vector",pch=19)
plot(svd1$v[,1],xlab="Column",ylab="First right singular vector",pch=19)

<<<<<<< HEAD
#Components of the SVD - Variance explained
par(mfrow=c(1,2))
plot(svd1$d,xlab='Column',ylab= "singular value",pch=19)
plot(svd1$d^2/sum(svd1$d^2),xlab='Column',ylab= "Prop. of variance explained",pch=19)

#relationship to principal components
svd1 <- svd(scale(dataMatrixOrdered))
pca1 <- prcomp(dataMatrixOrdered,scale=TRUE)
plot(pca1$rotation[,1],svd1$v[,1],pch=19,xlab="Pricipal Component 1",ylab="Right Singular Vector 1")
abline(c(0,1))
=======
par(mfrow=c(1,2))
plot(svd1$d, xlab="Column", ylab="Singular value",pch=19)
plot(svd1$d^2/sum(svd1$d^2),xlab = "Column",ylab = "Prop. of variance explained")

>>>>>>> 57d128810d9bb602dbfb6ac83da9ca6e77866089

