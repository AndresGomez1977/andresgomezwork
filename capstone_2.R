

#you can get the input file at https://github.com/AndresGomez1977/andresgomezwork/blob/data-science-capstone/winequality-red.csv

winequality.red <- read.csv("C:/Users/andres.gomez/Desktop/DS/winequality-red.csv", sep=";")
View(winequality.red)

#R earlier than 3.6
set.seed(229)
#R 3.6 and later
#set.seed(229, sample.kind = "Rounding")
summary(winequality.red)

#####first idea... 
####https://courses.edx.org/courses/course-v1:HarvardX+PH125.8x+2T2018/courseware/a49844e4a3574c239f354654f9679888/638b5f585b604ae187b32d1e089fccb8/?child=first

models <- c("glm", "lda",  "naive_bayes",  "svmLinear", 
            "gamboost",  "gamLoess", "qda", 
            "knn", "kknn", "loclda", "gam",
            "rf", "ranger",  "wsrf", "Rborist", 
            "avNNet", "mlp", "monmlp",
            "adaboost", "gbm",
            "svmRadial", "svmRadialCost", "svmRadialSigma")

library(caret)
library(dslabs)
set.seed(1)
data("mnist_27")

fits <- lapply(models, function(model){ 
  print(model)
  train(y ~ ., method = model, data = mnist_27$train)
}) 

names(fits) <- models