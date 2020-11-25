# Random Forest
wdbc <- read.csv("wdbc.csv",header=T)

library(randomForest)

d_s <- data.frame(scale(wdbc[c("texture","symmetry")]),wdbc[c("diagnosis")])

# Get the ID of 20 pieces of data at random.
idx <- sample(1:length(d_s[[1]]),20)

d_train <- d_s[idx,]
d_test <- d_s[-idx,]

model <- randomForest(diagnosis ~ ., data=d_train, importance=T)

library(pROC)
pred <- predict(model, d_train, type="response")
plot.roc(d_train$diagnosis, pred, print.auc = T)
roc(d_train$diagnosis, pred)$auc

importance(model)

pred <- predict(model, d_test, type="response")
plot.roc(d_test[,c("diagnosis")], pred, print.auc = T)
roc(d_test[,c("diagnosis")], pred)$auc

