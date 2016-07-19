#!/usr/bin/Rscript
cwd <- getwd()
setwd(cwd)

q3Dir <- file.path(cwd, 'q3')


source(file = file.path(cwd, 'r', 'helpers.R'))
source(file = file.path(cwd, 'r', 'ruleFunctions.R'))

q3DataList <- helpers.q3()

styleFiltered <-
  helpers.filter_df(q3DataList$q3Data, style != 'none')

#### Q3.A
a_rules <- ruleGen.rules_apriori_lh(q3DataList$q3Data, q3DataList$ca)
a_rules <- subset(a_rules, confidence >= 0.49)

a_rules_no_noneStyle <-
  ruleGen.rules_apriori_lh(styleFiltered, q3DataList$ca)
a_rules_no_noneStyle <-
  subset(a_rules_no_noneStyle , confidence >= 0.49)

a_pairs <- helpers.s1_s2_pairs(q3DataList$ca)

a_rules_filter <-
  a_rules[a_rules$lhs %in% a_pairs$lhs1 |
            a_rules$lhs %in% a_pairs$lhs2, ]
a_rules_filter <- subset(a_rules_filter, confidence >= 0.49)

a_rules_pair_noneStyle <-
  a_rules_no_noneStyle[a_rules_no_noneStyle$lhs %in% a_pairs$lhs1 |
                         a_rules_no_noneStyle$lhs %in% a_pairs$lhs2 , ]
a_rules_pair_noneStyle  <-
  subset(a_rules_no_noneStyle, confidence >= 0.49)

write.csv(
  a_rules,
  file = file.path(q3Dir, 'q3a_rule.csv'),
  fileEncoding = 'utf8',
  row.names = F
)
write.csv(
  a_rules_no_noneStyle,
  file = file.path(q3Dir, 'q3a_rule_NNS.csv'),
  fileEncoding = 'utf8',
  row.names = F
)
write.csv(
  a_rules_filter,
  file = file.path(q3Dir, 'q3a_rule_pairFilter.csv'),
  fileEncoding = 'utf8',
  row.names = F
)
write.csv(
  a_rules_pair_noneStyle,
  file = file.path(q3Dir, 'q3a_rule_NNS.csv'),
  fileEncoding = 'utf8',
  row.names = F
)

#### Q3.B
b_rules <- ruleGen.rules_apriori_lh(q3DataList$q3Data, q3DataList$ap)
b_rules <- subset(b_rules, confidence >= 0.49)
b_rules_no_noneStyle <-
  ruleGen.rules_apriori_lh(styleFiltered, q3DataList$ap)
b_rules_no_noneStyle <-
  subset(b_rules_no_noneStyle, confidence >= 0.49)
# b_cumaliative_rules = helpers.group_by_lhs(b_rules_no_noneStyle)

b_pairs <- helpers.s1_s2_pairs(q3DataList$ap)

b_rules_filter <-
  b_rules[b_rules$lhs %in% b_pairs$lhs1 |
            b_rules$lhs %in% b_pairs$lhs2, ]
b_rules_filter <- subset(b_rules_filter, confidence >= 0.49)
b_rulesNSN_filter <-
  b_rules_no_noneStyle[b_rules_no_noneStyle$lhs %in% b_pairs$lhs1 |
                         b_rules_no_noneStyle$lhs %in% b_pairs$lhs2, ]
b_rulesNSN_filter <- subset(b_rulesNSN_filter , confidence >= 0.49)

write.csv(
  b_rules,
  file = file.path(q3Dir, 'q3b_rule.csv'),
  fileEncoding = 'utf8',
  row.names = F
)
write.csv(
  b_rules_no_noneStyle,
  file = file.path(q3Dir, 'q3b_rule_NNS.csv'),
  fileEncoding = 'utf8',
  row.names = F
)
write.csv(
  b_rules_filter,
  file = file.path(q3Dir, 'q3b_rule_pairFilter.csv'),
  fileEncoding = 'utf8',
  row.names = F
)
write.csv(
  b_rulesNSN_filter,
  file = file.path(q3Dir, 'q3b_rule_NNS.csv'),
  fileEncoding = 'utf8',
  row.names = F
)

#### Q3.C
c_rules <- ruleGen.rules_apriori_lh(q3DataList$q3Data, q3DataList$sp)
c_rules <- subset(c_rules, confidence >= 0.49)
c_rules_no_noneStyle <-
  ruleGen.rules_apriori_lh(styleFiltered, q3DataList$sp)
c_rules_no_noneStyle  <-
  subset(c_rules_no_noneStyle , confidence >= 0.49)
# c_cumaliative_rules = helpers.group_by_lhs(c_rules_no_noneStyle)

c_pairs <- helpers.s1_s2_pairs(q3DataList$sp)

c_rules_filter <-
  c_rules[c_rules$lhs %in% c_pairs$lhs1 |
            c_rules$lhs %in% c_pairs$lhs2, ]
c_rulesNSN_filter <-
  c_rules_no_noneStyle[c_rules_no_noneStyle$lhs %in% c_pairs$lhs1 |
                         c_rules_no_noneStyle$lhs %in% c_pairs$lhs2, ]

write.csv(
  c_rules,
  file = file.path(q3Dir, 'q3c_rule.csv'),
  fileEncoding = 'utf8',
  row.names = F
)
write.csv(
  c_rules_no_noneStyle,
  file = file.path(q3Dir, 'q3c_rule_NNS.csv'),
  fileEncoding = 'utf8',
  row.names = F
)
write.csv(
  c_rules_filter,
  file = file.path(q3Dir, 'q3c_rule_pairFilter.csv'),
  fileEncoding = 'utf8',
  row.names = F
)
write.csv(
  c_rulesNSN_filter,
  file = file.path(q3Dir, 'q3c_rule_NNS.csv'),
  fileEncoding = 'utf8',
  row.names = F
)

#### Q3.D
d_rules <- ruleGen.rules_apriori_lh(q3DataList$q3Data, q3DataList$co)
d_rules <- subset(d_rules, confidence >= 0.49)
d_rules_no_noneStyle <-
  ruleGen.rules_apriori_lh(styleFiltered, q3DataList$co)
d_rules_no_noneStyle  <-
  subset(d_rules_no_noneStyle , confidence >= 0.49)
# d_cumaliative_rules = helpers.group_by_lhs(d_rules_no_noneStyle)

d_pairs <- helpers.s1_s2_pairs(q3DataList$co)

d_rules_filter <-
  d_rules[d_rules$lhs %in% d_pairs$lhs1 |
            d_rules$lhs %in% d_pairs$lhs2, ]
d_rules_filter <- subset(d_rules_filter, confidence >= 0.49)
d_rulesNSN_filter <-
  d_rules_no_noneStyle[d_rules_no_noneStyle$lhs %in% d_pairs$lhs1 |
                         d_rules_no_noneStyle$lhs %in% d_pairs$lh2, ]
d_rulesNSN_filter <- subset(d_rulesNSN_filter, confidence >= 0.49)

write.csv(
  d_rules,
  file = file.path(q3Dir, 'q3d_rule.csv'),
  fileEncoding = 'utf8',
  row.names = F
)
write.csv(
  d_rules_no_noneStyle,
  file = file.path(q3Dir, 'q3d_rule_NNS.csv'),
  fileEncoding = 'utf8',
  row.names = F
)
write.csv(
  d_rules_filter,
  file = file.path(q3Dir, 'q3d_rule_pairFilter.csv'),
  fileEncoding = 'utf8',
  row.names = F
)
write.csv(
  d_rulesNSN_filter,
  file = file.path(q3Dir, 'q3d_rule_pairFilter_NNS.csv'),
  fileEncoding = 'utf8',
  row.names = F
)

#### Q3.E
e_rules <- ruleGen.rules_apriori_lh(q3DataList$q3Data, q3DataList$dp)
e_rules <- subset(e_rules, confidence >= 0.49)
e_rules_no_noneStyle <-
  ruleGen.rules_apriori_lh(styleFiltered, q3DataList$dp)
e_rules_no_noneStyle  <-
  subset(e_rules_no_noneStyle , confidence >= 0.49)
# e_cumaliative_rules = helpers.group_by_lhs(e_rules_no_noneStyle)

e_pairs <- helpers.s1_s2_pairs(q3DataList$dp)

e_rules_filter <-
  e_rules[e_rules$lhs %in% e_pairs$lhs1 |
            e_rules$lhs %in% e_pairs$lhs2, ]
e_rules_filter <- subset(e_rules_filter, confidence >= 0.49)
e_rulesNSN_filter <-
  e_rules_no_noneStyle[e_rules_no_noneStyle$lhs %in% e_pairs$lhs1 |
                         e_rules_no_noneStyle$lhs %in% e_pairs$lhs2, ]
e_rulesNSN_filter <- subset(e_rulesNSN_filter, confidence >= 0.49)

write.csv(
  e_rules,
  file = file.path(q3Dir, 'q3e_rule.csv'),
  fileEncoding = 'utf8',
  row.names = F
)
write.csv(
  e_rules_no_noneStyle,
  file = file.path(q3Dir, 'q3e_rule_NNS.csv'),
  fileEncoding = 'utf8',
  row.names = F
)
write.csv(
  e_rules_filter,
  file = file.path(q3Dir, 'q3e_rule_pairFilter.csv'),
  fileEncoding = 'utf8',
  row.names = F
)
write.csv(
  e_rulesNSN_filter,
  file = file.path(q3Dir, 'q3e_rule_NNS.csv'),
  fileEncoding = 'utf8',
  row.names = F
)

### everything

all_data_rules <- ruleGen.apriori(q3DataList$q3Data)
all_data_rules <- subset(all_data_rules, confidence >= 0.49)

all_data_rule_noStyleNone <- ruleGen.apriori(styleFiltered)
all_data_rule_noStyleNone <-
  subset(all_data_rule_noStyleNone, confidence >= 0.49)

write.csv(
  all_data_rules,
  file = file.path(q3Dir, 'q3All_rule.csv'),
  fileEncoding = 'utf8',
  row.names = F
)
write.csv(
  all_data_rule_noStyleNone,
  file = file.path(q3Dir, 'q3All_rule_NNS.csv'),
  fileEncoding = 'utf8',
  row.names = F
)

unique_features <- helpers.unqiue_all(q3DataList$q3Data)
