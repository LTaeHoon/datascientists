install.packages("kernlab")
library(kernlab)
data(spam)
#perform the subsampling
set.seed(1234)
trainIndicator = rbinom(4601,size=1,prob=0.5)
table(trainIndicator)
trainSpam = spam[trainIndicator==1,]
testSpam = spam[trainIndicator==0,]

names(trainSpam)
head(trainSpam)

table(trainSpam$type)

# average number of capital by type(spam, nonspam)
plot(trainSpam$capitalAve ~ trainSpam$type)

# plot이 보기 어렵다 데이터 대부분이 겹쳐 있어서, 이런 경우 log 처리 해주면 보기 좋게 변경할 수 있다.
plot(log10(trainSpam$capitalAve+1)~trainSpam$type)

# relationship between predictors (pair plot)
plot(log10(trainSpam[,1:4]+1))

#clustering
hCluster =  hclust(dist(t(trainSpam[,1:57])))
plot(hCluster)

#New clustering
hClusterUpdated = hclust(dist(t(log10(trainSpam[,1:55]+1))))
plot(hClusterUpdated)

#Statistical prediction/modeling
trainSpam$numtype = as.numeric(trainSpam$type)-1
costFunction = function(x,y) sum(x!=(y>0.05))
cvError = rep(NA,55)
library(boot)
for(i in 1:55){
  lmFormula = reformulate(names(trainSpam)[i],response = "numType")
  glmFit = glm(lmFormula, family = "binomial", data=trainSpam)
  cvError[i] = cv.glm()
}