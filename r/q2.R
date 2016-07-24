#!/usr/bin/Rscript
cwd <- getwd()
setwd(cwd)

#sink to redirect stdout to file

source(file=file.path(cwd,'/r/ruleFunctions.R'))

s1 <- read.csv('q2/cuisineCharacters2.csv')

ruleModel <- ruleGen.c50(d=s1,form =  cuisine ~ .,trialNum = 10,winnow = TRUE)


c50Summary <- capture.output(summary(ruleModel))
cat(c50Summary,file = file.path(cwd,'q2','c50_10Trials2.txt'),sep="\n")
