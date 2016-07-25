library(dplyr)
library(tidyr)
library(purrr)
library(stringr)
library(reshape2)
library(foreach)
library(iterators)

setwd(getwd())

helpers.filter_df <- function(data,...) {
  data %>% filter(...)
}


helpers.select_rules_quality <- function(data) {
  data %>% select(rules,support,confidence,lift,conviction)
}

helpers.orderConfidence <- function(data) {
  data[with(data,order(confidence,decreasing = T)),]
}

helpers.unqiue_all <- function(data) {
 
  ucuisine <- data %>% select(cuisine) %>% distinct 
  uatmosphere <- data %>% select(atmosphere) %>% distinct
  uoccasion <- data %>% select(occasion) %>% distinct
  uprice <- data %>% select(price) %>% distinct
  ustyle <- data %>% select(style) %>% distinct
  
  list(
   c = ucuisine,
   a = uatmosphere,
   o = uoccasion,
   p = uprice,
   s = ustyle
  )
}

helpers.test <- function(d,sides,...) {
  # it <- sides %>% by_row(function(r)
  #   c(str_trim(r$s1, side = c(
  #     "both", "left", "right"
  #   )), str_trim(r$s2, side = c(
  #     "both", "left", "right"
  #   ))), .to = 'rdf')
  # 
   foreach(r = iter(sides,by='row'),.combine = c) %do% {
    print(d %>% select(cuisine == r$s1 & atmosphere == r$s2))
    pair <- c(r$s1,r$s2)
    1
  }
  # View(it)
}




helpers.s1_to_groupedS2 <- function(d,sides,rulesFun) {
  sides %>% group_by(s1) %>% summarise(s2 = list(s2)) %>% 
    by_row(function(r) unlist(list(r$s1,r$s2)), .to='lhs') %>% 
    by_row(function(r)  do.call(rulesFun,list(data=d,lH = r$lhs, deflt = 'rhs' )), .to='rdf')
}


helpers.s1_s2_pairs <- function(sides) {
  sides %>% mutate(lhs1 = paste(s1,s2,sep=','),lhs2 = paste(s2,s1,sep=','))
}


helpers.pair_count <- function(df) {
  df %>% summarise()
}

helpers.q3 <- function(write = F, filter = NULL) {
  data <-
    read.csv(file.path('q3','restaurantsq3.csv')) 
  
  filter <- !is.null(filter)
  
  cuisine_atmosphere <-
    data %>% select(cuisine, atmosphere) %>% distinct %>%
    filter(cuisine != 'none' & atmosphere != 'none') %>%
    transmute(
      s1 = paste('cuisine', cuisine, sep = '='),
      s2 = paste('atmosphere', atmosphere, sep = '=')
    )
  
  cuisine_occasion <-
    data %>% select(cuisine, occasion) %>% distinct %>%
    filter(cuisine != 'none' & occasion != 'none') %>%
    transmute(
      s1 = paste('cuisine', cuisine, sep = '='),
      s2 = paste('occasion', occasion, sep = '=')
    )
  
  cuisine_price <-
    data %>% select(cuisine, price) %>% distinct  %>%
    filter(cuisine != 'none' & price != 'none') %>%
    transmute(s1 = paste('cuisine', cuisine, sep = '='),
              s2 = paste('price', price, sep = '='))
  
  cuisine_style <-
    data %>% select(cuisine, style) %>% distinct  %>%
    filter(cuisine != 'none' & style != 'none') %>%
    transmute(s1 = paste('cuisine', cuisine, sep = '='),
              s2 = paste('style', style, sep = '='))
  
  atmosphere_occasion <-
    data %>% select(atmosphere, occasion) %>% distinct  %>%
    filter(atmosphere != 'none' & occasion != 'none') %>%
    transmute(
      s1 = paste('atmosphere', atmosphere, sep = '='),
      s2 = paste('occasion', occasion, sep = '=')
    )
  
  atmosphere_price <-
    data %>% select(atmosphere, price) %>% distinct  %>%
    filter(atmosphere != 'none' & price != 'none') %>%
    transmute(
      s1 = paste('atmosphere', atmosphere, sep = '='),
      s2 = paste('price', price, sep = '=')
    )
  
  atmosphere_style <-
    data %>% select(atmosphere, style) %>% distinct  %>%
    filter(atmosphere != 'none' & style != 'none') %>%
    transmute(
      s1 = paste('atmosphere', atmosphere, sep = '='),
      s2 = paste('style', style, sep = '=')
    )
  
  occasion_price <-
    data %>% select(occasion, price) %>% distinct  %>%
    filter(occasion != 'none' & price != 'none') %>%
    transmute(
      s1 = paste('occasion', occasion, sep = '='),
      s2 = paste('price', price, sep = '=')
    )
  
  occasion_style <-
    data %>% select(occasion, style) %>% distinct  %>%
    filter(occasion != 'none' & style != 'none') %>%
    transmute(
      s1 = paste('occasion', occasion, sep = '='),
      s2 = paste('style', style, sep = '=')
    )
  
  style_price <-
    data %>% select(style, price) %>% distinct  %>%
    filter(style != 'none' & price != 'none') %>%
    transmute(s1 = paste('style', style, sep = '='),
              s2 = paste('price', price, sep = '='))
  
  decor_price <-
    data %>% select(atmosphere, price) %>% distinct  %>%
    filter(atmosphere != 'none' &
             price != 'none' & grepl('Decor', atmosphere)) %>%
    transmute(
      s1 = paste('atmosphere', atmosphere, sep = '='),
      s2 = paste('price', price, sep = '=')
    )
  
  if (write) {
    dataForR <- file.path('..', 'r_data')
    dir.create(dataForR, showWarnings = F)
    
    write.csv(
      cuisine_atmosphere,
      file = file.path(dataForR, 'q3_cuisine_atmosphere.csv'),
      fileEncoding = 'utf8',
      row.names = F
    )
    
    write.csv(
      cuisine_occasion,
      file = file.path(dataForR, 'q3_cuisine_occasion.csv'),
      fileEncoding = 'utf8',
      row.names = F
    )
    
    write.csv(
      cuisine_price,
      file = file.path(dataForR, 'q3_cuisine_price.csv'),
      fileEncoding = 'utf8',
      row.names = F
    )
    
    write.csv(
      cuisine_style,
      file = file.path(dataForR, 'q3_cuisine_style.csv'),
      fileEncoding = 'utf8',
      row.names = F
    )
    
    write.csv(
      atmosphere_occasion,
      file = file.path(dataForR, 'q3_atmosphere_occasion.csv'),
      fileEncoding = 'utf8',
      row.names = F
    )
    
    write.csv(
      atmosphere_price,
      file = file.path(dataForR, 'q3_atmosphere_price.csv'),
      fileEncoding = 'utf8',
      row.names = F
    )
    
    write.csv(
      atmosphere_style,
      file = file.path(dataForR, 'q3_atmosphere_style.csv'),
      fileEncoding = 'utf8',
      row.names = F
    )
    
    write.csv(
      occasion_price,
      file = file.path(dataForR, 'q3_occasion_price.csv'),
      fileEncoding = 'utf8',
      row.names = F
    )
    
    write.csv(
      occasion_style,
      file = file.path(dataForR, 'q3_occasion_style.csv'),
      fileEncoding = 'utf8',
      row.names = F
    )
    
    write.csv(
      style_price,
      file = file.path(dataForR, 'q3_style_price.csv'),
      fileEncoding = 'utf8',
      row.names = F
    )
    
    write.csv(
      decor_price,
      file = file.path(dataForR, 'q3_decor_price.csv'),
      fileEncoding = 'utf8',
      row.names = F
    )
  }
  
  list(
    q3Data = data,
    ca = cuisine_atmosphere,
    co = cuisine_occasion,
    cp = cuisine_price,
    cs = cuisine_style,
    ao = atmosphere_occasion,
    ap = atmosphere_price,
    as = atmosphere_style,
    op = occasion_price,
    os = occasion_style,
    sp = style_price,
    dp = decor_price
  )
}



helpers.q4 <- function(write = F) {
  data <- read.csv(file.path('q3', 'restaurantsq3.csv'))
  
  cuisine_foodQuality <-
    data %>% select(cuisine, atmosphere) %>%
    filter(grepl('Food', atmosphere)) 
  
  cuisine_foodQualitySide <-
    cuisine_foodQuality %>% distinct %>%
    transmute(
      s1 = paste('cuisine', cuisine, sep = '='),
      s2 = paste('atmosphere', atmosphere, sep = '=')
    )
  
  cuisine_foodQuality <- cuisine_foodQuality %>% transmute(cuisine=cuisine ,quality = atmosphere)
  
  cuisine_foodQuality <- droplevels(cuisine_foodQuality)
  cq_spread <- cuisine_foodQuality %>% group_by(cuisine,quality) %>% tally %>% spread(quality,n,fill = 0)
  
  cuisine_foodQualityD = cuisine_foodQuality
  cuisine_foodQualityD$quality <-
    recode_factor(
      cuisine_foodQualityD$quality,
      `Excellent Food` = "Good",
      `Near-perfect Food` = "Excellent",
      `Extraordinary Food` = "Excellent",
      `Fair Food` = 'Fair',
      `Good Food` = 'Good'
    )
  
  cqD_spread <- cuisine_foodQualityD %>% group_by(cuisine,quality) %>% tally %>% spread(quality,n,fill = 0)
  
  # cqD_spread %>% group_by(cuisine) %>% mutate(fit = lm())
  
  # cuisine_foodQuality$cuisine <- levels(cuisine_foodQuality$cuisine)
  # cuisine_foodQuality$quality <- levels(cuisine_foodQuality$quality)
  
  list(q4Data = data,
       cfqSide = cuisine_foodQualitySide,
       cfq = cuisine_foodQuality,
       cfqd = cuisine_foodQualityD,
       cqD_spread = cqD_spread,
       cq_spread=cq_spread)
}


helpers.pair_count <- function(df) {
  ldf <- df %>% transmute(
    cuisine = levels(unique(cuisine)),
    atmosphere = levels(unique(atmosphere)),
    occasion = levels(unique(occasion)),
    price = levels(unique(price)),
    style = levels(unique(style))
  )
  
  list(
      cuisine_atmosphere = df %>% select(cuisine, atmosphere) %>% group_by(cuisine, atmosphere) %>% tally(sort = TRUE),
      cuisine_occasion = df %>% select(cuisine, occasion) %>% group_by(cuisine, occasion) %>% tally(sort = TRUE),
      cuisine_price = df %>% select(cuisine, price) %>% group_by(cuisine, price) %>% tally(sort = TRUE),
      cuisine_style = df %>% select(cuisine, atmosphere) %>%  group_by(cuisine, atmosphere) %>% tally(sort = TRUE),
      atmosphere_occasion = df %>% select(cuisine, style) %>% group_by(cuisine, style) %>% tally(sort = TRUE),
      atmosphere_price = df %>% select(atmosphere, price) %>% group_by(atmosphere, price) %>% tally(sort = TRUE),
      atmosphere_style = df %>% select(atmosphere, style) %>% group_by(atmosphere, style) %>% tally(sort = TRUE),
      occasion_price = df %>% select(occasion, price) %>% group_by(occasion, price) %>% tally(sort = TRUE),
      occasion_style = df %>% select(occasion, style) %>% group_by(occasion, style) %>% tally(sort = TRUE),
      style_price = df %>% select(style, price) %>% group_by(style, price) %>% tally(sort = TRUE)
  )
}

helpers.q2_appearance <- function() {
  cuisine_appearance <-
    data %>% distinct(cuisine) %>% transmute(side = paste('cuisine', cuisine, sep = '='))
  
  atmosphere_appearance <-
    data %>% distinct(atmosphere) %>% transmute(side = paste('atmosphere', atmosphere, sep = '='))
  
  occasion_appearance <-
    data %>% distinct(occasion) %>% transmute(side = paste('occasion', occasion, sep = '='))
  
  price_appearance <-
    data %>% distinct(price) %>% transmute(side = paste('price', price, sep = '='))
  
  style_appearance <-
    data %>% distinct(style) %>% transmute(side = paste('style', style, sep = '='))
  
  write.csv(
    cuisine_appearance,
    file = file.path(dataForR, 'q2_cuisine_ap.csv'),
    fileEncoding = 'utf8'
  )
  write.csv(
    atmosphere_appearance,
    file = file.path(dataForR, 'q2_atmosphere_ap.csv'),
    fileEncoding = 'utf8'
  )
  write.csv(
    occasion_appearance,
    file = file.path(dataForR, 'q2_occasion_ap.csv'),
    fileEncoding = 'utf8'
  )
  write.csv(
    price_appearance,
    file = file.path(dataForR, 'q2_price_ap.csv'),
    fileEncoding = 'utf8'
  )
  write.csv(
    style_appearance,
    file = file.path(dataForR, 'q2_style_ap.csv'),
    fileEncoding = 'utf8'
  )
}

helpers.group_by_lhs <- function(ruleDF) {
  ruleDF %>% select(lhs, rhs, support, confidence, lift, conviction) %>% group_by(lhs) %>% summarise(
    associated = list(rhs),
    cumSup = sum(support),
    cumConf = sum(confidence),
    cumLift = sum(lift),
    sumConv = sum(conviction)
  )
}

# from http://www.r-bloggers.com/measuring-associations-between-non-numeric-variables/
helpers.GKtau <- function(x,y){
  #
  #  First, compute the IxJ contingency table between x and y
  #
  Nij <- table(x,y,useNA='ifany')
  #
  #  Next, convert this table into a joint probability estimate
  #
  PIij <- Nij/sum(Nij)
  #
  #  Compute the marginal probability estimates
  #
  PIiPlus = apply(PIij,MARGIN=1,sum)
  PIPlusj = apply(PIij,MARGIN=2,sum)
  #
  #  Compute the marginal variation of y
  #
  Vy <- 1 - sum(PIPlusj^2)
  #
  #  Compute the expected conditional variation of y given x
  #
  InnerSum <- apply(PIij^2,MARGIN=1,sum)
  VyBarx <-  1 - sum(InnerSum/PIiPlus)
  #
  #  Compute and return Goodman and Kruskal’s tau measure
  #
  tau <- (Vy - VyBarx)/Vy
  tau
}


