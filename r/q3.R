#!/usr/bin/Rscript

cwd <- getwd()
setwd(cwd)

source(file=file.path(cwd,'r','ruleFunctions.R'))
source(file=file.path(cwd,'r','helpers.R'))

q3DataList <- helpers.q3()


#### Q3.A
a_rules <- ruleGen.rules_apriori_lh(q3DataList$q3Data,q3DataList$ca)

grouped = helpers.group_by_lhs(a_rules)


#### Q3.B

b_rules <- ruleGen.rules_apriori_lh(q3DataList$q3Data,q3DataList$ap)

# rlhs <- q3A_rules@rhs
# inspect(q3A_rules)
# 
# inspect(subset(q3A_rules, subset = rhs %pin% "style"))


# q3Data <- q3DataList$q3Data
# 
# cuisine_atmosphere <- q3DataList$ca
# cuisine_occasion <- q3DataList$co
# cuisine_price  <- q3DataList$cp
# cuisine_style  <- q3DataList$cs
# 
# atmosphere_occasion <- q3DataList$ao
# atmosphere_price <- q3DataList$ap 
# atmosphere_style <- q3DataList$as
# 
# occasion_price <- q3DataList$op
# occasion_style <- q3DataList$os
# 
# style_price <- q3DataList$sp




#
# distinct(s1,as.name('atmosphere'))
#
# sub <- ruleGen.ruleSubset(s1,atmosphere)
# s1 %>% distinct(atmosphere) %>% mutate(side = paste('atmosphere',atmosphere,sep='='))
# at <- distinct(s1,atmosphere)
#
# rules <- ruleGen.apriori(s1,lH=lhs)
#
# inspect(rules)