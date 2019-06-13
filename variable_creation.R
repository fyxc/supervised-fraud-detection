library(sqldf)

#Frequency of transactions with same Cardnum
#Frequency of transactions with same Cardnum but different State
#Frequency of transactions with same Cardnum but different Zip
#Frequency of transactions with same Cardnum but different Amount
#Frequency of transactions with same Cardnum but different Merchantnum
data$Date<-as.Date(data$Date)

samecard=sqldf("
SELECT a.Recordnum,
COUNT(CASE WHEN a.Date = b.Date THEN a.Recordnum ELSE NULL END) -1 AS same_card_1,
COUNT(CASE WHEN a.Date-b.Date BETWEEN 0 AND 2 THEN a.Recordnum ELSE NULL END) -1 AS same_card_3,
COUNT(CASE WHEN a.Date-b.Date BETWEEN 0 AND 6 THEN a.Recordnum ELSE NULL END) -1 AS same_card_7,
COUNT(CASE WHEN a.Date-b.Date BETWEEN 0 AND 13 THEN a.Recordnum ELSE NULL END) -1 AS same_card_14,
COUNT(CASE WHEN a.Date-b.Date BETWEEN 0 AND 27 THEN a.Recordnum ELSE NULL END) -1 AS same_card_28,

COUNT(DISTINCT CASE WHEN a.Date = b.Date THEN a.MerchantState ELSE NULL END) -1 AS same_card_diff_state_1,
COUNT(DISTINCT CASE WHEN a.Date-b.Date BETWEEN 0 AND 2 THEN a.MerchantState ELSE NULL END) -1 AS same_card_diff_state_3,
COUNT(DISTINCT CASE WHEN a.Date-b.Date BETWEEN 0 AND 6 THEN a.MerchantState ELSE NULL END) -1 AS same_card_diff_state_7,
COUNT(DISTINCT CASE WHEN a.Date-b.Date BETWEEN 0 AND 13 THEN a.MerchantState ELSE NULL END) -1 AS same_card_diff_state_14,
COUNT(DISTINCT CASE WHEN a.Date-b.Date BETWEEN 0 AND 27 THEN a.MerchantState ELSE NULL END) -1 AS same_card_diff_state_28,

COUNT(DISTINCT CASE WHEN a.Date = b.Date THEN a.MerchantZip ELSE NULL END) -1 AS same_card_diff_zip_1,
COUNT(DISTINCT CASE WHEN a.Date-b.Date BETWEEN 0 AND 2 THEN a.MerchantZip ELSE NULL END) -1 AS same_card_diff_zip_3,
COUNT(DISTINCT CASE WHEN a.Date-b.Date BETWEEN 0 AND 6 THEN a.MerchantZip ELSE NULL END) -1 AS same_card_diff_zip_7,
COUNT(DISTINCT CASE WHEN a.Date-b.Date BETWEEN 0 AND 13 THEN a.MerchantZip ELSE NULL END) -1 AS same_card_diff_zip_14,
COUNT(DISTINCT CASE WHEN a.Date-b.Date BETWEEN 0 AND 27 THEN a.MerchantZip ELSE NULL END) -1 AS same_card_diff_zip_28,

COUNT(DISTINCT CASE WHEN a.Date = b.Date THEN a.Amount ELSE NULL END) -1 AS same_card_diff_amount_1,
COUNT(DISTINCT CASE WHEN a.Date-b.Date BETWEEN 0 AND 2 THEN a.Amount ELSE NULL END) -1 AS same_card_diff_amount_3,
COUNT(DISTINCT CASE WHEN a.Date-b.Date BETWEEN 0 AND 6 THEN a.Amount ELSE NULL END) -1 AS same_card_diff_amount_7,
COUNT(DISTINCT CASE WHEN a.Date-b.Date BETWEEN 0 AND 13 THEN a.Amount ELSE NULL END) -1 AS same_card_diff_amount_14,
COUNT(DISTINCT CASE WHEN a.Date-b.Date BETWEEN 0 AND 27 THEN a.Amount ELSE NULL END) -1 AS same_card_diff_amount_28,

COUNT(DISTINCT CASE WHEN a.Date = b.Date THEN a.Merchantnum ELSE NULL END) -1 AS same_card_diff_merch_1,
COUNT(DISTINCT CASE WHEN a.Date-b.Date BETWEEN 0 AND 2 THEN a.Merchantnum ELSE NULL END) -1 AS same_card_diff_merch_3,
COUNT(DISTINCT CASE WHEN a.Date-b.Date BETWEEN 0 AND 6 THEN a.Merchantnum ELSE NULL END) -1 AS same_card_diff_merch_7,
COUNT(DISTINCT CASE WHEN a.Date-b.Date BETWEEN 0 AND 13 THEN a.Merchantnum ELSE NULL END) -1 AS same_card_diff_merch_14,
COUNT(DISTINCT CASE WHEN a.Date-b.Date BETWEEN 0 AND 27 THEN a.Merchantnum ELSE NULL END) -1 AS same_card_diff_merch_28
FROM data a, data b
WHERE a.Cardnum = b.Cardnum
AND a.Recordnum >= b.Recordnum
GROUP BY 1")#group by the first column


#Frequency of transactions with same Merchantnum
#Frequency of transactions with same Merchantnum but different Zip
#Frequency of transactions with same Merchantnum but different State
#Frequency of transactions with same Merchantnum but different Amount
#Frequency of transactions with same Merchantnum but different Cardnum

samemerch<-sqldf("SELECT a.Recordnum,
COUNT(CASE WHEN a.Date = b.Date THEN a.Recordnum ELSE NULL END) -1 AS same_merch_1,
COUNT(CASE WHEN a.Date - b.Date BETWEEN 0 AND 2 THEN a.Recordnum ELSE NULL END) -1 AS same_merch_3,
COUNT(CASE WHEN a.Date - b.Date BETWEEN 0 AND 6 THEN a.Recordnum ELSE NULL END) -1 AS same_merch_7,
COUNT(CASE WHEN a.Date - b.Date BETWEEN 0 AND 13 THEN a.Recordnum ELSE NULL END) -1 AS same_merch_14,
COUNT(CASE WHEN a.Date - b.Date BETWEEN 0 AND 27 THEN a.Recordnum ELSE NULL END) -1 AS same_merch_28,

COUNT(DISTINCT CASE WHEN a.Date = b.Date THEN a.MerchantState ELSE NULL END) -1 AS same_merch_diff_state_1,
COUNT(DISTINCT CASE WHEN a.Date - b.Date BETWEEN 0 AND 2 THEN a.MerchantState ELSE NULL END) -1 AS same_merch_diff_state_3,
COUNT(DISTINCT CASE WHEN a.Date - b.Date BETWEEN 0 AND 6 THEN a.MerchantState ELSE NULL END) -1 AS same_merch_diff_state_7,
COUNT(DISTINCT CASE WHEN a.Date - b.Date BETWEEN 0 AND 13 THEN a.MerchantState ELSE NULL END) -1 AS same_merch_diff_state_14,
COUNT(DISTINCT CASE WHEN a.Date - b.Date BETWEEN 0 AND 27 THEN a.MerchantState ELSE NULL END) -1 AS same_merch_diff_state_28,

COUNT(DISTINCT CASE WHEN a.Date = b.Date THEN a.MerchantZip ELSE NULL END) -1 AS same_merch_diff_zip_1,
COUNT(DISTINCT CASE WHEN a.Date - b.Date BETWEEN 0 AND 2 THEN a.MerchantZip ELSE NULL END) -1 AS same_merch_diff_zip_3,
COUNT(DISTINCT CASE WHEN a.Date - b.Date BETWEEN 0 AND 6 THEN a.MerchantZip ELSE NULL END) -1 AS same_merch_diff_zip_7,
COUNT(DISTINCT CASE WHEN a.Date - b.Date BETWEEN 0 AND 13 THEN a.MerchantZip ELSE NULL END) -1 AS same_merch_diff_zip_14,
COUNT(DISTINCT CASE WHEN a.Date - b.Date BETWEEN 0 AND 27 THEN a.MerchantZip ELSE NULL END) -1 AS same_merch_diff_zip_28,

COUNT(DISTINCT CASE WHEN a.Date = b.Date THEN a.Amount ELSE NULL END) -1 AS same_merch_diff_amount_1,
COUNT(DISTINCT CASE WHEN a.Date - b.Date BETWEEN 0 AND 2 THEN a.Amount ELSE NULL END) -1 AS same_merch_diff_amount_3,
COUNT(DISTINCT CASE WHEN a.Date - b.Date BETWEEN 0 AND 6 THEN a.Amount ELSE NULL END) -1 AS same_merch_diff_amount_7,
COUNT(DISTINCT CASE WHEN a.Date - b.Date BETWEEN 0 AND 13 THEN a.Amount ELSE NULL END) -1 AS same_merch_diff_amount_14,
COUNT(DISTINCT CASE WHEN a.Date - b.Date BETWEEN 0 AND 27 THEN a.Amount ELSE NULL END) -1 AS same_merch_diff_amount_28,

COUNT(DISTINCT CASE WHEN a.Date = b.Date THEN a.Merchantnum ELSE NULL END) -1 AS same_merch_diff_merch_1,
COUNT(DISTINCT CASE WHEN a.Date - b.Date BETWEEN 0 AND 2 THEN a.Merchantnum ELSE NULL END) -1 AS same_merch_diff_card_3,
COUNT(DISTINCT CASE WHEN a.Date - b.Date BETWEEN 0 AND 6 THEN a.Merchantnum ELSE NULL END) -1 AS same_merch_diff_card_7,
COUNT(DISTINCT CASE WHEN a.Date - b.Date BETWEEN 0 AND 13 THEN a.Merchantnum ELSE NULL END) -1 AS same_merch_diff_card_14,
COUNT(DISTINCT CASE WHEN a.Date - b.Date BETWEEN 0 AND 27 THEN a.Merchantnum ELSE NULL END) -1 AS same_merch_diff_card_28
FROM data a, data b
WHERE a.Merchantnum = b.Merchantnum
AND a.Recordnum >= b.Recordnum
GROUP BY 1")#group by the first column

#Ratio of transaction amount of a specific Cardnum and the historical amount averages of this card 
#Ratio of transaction amount of a specific Cardnum and the historical maximum amounts of this card 
#Ratio of transaction amount of a specific Cardnum and the historical amount medians of this card 
#Ratio of transaction amount of a specific Cardnum and the historical amount modes of this card
#Ratio of transaction amount of a specific Cardnum and the historical total amount of this card

FindMode <- function(x) {
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}


data1 = sqldf("
                   SELECT a.Recordnum,
                   a.Amount, 
                  (CASE WHEN a.Recordnum = b.Recordnum THEN 0
                    WHEN b.Fraud = 1 THEN NULL
                    WHEN a.Date = b.Date AND a.Recordnum != b.Recordnum THEN b.amount 
                    ELSE NULL END) AS amount_1
                   FROM data a, data b WHERE a.Cardnum = b.Cardnum AND a.Recordnum >= b.Recordnum 
                   ")

# data1 = sqldf("
#                   SELECT a.Recordnum,a.Date,a.Amount,b.Recordnum,b.Fraud,b.Date,b.Amount,
#               a.Date-b.Date as aa,
#               (CASE WHEN a.Recordnum = b.Recordnum THEN 0
#                     WHEN b.Fraud = 1 THEN NULL
#               WHEN a.Date = b.Date AND a.Recordnum != b.Recordnum THEN b.amount 
#               ELSE NULL END) AS amount_1
#               FROM data a, data b
#               WHERE a.Cardnum = b.Cardnum
#               AND a.Recordnum >= b.Recordnum
#               AND a.Cardnum=5142189113
#               ")

data_1 = data1 %>%
  group_by(Recordnum,Amount) %>%
  summarize(
      avg = mean(amount_1[!is.na(amount_1) & amount_1!=0]),
      max = max(amount_1,na.rm=T),
      median = median(amount_1[!is.na(amount_1) & amount_1!=0]),
      mode = FindMode(amount_1[!is.na(amount_1) & amount_1!=0]),
      sum = sum(amount_1[!is.na(amount_1)])
  ) %>%
  mutate(
    amount_avg_1 = ifelse(is.na(avg),1,Amount/avg),
    amount_max_1 = ifelse(max==0,1,Amount/max),
    amount_median_1 = ifelse(is.na(median),1,Amount/median),
    amount_mode_1 = ifelse(is.na(mode),1,Amount/mode),
    amount_sum_1 = ifelse(sum==0,1,Amount/(Amount+sum))
  ) %>%
  select(Recordnum, Amount,amount_avg_1,amount_max_1,amount_median_1,amount_mode_1,amount_sum_1)


data3 = sqldf("
              SELECT a.Recordnum,
              a.Amount, 
              (CASE WHEN a.Recordnum = b.Recordnum THEN 0
                    WHEN b.Fraud = 1 THEN NULL
              WHEN a.Date - b.Date BETWEEN 0 AND 2 AND a.Recordnum != b.Recordnum THEN b.amount 
              ELSE NULL END) AS amount_3
              FROM data a, data b WHERE a.Cardnum = b.Cardnum AND a.Recordnum >= b.Recordnum 
              ")

data_3 = data3 %>%
  group_by(Recordnum,Amount) %>%
  summarize(
    avg = mean(amount_3[!is.na(amount_3) & amount_3!=0]),
    max = max(amount_3,na.rm=T),
    median = median(amount_3[!is.na(amount_3) & amount_3!=0]),
    mode = FindMode(amount_3[!is.na(amount_3) & amount_3!=0]),
    sum = sum(amount_3[!is.na(amount_3)])
  ) %>%
  mutate(
    amount_avg_3 = ifelse(is.na(avg),1,Amount/avg),
    amount_max_3 = ifelse(max==0,1,Amount/max),
    amount_median_3 = ifelse(is.na(median),1,Amount/median),
    amount_mode_3 = ifelse(is.na(mode),1,Amount/mode),
    amount_sum_3 = ifelse(sum==0,1,Amount/(Amount+sum))
  ) %>%
  select(Recordnum, Amount,amount_avg_3,amount_max_3,amount_median_3,amount_mode_3,amount_sum_3)


data7 = sqldf("
              SELECT a.Recordnum,
              a.Amount, 
              (CASE WHEN a.Recordnum = b.Recordnum THEN 0
                    WHEN b.Fraud = 1 THEN NULL
              WHEN a.Date - b.Date BETWEEN 0 AND 6 AND a.Recordnum != b.Recordnum THEN b.amount ELSE NULL END) AS amount_7
              FROM data a, data b WHERE a.Cardnum = b.Cardnum AND a.Recordnum >= b.Recordnum 
              ")

data_7 = data7 %>%
  group_by(Recordnum,Amount) %>%
  summarize(
    avg = mean(amount_7[!is.na(amount_7) & amount_7!=0]),
    max = max(amount_7,na.rm=T),
    median = median(amount_7[!is.na(amount_7) & amount_7!=0]),
    mode = FindMode(amount_7[!is.na(amount_7) & amount_7!=0]),
    sum = sum(amount_7[!is.na(amount_7)])
  ) %>%
  mutate(
    amount_avg_7 = ifelse(is.na(avg),1,Amount/avg),
    amount_max_7 = ifelse(max==0,1,Amount/max),
    amount_median_7 = ifelse(is.na(median),1,Amount/median),
    amount_mode_7 = ifelse(is.na(mode),1,Amount/mode),
    amount_sum_7 = ifelse(sum==0,1,Amount/(Amount+sum))
  ) %>%
  select(Recordnum, Amount,amount_avg_7,amount_max_7,amount_median_7,amount_mode_7,amount_sum_7)

sum(data_7$amount_avg_7[!is.na(data_7$amount_avg_7)])
sum(data_3$amount_avg_3[!is.na(data_3$amount_avg_3)])
sum(data_1$amount_avg_1[!is.na(data_1$amount_avg_1)])
sum(data_14$amount_avg_14[!is.na(data_14$amount_avg_14)])


data14 = sqldf("
              SELECT a.Recordnum,
               a.Amount, 
               (CASE WHEN a.Recordnum = b.Recordnum THEN 0
                    WHEN b.Fraud = 1 THEN NULL
               WHEN a.Date - b.Date BETWEEN 0 AND 13 AND a.Recordnum != b.Recordnum THEN b.amount ELSE NULL END) AS amount_14
               FROM data a, data b WHERE a.Cardnum = b.Cardnum AND a.Recordnum >= b.Recordnum 
               ")

data_14 = data14 %>%
  group_by(Recordnum,Amount) %>%
  summarize(
    avg = mean(amount_14[!is.na(amount_14) & amount_14!=0]),
    max = max(amount_14,na.rm=T),
    median = median(amount_14[!is.na(amount_14) & amount_14!=0]),
    mode = FindMode(amount_14[!is.na(amount_14) & amount_14!=0]),
    sum = sum(amount_14[!is.na(amount_14)])
  ) %>%
  mutate(
    amount_avg_14 = ifelse(is.na(avg),1,Amount/avg),
    amount_max_14 = ifelse(max==0,1,Amount/max),
    amount_median_14 = ifelse(is.na(median),1,Amount/median),
    amount_mode_14 = ifelse(is.na(mode),1,Amount/mode),
    amount_sum_14 = ifelse(sum==0,1,Amount/(Amount+sum))
  ) %>%
  select(Recordnum, Amount,amount_avg_14,amount_max_14,amount_median_14,amount_mode_14,amount_sum_14)

data28 = sqldf("
              SELECT a.Recordnum,
               a.Amount, 
               (CASE WHEN a.Recordnum = b.Recordnum THEN 0
                    WHEN b.Fraud = 1 THEN NULL
               WHEN a.Date - b.Date BETWEEN 0 AND 27 AND a.Recordnum != b.Recordnum THEN b.amount ELSE NULL END) AS amount_28
               FROM data a, data b WHERE a.Cardnum = b.Cardnum AND a.Recordnum >= b.Recordnum 
               ")

data_28 = data28 %>%
  group_by(Recordnum,Amount) %>%
  summarize(
    avg = mean(amount_28[!is.na(amount_28) & amount_28!=0]),
    max = max(amount_28,na.rm=T),
    median = median(amount_28[!is.na(amount_28) & amount_28!=0]),
    mode = FindMode(amount_28[!is.na(amount_28) & amount_28!=0]),
    sum = sum(amount_28[!is.na(amount_28)])
  ) %>%
  mutate(
    amount_avg_28 = ifelse(is.na(avg),1,Amount/avg),
    amount_max_28 = ifelse(max==0,1,Amount/max),
    amount_median_28 = ifelse(is.na(median),1,Amount/median),
    amount_mode_28 = ifelse(is.na(mode),1,Amount/mode),
    amount_sum_28 = ifelse(sum==0,1,Amount/(Amount+sum))
  ) %>%
  select(Recordnum, Amount,amount_avg_28,amount_max_28,amount_median_28,amount_mode_28,amount_sum_28)

#Ratio of transaction amount of a specific Merchantnum and the historical amount averages of this merchant 
#Ratio of transaction amount of a specific Merchantnum and the historical amount maxs of this merchant 
#Ratio of transaction amount of a specific Merchantnum and the historical amount medians of this merchant 
#Ratio of transaction amount of a specific Merchantnum and the historical amount modes of this merchant

merch1 = sqldf("
              SELECT a.Recordnum,
              a.Amount, 
              (CASE WHEN a.Recordnum = b.Recordnum THEN 0
                    WHEN b.Fraud = 1 THEN NULL
              WHEN a.Date = b.Date AND a.Recordnum != b.Recordnum THEN b.amount ELSE NULL END) AS amount_1
              FROM data a, data b WHERE a.Merchantnum = b.Merchantnum AND a.Recordnum >= b.Recordnum 
              ")

merch_1 = merch1 %>%
  group_by(Recordnum,Amount) %>%
  summarize(
    avg = mean(amount_1[!is.na(amount_1) & amount_1!=0]),
    max = max(amount_1,na.rm=T),
    median = median(amount_1[!is.na(amount_1) & amount_1!=0]),
    mode = FindMode(amount_1[!is.na(amount_1) & amount_1!=0]),
    sum = sum(amount_1[!is.na(amount_1)])
  ) %>%
  mutate(
    merch_amount_avg_1 = ifelse(is.na(avg),1,Amount/avg),
    merch_amount_max_1 = ifelse(max==0,1,Amount/max),
    merch_amount_median_1 = ifelse(is.na(median),1,Amount/median),
    merch_amount_mode_1 = ifelse(is.na(mode),1,Amount/mode),
    merch_amount_sum_1 = ifelse(sum==0,1,Amount/(Amount+sum))
  ) %>%
  select(Recordnum, Amount,merch_amount_avg_1,merch_amount_max_1,merch_amount_median_1,merch_amount_mode_1,merch_amount_sum_1)

merch3 = sqldf("
              SELECT a.Recordnum,
              a.Amount, 
              (CASE WHEN a.Recordnum = b.Recordnum THEN 0
                    WHEN b.Fraud = 1 THEN NULL
              WHEN a.Date - b.Date BETWEEN 0 AND 2 AND a.Recordnum != b.Recordnum THEN b.amount ELSE NULL END) AS amount_3
              FROM data a, data b WHERE a.Merchantnum = b.Merchantnum AND a.Recordnum >= b.Recordnum 
              ")

merch_3 = merch3 %>%
  group_by(Recordnum,Amount) %>%
  summarize(
    avg = mean(amount_3[!is.na(amount_3) & amount_3!=0]),
    max = max(amount_3,na.rm=T),
    median = median(amount_3[!is.na(amount_3) & amount_3!=0]),
    mode = FindMode(amount_3[!is.na(amount_3) & amount_3!=0]),
    sum = sum(amount_3[!is.na(amount_3)])
  ) %>%
  mutate(
    merch_amount_avg_3 = ifelse(is.na(avg),1,Amount/avg),
    merch_amount_max_3 = ifelse(max==0,1,Amount/max),
    merch_amount_median_3 = ifelse(is.na(median),1,Amount/median),
    merch_amount_mode_3 = ifelse(is.na(mode),1,Amount/mode),
    merch_amount_sum_3 = ifelse(sum==0,1,Amount/(Amount+sum))
  ) %>%
  select(Recordnum, Amount,merch_amount_avg_3,merch_amount_max_3,merch_amount_median_3,merch_amount_mode_3,merch_amount_sum_3)


merch7 = sqldf("
              SELECT a.Recordnum,
              a.Amount, 
              (CASE WHEN a.Recordnum = b.Recordnum THEN 0
                    WHEN b.Fraud = 1 THEN NULL
              WHEN a.Date - b.Date BETWEEN 0 AND 6 AND a.Recordnum != b.Recordnum THEN b.amount ELSE NULL END) AS amount_7
              FROM data a, data b WHERE a.Merchantnum = b.Merchantnum AND a.Recordnum >= b.Recordnum 
              ")

merch_7 = merch7 %>%
  group_by(Recordnum,Amount) %>%
  summarize(
    avg = mean(amount_7[!is.na(amount_7) & amount_7!=0]),
    max = max(amount_7,na.rm=T),
    median = median(amount_7[!is.na(amount_7) & amount_7!=0]),
    mode = FindMode(amount_7[!is.na(amount_7) & amount_7!=0]),
    sum = sum(amount_7[!is.na(amount_7)])
  ) %>%
  mutate(
    merch_amount_avg_7 = ifelse(is.na(avg),1,Amount/avg),
    merch_amount_max_7 = ifelse(max==0,1,Amount/max),
    merch_amount_median_7 = ifelse(is.na(median),1,Amount/median),
    merch_amount_mode_7 = ifelse(is.na(mode),1,Amount/mode),
    merch_amount_sum_7 = ifelse(sum==0,1,Amount/(Amount+sum))
  ) %>%
  select(Recordnum, Amount,merch_amount_avg_7,merch_amount_max_7,merch_amount_median_7,merch_amount_mode_7,merch_amount_sum_7)


merch14 = sqldf("
               SELECT a.Recordnum,
               a.Amount, 
               (CASE WHEN a.Recordnum = b.Recordnum THEN 0
                    WHEN b.Fraud = 1 THEN NULL
               WHEN a.Date - b.Date BETWEEN 0 AND 13 AND a.Recordnum != b.Recordnum THEN b.amount ELSE NULL END) AS amount_14
               FROM data a, data b WHERE a.Merchantnum = b.Merchantnum AND a.Recordnum >= b.Recordnum 
               ")

merch_14 = merch14 %>%
  group_by(Recordnum,Amount) %>%
  summarize(
    avg = mean(amount_14[!is.na(amount_14) & amount_14!=0]),
    max = max(amount_14,na.rm=T),
    median = median(amount_14[!is.na(amount_14) & amount_14!=0]),
    mode = FindMode(amount_14[!is.na(amount_14) & amount_14!=0]),
    sum = sum(amount_14[!is.na(amount_14)])
  ) %>%
  mutate(
    merch_amount_avg_14 = ifelse(is.na(avg),1,Amount/avg),
    merch_amount_max_14 = ifelse(max==0,1,Amount/max),
    merch_amount_median_14 = ifelse(is.na(median),1,Amount/median),
    merch_amount_mode_14 = ifelse(is.na(mode),1,Amount/mode),
    merch_amount_sum_14 = ifelse(sum==0,1,Amount/(Amount+sum))
  ) %>%
  select(Recordnum, Amount,merch_amount_avg_14,merch_amount_max_14,merch_amount_median_14,merch_amount_mode_14,merch_amount_sum_14)

merch28 = sqldf("
               SELECT a.Recordnum,
               a.Amount, 
               (CASE WHEN a.Recordnum = b.Recordnum THEN 0
                    WHEN b.Fraud = 1 THEN NULL
               WHEN a.Date - b.Date BETWEEN 0 AND 27 AND a.Recordnum != b.Recordnum THEN b.amount ELSE NULL END) AS amount_28
               FROM data a, data b WHERE a.Merchantnum = b.Merchantnum AND a.Recordnum >= b.Recordnum 
               ")

merch_28 = merch28 %>%
  group_by(Recordnum,Amount) %>%
  summarize(
    avg = mean(amount_28[!is.na(amount_28) & amount_28!=0]),
    max = max(amount_28,na.rm=T),
    median = median(amount_28[!is.na(amount_28) & amount_28!=0]),
    mode = FindMode(amount_28[!is.na(amount_28) & amount_28!=0]),
    sum = sum(amount_28[!is.na(amount_28)])
  ) %>%
  mutate(
    merch_amount_avg_28 = ifelse(is.na(avg),1,Amount/avg),
    merch_amount_max_28 = ifelse(max==0,1,Amount/max),
    merch_amount_median_28 = ifelse(is.na(median),1,Amount/median),
    merch_amount_mode_28 = ifelse(is.na(mode),1,Amount/mode),
    merch_amount_sum_28 = ifelse(sum==0,1,Amount/(Amount+sum))
  ) %>%
  select(Recordnum, Amount,merch_amount_avg_28,merch_amount_max_28,merch_amount_median_28,merch_amount_mode_28,merch_amount_sum_28)

# merge dataset
week_data<-read.csv("week variable.csv")
last_trans<-read.csv("last_transaction_distance.csv")
last_trans<-last_trans%>%
  arrange(Recordnum)
final_data<-data.frame(data[,c(1,10)],data[,9],samecard[,-1],samemerch[,-1],
                          data_1[,-c(1,2)],
                          data_3[,-c(1,2)],
                          data_7[,-c(1,2)],
                          data_14[,-c(1,2)],
                          data_28[,-c(1,2)],
                          merch_1[,-c(1,2)],
                          merch_3[,-c(1,2)],
                          merch_7[,-c(1,2)],
                          merch_14[,-c(1,2)],
                          merch_28[,-c(1,2)],
                          last_trans[,-2],
                          week_data[,-c(1,2)])
# write.csv(final_data,"final_data.csv")
