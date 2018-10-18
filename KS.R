good = filter(train, is_attributed == 0)
bad = filter(train, is_attributed == 1)
var_ks = data.frame()
for (i in c(2:49, 52:76)){
  idx = i
  variable = colnames(train)[i]
  ks_result = ks.test(good[,i], bad[,i], alternative = "two.sided")
  ks = ks_result$statistic[[1]]
  p = ks_result$p.value[[1]]
  var_ks = rbind(var_ks, data.frame(idx, variable, ks, p))
}
index = var_ks %>%
  filter(p < 0.05) %>%
  arrange(-ks) %>%
  select(idx) %>%
  unlist(use.names = FALSE)
train1 = train[,c(index, 51)]