library(lsr)
library(ggplot2)
cwd <- getwd()
setwd(cwd)
source(file = file.path(cwd, 'r', 'helpers.R'))

q4DataList <- helpers.q4()

q4Data <- q4DataList$q4Data


par(mfrow=c(2,2))

# table(q4Data)

cuisine_foodQuality <- q4DataList$cfq
cuisine_foodQualityD <- q4DataList$cfqd
cuisine_fq_spread <- q4DataList$cq_spread
cuisine_fqd_spread <- q4DataList$cqD_spread
cuisine_fqSides <- q4DataList$cfqSide

c_fq_numeric = data.frame(
  cuisine = as.numeric(cuisine_foodQuality$cuisine),
  quality = as.numeric(cuisine_foodQuality$quality)
)

cuisine_fq_spread$cuisine <- as.numeric(cuisine_fq_spread$cuisine)


cfq_lm <-
  lm(
    cuisine ~ `Excellent Food` + `Extraordinary Food` + `Fair Food` + `Good Food` + `Near-perfect Food`,
    data = cuisine_fq_spread
  )

plot(cfq_lm)

cuisine_fqd_spread$cuisine <- as.numeric(cuisine_fqd_spread$cuisine)
cfqd_lm <-
  lm(cuisine ~ Good + Fair + Excellent, data = cuisine_fqd_spread)

plot(cfqd_lm)


# cfq_glm <- glm(cuisine ~ Fair+Good+Excellent,family=binomial(link='logit'),data = cuisine_fq_spread)


confint(cuisine_fq_fit)
anova(cuisine_fq_fit)
anovaFit <- aov(quality ~ cuisine , data = cuisine_foodQualityD)
summary(cuisine_fq_fit)
plot(cuisine_fq_fit)

ftable(freqTable)

helpers.GKtau(cuisine_foodQuality$cuisine, cuisine_foodQuality$atmosphere)
cuisine_foodQuality$cuisine



write.csv(
  x = c_fq_numeric,
  file = file.path(cwd, 'q4', 'rgp_data.csv'),
  fileEncoding = 'utf8',
  row.names = F
)

help(package = "reshape2")
