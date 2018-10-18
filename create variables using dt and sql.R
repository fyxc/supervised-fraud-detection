library(data.table)
library(sqldf)
library(RSQLite)
library(lubridate)

setwd("~/Desktop/Fraud project3")


data = fread('data.csv', stringsAsFactors = F)
str(data)
data$Date = mdy(data$Date)

cardlabel <- sqldf("SELECT t1.Recordnum,
                   COUNT(CASE WHEN t1.Date = t2.Date THEN t1.Recordnum ELSE NULL END) AS cardlab_1,
                   COUNT(CASE WHEN t1.Date - t2.Date BETWEEN 0 AND 2 THEN t1.Recordnum ELSE NULL END) AS cardlab_3,
                   COUNT(CASE WHEN t1.Date - t2.Date BETWEEN 0 AND 6 THEN t1.Recordnum ELSE NULL END) AS cardlab_7,
                   COUNT(CASE WHEN t1.Date - t2.Date BETWEEN 0 AND 14 THEN t1.Recordnum ELSE NULL END) AS cardlab_15,
                   COUNT(CASE WHEN t1.Date - t2.Date BETWEEN 0 AND 29 THEN t1.Recordnum ELSE NULL END) AS cardlab_30,
                   COUNT(CASE WHEN t1.Date = t2.Date and t1.Fraud = 1 THEN t1.Recordnum ELSE NULL END) AS cardlab_fraud_1,
                   COUNT(CASE WHEN t1.Date - t2.Date BETWEEN 0 AND 2 and t1.Fraud = 1 THEN t1.Recordnum ELSE NULL END) AS cardlab_fraud_3,
                   COUNT(CASE WHEN t1.Date - t2.Date BETWEEN 0 AND 6 and t1.Fraud = 1 THEN t1.Recordnum ELSE NULL END) AS cardlab_fraud_7,
                   COUNT(CASE WHEN t1.Date - t2.Date BETWEEN 0 AND 14 and t1.Fraud = 1 THEN t1.Recordnum ELSE NULL END) AS cardlab_fraud_15,
                   COUNT(CASE WHEN t1.Date - t2.Date BETWEEN 0 AND 29 and t1.Fraud = 1 THEN t1.Recordnum ELSE NULL END) AS cardlab_fraud_30
                   FROM data t1 LEFT JOIN data t2
                   ON t1.card_label = t2.card_label
                   AND t1.Date - t2.Date BETWEEN 0 AND 29
                   AND t1.Recordnum > t2.Recordnum
                   GROUP BY 1")

merlabel <- sqldf("SELECT t1.Recordnum,
                   COUNT(CASE WHEN t1.Date = t2.Date THEN t1.Recordnum ELSE NULL END) AS merlab_1,
                   COUNT(CASE WHEN t1.Date - t2.Date BETWEEN 0 AND 2 THEN t1.Recordnum ELSE NULL END) AS merlab_3,
                   COUNT(CASE WHEN t1.Date - t2.Date BETWEEN 0 AND 6 THEN t1.Recordnum ELSE NULL END) AS merlab_7,
                   COUNT(CASE WHEN t1.Date - t2.Date BETWEEN 0 AND 14 THEN t1.Recordnum ELSE NULL END) AS merlab_15,
                   COUNT(CASE WHEN t1.Date - t2.Date BETWEEN 0 AND 29 THEN t1.Recordnum ELSE NULL END) AS merlab_30,
                   COUNT(CASE WHEN t1.Date = t2.Date and t1.Fraud = 1 THEN t1.Recordnum ELSE NULL END) AS merlab_fraud_1,
                   COUNT(CASE WHEN t1.Date - t2.Date BETWEEN 0 AND 2 and t1.Fraud = 1 THEN t1.Recordnum ELSE NULL END) AS merlab_fraud_3,
                   COUNT(CASE WHEN t1.Date - t2.Date BETWEEN 0 AND 6 and t1.Fraud = 1 THEN t1.Recordnum ELSE NULL END) AS merlab_fraud_7,
                   COUNT(CASE WHEN t1.Date - t2.Date BETWEEN 0 AND 14 and t1.Fraud = 1 THEN t1.Recordnum ELSE NULL END) AS merlab_fraud_15,
                   COUNT(CASE WHEN t1.Date - t2.Date BETWEEN 0 AND 29 and t1.Fraud = 1 THEN t1.Recordnum ELSE NULL END) AS merlab_fraud_30
                   FROM data t1 LEFT JOIN data t2
                   ON t1.mer_label = t2.mer_label
                   AND t1.Date - t2.Date BETWEEN 0 AND 29
                   AND t1.Recordnum > t2.Recordnum
                   GROUP BY 1")

variables = data.frame(cardlabel,merlabel)

write.csv(variables, file = 'varible.csv')
