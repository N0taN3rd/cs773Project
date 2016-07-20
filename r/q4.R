library(lsr)
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

cfq_lmSum <- capture.output(summary(cfq_lm))
cat(cfq_lmSum,file = file.path(cwd,'q4','cuisine_quality_spread_summary.txt'),sep="\n")

plot(cfq_lm)

cuisine_fqd_spread$cuisine <- as.numeric(cuisine_fqd_spread$cuisine)

cfqd_lm <-
  lm(cuisine ~ Good + Fair + Excellent, data = cuisine_fqd_spread)

cfqd_lmSum <- capture.output(summary(cfqd_lm))
cat(cfqd_lmSum,file = file.path(cwd,'q4','cuisine_qualityD_spread_summary.txt'),sep="\n")

summary(cfqd_lm)
plot(cfqd_lm)

cuisine_fq_spread <- q4DataList$cq_spread
cuisine_fqd_spread <- q4DataList$cqD_spread

cfq_glm <-
  glm(
    cuisine ~ `Excellent Food` + `Extraordinary Food` + `Fair Food` + `Good Food` + `Near-perfect Food`,
    family= binomial(link = "logit"),
    data = cuisine_fq_spread
  )

cfq_norm_gmSum <- capture.output(summary(cfq_glm))
cat(cfq_norm_lmSum,file = file.path(cwd,'q4','cuisine_quality_GLM_summary.txt'),sep="\n")
summary(cfq_glm)
plot(cfq_glm)

cfqd_glm <-
  glm(
    cuisine ~ Good + Fair + Excellent, 
    family = 
      binomial(link = "logit"),
    data = cuisine_fqd_spread
  )

cfqd_gmSum <- capture.output(summary(cfqd_glm))
cat(cfqd_gmSum,file = file.path(cwd,'q4','cuisine_qualityD_GLM_summary.txt'),sep="\n")

summary(cfqd_glm)
plot(cfqd_glm)



