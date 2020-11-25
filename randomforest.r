
wdbc <- read.csv("wdbc.csv",header=T)


#ランダムフォレスト
library(randomForest)

#データの準備
d_s <- data.frame(scale(wdbc[c("texture","symmetry")]),wdbc[c("diagnosis")])

# ランダムに20個のデータのIDを得る。
idx <- sample(1:length(d_s[[1]]),20)
# モデル作成用のデータ（訓練データ）
d_train <- d_s[idx,]
# 検証データ
d_test <- d_s[-idx,]


#モデルの学習
model <- randomForest(diagnosis ~ ., data=d_train, importance=T)


library(pROC)
pred <- predict(model, d_train, type="response")
plot.roc(d_train$diagnosis, pred, print.auc = T)
roc(d_train$diagnosis, pred)$auc


importance(model)

#name <- names(wdbc)
#for (i in 3:12){
#    partialPlot(model,d_s,name[c(i)])
#}

pred <- predict(model, d_test, type="response")
plot.roc(d_test[,c("diagnosis")], pred, print.auc = T)
roc(d_test[,c("diagnosis")], pred)$auc

