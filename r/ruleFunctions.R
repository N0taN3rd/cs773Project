library(caret)
library(arules)
library(C50)

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
  function(data, minLen = 2, maxLen = 50,
           sup = 0.005, conf = 0.005, targ = 'rules',
           rH = NULL, lH = NULL, deflt = 'lhs') {
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
    } else {
      appear <- list(rhs = rH,
                     default = deflt)
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
