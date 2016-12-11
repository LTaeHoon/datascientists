#heatmaps : 분류 분석 시각화 방법 중 하나

set.seed(1234)
dataMatrix <- as.matrix(dataFrame)[sample(1:12),]
kmeansObj2 <- kmeans(dataMatrix, centers=3)

par(mfrow =c(1,2),mar=c(2,4,0.1,0.1))
image(t(dataMatrix)[,nrow(dataMatrix):1],yaxt='n')
image(t(dataMatrix)[,order(kmeansObj2$cluster)],yaxt='n')

