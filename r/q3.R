#!/usr/bin/Rscript

library(arules)
cwd <- getwd()
setwd(cwd)

#sink to redirect stdout to file

q3Data <- read.csv('q3/restaurantsq3.csv')



# minLen = 2, maxLen = 50,
# sup = 0.005, conf = 0.005, targ = 'rules',
# rH = NULL, lH = NULL, deflt = 'lhs')
q3A <- function(){
  q3A_lh <- unlist(c(cuisine_atmosphere$s1, cuisine_atmosphere$s2),use.names = F)
  q3Arules <- apriori(q3Data,
    parameter = list(
      minlen = 2,
      maxlen = 30,
      supp = 0.0005,
      confidence = 0.0005,
      target = "rules"
    ),
    appearance = list(lhs=q3A_lh,default='rhs'),
    control = list(verbose = F, filter = 0)
  )
  inspect(q3Arules)
}

q3A()


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