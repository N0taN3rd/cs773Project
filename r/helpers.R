library(dplyr)

cwd <- getwd()
setwd(cwd)


dataForR <- file.path(cwd, 'r_data')

dir.create(dataForR, showWarnings = FALSE)


helpers.q3_pairs <- function(data) {
  cuisine_atmosphere <-
    data %>% select(cuisine, atmosphere) %>% distinct %>% transmute(
      s1 = paste('cuisine', cuisine, sep = '='),
      s2 = paste('atmosphere', atmosphere, sep = '=')
    )
  
  write.csv(cuisine_atmosphere,file = file.path(dataForR,'q3_cuisine_atmosphere.csv'),fileEncoding = 'utf8')
  
  cuisine_occasion <-
    data %>% select(cuisine, occasion) %>% distinct %>% transmute(
      s1 = paste('cuisine', cuisine, sep = '='),
      s2 = paste('occasion', occasion, sep = '=')
    )
  
  
  cuisine_price <-
    data %>% select(cuisine, price) %>% distinct  %>% transmute(
      s1 = paste('cuisine', cuisine, sep = '='),
      s2 = paste('price', price, sep = '=')
    )
  
  cuisine_style <-
    data %>% select(cuisine, style) %>% distinct  %>% transmute(
      s1 = paste('cuisine', cuisine, sep = '='),
      s2 = paste('style', style, sep = '=')
    )
  
  atmosphere_occasion <-
    data %>% select(atmosphere, occasion) %>% distinct  %>% transmute(
      s1 = paste('cuisine', cuisine, sep = '='),
      s2 = paste('occasion', occasion, sep = '=')
    )
  
  atmosphere_price <-
    data %>% select(atmosphere, price) %>% distinct  %>% transmute(
      s1 = paste('atmosphere', atmosphere, sep = '='),
      s2 = paste('price', price, sep = '=')
    )
  
  atmosphere_style <-
    data %>% select(atmosphere, style) %>% distinct  %>% transmute(
      s1 = paste('atmosphere', atmosphere, sep = '='),
      s2 = paste('style', style, sep = '=')
    )
  
  occasion_price <-
    data %>% select(occasion, price) %>% distinct  %>% transmute(
      s1 = paste('occasion', occasion, sep = '='),
      s2 = paste('price', price, sep = '=')
    )
  
  occasion_style <-
    data %>% select(occasion, style) %>% distinct  %>% transmute(
      s1 = paste('occasion', occasion, sep = '='),
      s2 = paste('style', style, sep = '=')
    )
  
  style_price <-
    data %>% select(style, price) %>% distinct  %>% transmute(s1 = paste('style', style, sep = '='),
                                                              s2 = paste('price', price, sep = '='))

  
  
}

helpers.q2_appearance <- function(data) {
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
}