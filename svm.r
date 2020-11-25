# Support Vector Machine
wdbc <- read.csv("./data/wdbc.csv",header=T)

library(kernlab)

d_s <- data.frame(scale(wdbc[c("radius","texture","perimeter")]),wdbc[c("diagnosis")])

# Get the ID of 20 pieces of data at random.
idx <- sample(1:length(d_s[[1]]),20)

d_train <- d_s[idx,]
d_test <- d_s[-idx,]


model <- ksvm(diagnosis ~ ., data=d_train, kernel="rbfdot")

library(pROC)

pred <- predict(model, d_train, type="response")[,1]
plot.roc(d_train$diagnosis, pred, print.auc = T)
roc(d_train$diagnosis, pred)$auc

pred <- predict(model, d_test, type="response")[,1]
plot.roc(d_test[,c("diagnosis")], pred, print.auc = T)
roc(d_test[,c("diagnosis")], pred)$auc

