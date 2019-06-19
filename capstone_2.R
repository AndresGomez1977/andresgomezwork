#you can get the input file at https://github.com/AndresGomez1977/andresgomezwork/blob/data-science-capstone/winequality-red.csv

winequality.red <- read.csv("C:/Users/andres.gomez/Desktop/DS/winequality-red.csv", sep=";")
View(winequality.red)

#R earlier than 3.6
set.seed(229)
#R 3.6 and later
#set.seed(229, sample.kind = "Rounding")
summary(winequality.red)
#correlation matrix
res <- cor(winequality.red)
round(res, 2)
#there are no variables with high correlation between eachother.

## SVD and PCA to understand influence of features in the variability.

winequality.red[is.na(winequality.red)]<-0
winequality.red<-sweep(winequality.red,1,rowMeans(winequality.red))
pca<-prcomp(winequality.red)

dim(pca$rotation)
var_explainted<-cumsum(pca$sdev^2/sum(pca$sdev^2))
plot(var_explainted)

allfortest<-data.frame(cbind(pca$x,winequality.red$quality))

library(ggplot2)

qplot(data=allfortest, x=PC1, y=PC2, color=(V13))

####first idea... 

####https://courses.edx.org/courses/course-v1:HarvardX+PH125.8x+2T2018/courseware/a49844e4a3574c239f354654f9679888/638b5f585b604ae187b32d1e089fccb8/?child=first

models <- c("glm", "lda",  "naive_bayes",  "svmLinear", 
            "gamboost",  "gamLoess", "qda", 
            "knn", "kknn", "loclda", "gam",
            "rf", "ranger",  "wsrf", "Rborist", 
            "avNNet", "mlp", "monmlp",
            "adaboost", "gbm",
            "svmRadial", "svmRadialCost", "svmRadialSigma")

library(caret)
#library(dslabs)
set.seed(229)
#data("mnist_27")

test_index <- createDataPartition(y = winequality.red$quality, times = 1, p = 0.2, list = FALSE)
train_set <- winequality.red[-test_index,]
test_set <- winequality.red[test_index,]



fits <- lapply(models, function(model){ 
  print(model)
  train(quality ~ ., method = model, data = train_set)
}) 

names(fits) <- models
