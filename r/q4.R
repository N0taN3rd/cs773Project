library(lsr)
library(ggplot2)
cwd <- getwd()
setwd(cwd)
source(file = file.path(cwd, 'r', 'helpers.R'))

q4DataList <- helpers.q4()

q4Data <- q4DataList$q4Data


# table(q4Data)

cuisine_foodQuality <- q4DataList$cfq
cuisine_foodQualityD <- q4DataList$cfqd
cuisine_fq_spread <- q4DataList$cq_spread
cuisine_fqd_spread <- q4DataList$cqD_spread
cuisine_fqSides <- q4DataList$cfqSide

c_fq_numeric = data.frame(cuisine=as.numeric(cuisine_foodQuality$cuisine),quality=as.numeric(cuisine_foodQuality$quality))


cuisine_fq_fit <- glm(cuisine ~ Fair+Good+Excellent,family=binomial(link='logit'),data = cuisine_fqd_spread)

fit_frame <- data.frame(Fitted= fitted(cuisine_fq_fit),Residuals = residuals(cuisine_fq_fit),Val=cuisine_foodQualityD$quality)

confint(cuisine_fq_fit)
anova(cuisine_fq_fit)
anovaFit <- aov(quality ~ cuisine , data=cuisine_foodQualityD)
summary(cuisine_fq_fit)
plot(cuisine_fq_fit)

ftable(freqTable)

helpers.GKtau(cuisine_foodQuality$cuisine,cuisine_foodQuality$atmosphere)
cuisine_foodQuality$cuisine



write.csv(x = c_fq_numeric,file = file.path(cwd,'q4','rgp_data.csv'),fileEncoding = 'utf8',row.names = F)

help(package = "reshape2")
