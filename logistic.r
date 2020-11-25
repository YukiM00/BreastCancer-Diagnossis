# Logistic Regression
wdbc <- read.csv("./data/wdbc.csv")

d_s <- data.frame(scale(wdbc[c("texture","smoothness")]),wdbc[c("diagnosis")])

#"radius","texture","perimeter","area","smoothness","compactness","concavity","concave.points","symmetry","fractal.dimension"

res <- glm(diagnosis ~ ., family="binomial", data=d_s)

summary(res)

idx <- sample(1:length(d_s[[1]]),20)

d_train <- d_s[idx,]

model <- glm(diagnosis ~ ., family="binomial", data=d_train)

d_test <- d_s[-idx,]

library(pROC)

pred <- predict(model, d_train, type="response")
plot.roc(d_train$diagnosis, pred, print.auc = T)
roc(d_train$diagnosis, pred)$auc

pred <- predict(model, d_test, type="response")
plot.roc(d_test$diagnosis, pred, print.auc = T)
roc(d_test$diagnosis, pred)$auc

