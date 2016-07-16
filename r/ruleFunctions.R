library(caret)
library(arules)
library(C50)
library(dplyr)


ruleGen.ruleSubset <- function(data,...) {
  args <- as.list(match.call())
  print(eval(args$col, data))
  dist <- data %>% distinct(...) %>%  mutate(side = paste('#(col)',...,sep='='))
  print(dist)
 # sub <- data %>% distinct('#(col)') %>% mutate(side = paste('#(col)','#(col)',sep='=')) 
 # sub$side
}

ruleGen.c50 <- function(d, form, trialNum = 4, winnow = FALSE) {
  C5.0(
    formula = form,
    data = d,
    trials = trialNum,
    control = C5.0Control(subset = TRUE, winnow = winnow),
    rules = TRUE
  )
}

ruleGen.apriori <-
  function(data, minLen = 2, maxLen = 15, sup = 0.005,
           conf = 0.005, targ = 'rules', rH=NULL, lH = NULL) {
    appear <- NULL
    lhNull <- is.null(lH)
    rhNull <- is.null(rH)
    if (!lhNull && !rhNull) {
      appear <- list(rhs = rH,
                     lhs = lH,
                     default = 'lhs')
    } else if(!lhNull && rhNull) {
      appear <- list(lhs = lH,
                     default = 'lhs')
    } else {
      appear <- list(rhs = rH,
                     default = 'lhs')
    }
    
    apriori(
      data,
      parameter = list(
        minlen = minLen,
        maxlen = maxLen,
        supp = sup,
        confidence = conf,
        target = targ
      ),
      appearance = appear,
      control = list(verbose = F, filter = 0)
    )
  }

ruleGen.part <- function(data, form) {
  train(form, data = data, method = "PART")
}
