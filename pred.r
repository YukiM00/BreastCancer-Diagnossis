#データの準備
wdbc <- read.csv("./data/wdbc.csv")

d_s <- data.frame(scale(wdbc[c("radius","texture","perimeter","area","smoothness","compactness","concavity","concave.points","symmetry","fractal.dimension")]),wdbc[c("diagnosis")])
#"radius","texture","perimeter","area","smoothness","compactness","concavity","concave.points","symmetry","fractal.dimension"

idx <- sample(1:length(d_s[[1]]),455)#      ランダムにデータを得る。
d_train <- d_s[idx,]  #訓練用
d_test <- d_s[-idx,]  #検証用

#ロジスティック回帰
cat("ロジスティック回帰\n")
model <- glm(diagnosis ~ ., family="binomial", data=d_train) #モデルの学習
#model <- step(model1)
summary(model)
library(pROC)
#データの予測(訓練)
pred <- predict(model, d_train, type="response")
plot.roc(d_train$diagnosis, pred, print.auc = T)
roc(d_train$diagnosis, pred)$auc
#データの予測(検証)
pred <- predict(model, d_test, type="response")
plot.roc(d_test$diagnosis, pred, print.auc = T)
roc(d_test$diagnosis, pred)$auc

#ランダムフォレスト
cat("\n\n\n\nランダムフォレスト\n")
library(randomForest)
model1 <- randomForest(diagnosis ~ ., data=d_train, importance=T) #モデルの学習
model <- step(model1)
#importance(model)
library(pROC)
#データの予測(訓練)
pred <- predict(model, d_train, type="response")
plot.roc(d_train$diagnosis, pred, print.auc = T)
roc(d_train$diagnosis, pred)$auc
#データの予測(検証)
pred <- predict(model, d_test, type="response")
plot.roc(d_test[,c("diagnosis")], pred, print.auc = T)
roc(d_test[,c("diagnosis")], pred)$auc

#サポートベクターマシン
cat("\n\n\n\nサポートベクターマシン\n")
library(kernlab)
model <- ksvm(diagnosis ~ ., data=d_train, kernel="rbfdot")#モデルの学習

library(pROC)
#データの予測(訓練)
pred <- predict(model, d_train, type="response")[,1]
plot.roc(d_train$diagnosis, pred, print.auc = T)
roc(d_train$diagnosis, pred)$auc
#データの予測(検証)
pred <- predict(model, d_test, type="response")[,1]
plot.roc(d_test[,c("diagnosis")], pred, print.auc = T)
roc(d_test[,c("diagnosis")], pred)$auc
