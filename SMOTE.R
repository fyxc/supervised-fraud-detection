setwd("~/Desktop/Fraud project3")

library(DMwR)
library(caret)

prop.table((table(train$Fraud)))

train = read.csv('train_selected.csv')
train$Fraud <- as.factor(train$Fraud)
trainSplit <- SMOTE(Fraud ~ ., train, perc.over = 1000, perc.under=200)
trainSplit$Fraud <- as.numeric(trainSplit$Fraud)-1
prop.table(table(trainSplit$Fraud))

write.csv(trainSplit, 'train_smote.csv')
