#!/usr/bin/Rscript
library(dplyr)
cwd <- getwd()
setwd(cwd)
  
#sink to redirect stdout to file

source(file=file.path(cwd,'r/ruleFunctions.R'))

q3Data <- read.csv('q3/restaurantsq3.csv')

cuisine_appearance <- q3Data %>% distinct(cuisine) %>% transmute(side = paste('cuisine',cuisine,sep='=')) 
atmosphere_appearance <- q3Data %>% distinct(atmosphere) %>% transmute(side = paste('atmosphere',atmosphere,sep='='))
occasion_appearance <- q3Data %>% distinct(occasion) %>% transmute(side = paste('occasion',occasion,sep='=')) 
price_appearance <- q3Data %>% distinct(price) %>% transmute(side = paste('price',price,sep='='))
style_appearance <- q3Data %>% distinct(style) %>% transmute(side = paste('style',style,sep='=')) 

q3A <- function(){
  q3A_lh <- unlist(c(cuisine_appearance$side, atmosphere_appearance$side),use.names = F)
  q3A_rh <- unlist(c(occasion_appearance$side, price_appearance,style_appearance$side),use.names = F)
  q3Arules <- ruleGen.apriori(q3Data,lH=q3A_lh,  rH=q3A_rh)
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