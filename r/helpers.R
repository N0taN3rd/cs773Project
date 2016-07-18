library(dplyr)
library(tidyr)
library(foreach)

setwd(getwd())

helpers.q3 <- function(write = F, filter = NULL) {
  data <-
    read.csv('q3/restaurantsq3.csv') 
  
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
  
  if (write) {
    cwd <- getwd()
    dataForR <- file.path(cwd, 'r_data')
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
    sp = style_price
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