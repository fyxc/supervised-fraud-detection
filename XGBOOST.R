library(xgboost)
library(dplyr)
library(ggplot2)


setwd("~/Desktop/Fraud project3")

train = read.csv('train_selected.csv')
test = read.csv('test_selected.csv')
oot = read.csv('oot_selected.csv')


predictors_train = as.matrix(train[,11:40])
response_train = train$Fraud
train_xg = xgb.DMatrix(predictors_train, label = response_train)

predictors_validate = as.matrix(test[,11:40])
response_validate = test$Fraud
validate_xg = xgb.DMatrix(predictors_validate, label = response_validate)

predictors_oot = as.matrix(oot[,11:40])
response_oot = oot$Fraud
oot_xg = xgb.DMatrix(predictors_oot, label = response_oot)



params = list(booster = 'gbtree',eta = 1, 
              max_depth = 6,subsample = 0.7, gamma = 1,lambda = 1,
              colsample_bytree = sqrt(dim(predictors_train)[2]) / sqrt(dim(predictors_train)[2]),
              min_child_weight = 1,
              objective = 'binary:logistic')

watchlist = list(train = train_xg, eval = validate_xg)

xg_mod = xgb.train(data = train_xg, params =params,
                   watchlist = watchlist, nrounds = 100)

predict_xg = predict(xg_mod, oot_xg)
predict_xg.train = predict(xg_mod, train_xg)
predict_xg.test = predict(xg_mod, validate_xg)

oot.xg = oot %>%
  select(Recordnum, Fraud) %>%
  cbind(predict_xg) %>%
  arrange(-predict_xg)
# 0.7455621
sum(oot.xg$Fraud[1:252])/sum(oot.xg$Fraud)

# 1
train.xg = train %>%
  select(Recordnum, Fraud) %>%
  cbind(predict_xg.train) %>%
  arrange(-predict_xg.train)

sum(train.xg$Fraud[1:838])/sum(train.xg$Fraud)

# 0.9820896
test.xg = test %>%
  select(Recordnum, Fraud) %>%
  cbind(predict_xg.test) %>%
  arrange(-predict_xg.test)

sum(test.xg$Fraud[1:838])/sum(test.xg$Fraud)


name = names(train)[11:40]
importance_matrix <- xgb.importance(model = xg_mod, feature_names = name)
# calculate the importance of every feature
print(importance_matrix)
plot = xgb.plot.importance(importance_matrix = importance_matrix, top_n = 10)

ggplot(plot, aes(x = reorder(Feature,Importance), y = Importance, fill = Feature))+
  geom_bar(stat = 'identity')+
  coord_flip()+
  labs(x = 'Feature', title = 'Variable Importance')+
  theme(legend.position = "none",
               plot.title = element_text(hjust = 0.5),
               axis.text.x =element_text(angle = 45, hjust=1,size=16), 
               axis.text.y=element_text(size=16),
               title=element_text(size=20))

library(DiagrammeR)
install.packages('DiagrammeR')

xgb.plot.tree(feature_names = name, model = xg_mod, 
              n_first_tree = 0, plot_width = 1000, plot_height = 1000,
              color = 'black')
