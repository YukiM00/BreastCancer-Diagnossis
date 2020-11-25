#Preparation
wdbc <- read.csv("./data/wdbc.csv")

d_s <- data.frame(scale(wdbc[c("radius","texture","perimeter","area","smoothness","compactness","concavity","concave.points","symmetry","fractal.dimension")]),wdbc[c("diagnosis")])
#"radius","texture","perimeter","area","smoothness","compactness","concavity","concave.points","symmetry","fractal.dimension"

idx <- sample(1:length(d_s[[1]]),455)#      
d_train <- d_s[idx,]  #train
d_test <- d_s[-idx,]  #test

#Logistic Regression
cat("Logistic Regression\n")
model <- glm(diagnosis ~ ., family="binomial", data=d_train) 
#model <- step(model1)
summary(model)
library(pROC)
#prediction (train data)
pred <- predict(model, d_train, type="response")
plot.roc(d_train$diagnosis, pred, print.auc = T)
roc(d_train$diagnosis, pred)$auc
#prediction (test data)
pred <- predict(model, d_test, type="response")
plot.roc(d_test$diagnosis, pred, print.auc = T)
roc(d_test$diagnosis, pred)$auc

#Random Forest
cat("\n\n\n\nRandom Forest\n")
library(randomForest)
model1 <- randomForest(diagnosis ~ ., data=d_train, importance=T) 
model <- step(model1)
#importance(model)
library(pROC)
#prediction (train data)
pred <- predict(model, d_train, type="response")
plot.roc(d_train$diagnosis, pred, print.auc = T)
roc(d_train$diagnosis, pred)$auc
#prediction (test data)
pred <- predict(model, d_test, type="response")
plot.roc(d_test[,c("diagnosis")], pred, print.auc = T)
roc(d_test[,c("diagnosis")], pred)$auc

#Support Vector Machine
cat("\n\n\n\nSupport Vector Machine\n")
library(kernlab)
model <- ksvm(diagnosis ~ ., data=d_train, kernel="rbfdot")

library(pROC)
#prediction (train data)
pred <- predict(model, d_train, type="response")[,1]
plot.roc(d_train$diagnosis, pred, print.auc = T)
roc(d_train$diagnosis, pred)$auc
#prediction (test data)
pred <- predict(model, d_test, type="response")[,1]
plot.roc(d_test[,c("diagnosis")], pred, print.auc = T)
roc(d_test[,c("diagnosis")], pred)$auc
