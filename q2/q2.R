library(arules)

setwd(getwd()) 


s1 <- read.csv('q2/cuisineCharactersUnique3.csv')

rules <-
  apriori(
    s1,
    parameter = list(
      minlen=1,
      maxlen=4,
      supp=0.005, 
      confidence=0.005
    ),
    appearance = list(rhs=c('cuisine=American','cuisine=French'),default = 'lhs'),
    control = list(verbose = F)
  )

inspect(rules)
