#!/usr/bin/Rscript
cwd <- getwd()
setwd(cwd)

#sink to redirect stdout to file

source(file=file.path(cwd,'/r/ruleFunctions.R'))

s1 <- read.csv('q2/cuisineCharactersUnique3.csv')

ruleModel <- ruleGen.c50(d=s1,form =  cuisine ~ .,trialNum = 10,winnow = TRUE)

summary(ruleModel)

rulesFit <- ruleGen.part(s1,form=cuisine ~ .)