# BreastCancer-Diagnossis
Challenge to create a predictor using logistic regression, random forests, and support vector machines.

・Classification of cancer cells using the Breast Cancer Wisconsin (Diagnostic) Data Set.

## Check
- R 3.6.1 
- glm
- randomForest
- kernlab
- pROC

## Result
AUC train data & test data
|                         |     train     |     test      | 
| ----------------------- | ------------- | ------------- |
|  Logistic Regression    |     0.968     |     0.986     |
|       Random Forest     |     1.000     |     0.993     |
| Support Vector Machine  |     0.975     |     0.988     |

