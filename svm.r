
wdbc <- read.csv("./data/wdbc.csv",header=T)

#サポートベクターマシン
library(kernlab)

#データの準備
d_s <- data.frame(scale(wdbc[c("radius","texture","perimeter")]),wdbc[c("diagnosis")])

# ランダムに20個のデータのIDを得る。
idx <- sample(1:length(d_s[[1]]),20)
# モデル作成用のデータ（訓練データ）
d_train <- d_s[idx,]
# 検証データ
d_test <- d_s[-idx,]

#モデルの学習
model <- ksvm(diagnosis ~ ., data=d_train, kernel="rbfdot")

library(pROC)
#データの予測
pred <- predict(model, d_train, type="response")[,1]
plot.roc(d_train$diagnosis, pred, print.auc = T)
roc(d_train$diagnosis, pred)$auc


pred <- predict(model, d_test, type="response")[,1]
plot.roc(d_test[,c("diagnosis")], pred, print.auc = T)
roc(d_test[,c("diagnosis")], pred)$auc

