#!/usr/bin/Rscript
library(dplyr)
cwd <- getwd()
setwd(cwd)

#sink to redirect stdout to file

source(file=file.path(cwd,'r/ruleFunctions.R'))

s1 <- read.csv('q2/cuisineCharactersUnique3.csv')



# rhs = c(
#   'cuisine=American',
#   'cuisine=French',
#   'cuisine=Indian',
#   'cuisine=Mexican',
#   'cuisine=Italian'
# )

rhs = c(
  ''
)
lhs = c(
  'atmosphere'
)


test <- function(data,...) {
  lzy <- lazyeval::lazy_dots(...)[[1]]
  dist <- data %>% distinct(...) %>% mutate(side=paste(lzy$expr,lazyeval::lazy(lzy),sep='='))
  print(dist)
}
test(s1,atmosphere)
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