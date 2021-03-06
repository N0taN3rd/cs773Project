library(caret)
library(arules)
library(C50)
library(Rsenal)
library(rpart)


ruleGen.c50 <- function(d,
                        form,
                        trialNum = 4,
                        winnow = FALSE) {
  C5.0(
    formula = form,
    data = d,
    trials = trialNum,
    control = C5.0Control(subset = TRUE, winnow = winnow),
    rules = TRUE
  )
}

ruleGen.apriori <-
  function(data, minLen = 2, maxLen = 15,
           sup = 0.005, conf = 0.005, targ = 'rules',
           rH = NULL, lH = NULL, deflt = 'lhs',list=F) {
    appear <- NULL
    lhNull <- is.null(lH)
    rhNull <- is.null(rH)
    if (!lhNull && !rhNull) {
      appear <- list(rhs = rH,
                     lhs = lH,
                     default = deflt)
    } else if (!lhNull && rhNull) {
      appear <- list(lhs = lH,
                     default = deflt)
    } else if (lhNull && !rhNull) {
      appear <- list(rhs = rH,
                     default = deflt)
    } else {
      appear <- list(default = 'both')
    }
    
    rules <- apriori(
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
    
    if(length(rules) > 0) {
      rules2df(addRuleQuality(
        trans = data,
        rules = rules,
        exclude =  c(
          "hyperConfidence", 
          "cosine",
          "chiSquare",
          "coverage",
          "doc",
          "gini",
          "hyperLift",
          "fishersExactTest",
          "improvement",
          "leverage",
          "oddsRatio",
          "phi",
          "RLD"
        )
      ), list = list)
    } else {
      'no rules'
    }
   
}

ruleGen.part <- function(data, form) {
  train(form, data = data, method = "PART")
}

ruleGen.appearance_pair_list <- function(df,notFromHelper=F) {
  # browser()
  if(notFromHelper){
    unlist(c(levels(unique(df$s1)), levels(unique(df$s2))),use.names=F)
  } else {
    unlist(c(unique(df$s1), unique(df$s2)),use.names=F)
    # isS1_list = is.list(df$s1)
    # isS2_list = is.list(df$s2)
    # 
    # if(isS1_list && isS2_list) {
    #   unlist(c(unique(df$s1), unique(df$s2)),use.names=F)
    # } else if(!isS1_list && isS2_list){
    #   unlist(c(df$s1, unique(df$s2)),use.names=F)
    # } else {
    #   unlist(c(unique(df$s1), df$s2),use.names=F)
    # }
  }
}

ruleGen.rules_apriori_lh <- function(data,feature_pair,notFromHelper=F,sup=0.0005, conf = 0.0005,minLen = 2, maxLen = 15, list=F)  {
  rlh <- ruleGen.appearance_pair_list(feature_pair, notFromHelper = notFromHelper)
  ruleGen.apriori(
    data,
    lH = rlh,
    sup = sup,
    conf = conf,
    minLen = minLen,
    maxLen = maxLen,
    deflt = 'rhs',
    list=list
  )
}

ruleGen.rules_apriori_lhGrouped <- function(data,lhs_grouped,notFromHelper=F,sup=0.0005, conf = 0.0005,minLen = 2, maxLen = 15, list=F)  {

  ruleGen.apriori(
    data,
    lH = rlh,
    sup = sup,
    conf = conf,
    minLen = minLen,
    maxLen = maxLen,
    deflt = 'rhs',
    list=list
  )
}

ruleGen.rules_to_df <- function(rules,list=F){
  rules2df(rules,list=list)
}
