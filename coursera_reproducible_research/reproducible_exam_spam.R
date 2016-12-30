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
costFunction = function(x,y) sum(x!=(y>0.5)) #x,y가 같으면 0, 다르면 1 x는 관측치, y는 예측치
cvError = rep(NA,55)
library(boot)
for(i in 1:55){
  lmFormula = reformulate(names(trainSpam)[i],response = "numtype")
  glmFit = glm(lmFormula, family = "binomial", data=trainSpam)
  cvError[i] = cv.glm(trainSpam,glmFit,costFunction,2)$delta[2]
}

#which predictor has minimum cross-validated error?
names(trainSpam)[which.min(cvError)]


#get measure of uncertainty

## use the best model from the group
predictionModel = glm(numtype ~ charDollar,family = "binomial",data=trainSpam)

##Get predictions on the test set
predictionTest = predict(predictionModel,testSpam)
predictedSpam = rep("nonspam",dim(testSpam)[1])

##Classify as 'spam' for those with prob >0.5
predictedSpam[predictionModel$fitted.values >0.5]= "spam"
predictedSpam = na.omit(predictedSpam)
##Classification table
table(predictedSpam, testSpam$type)
# predictedSpam nonspam spam
# nonspam    1329  467
# spam         54  446

##Error rate
(54+467)/(1329+467+54+446)
# [1] 0.2269164
