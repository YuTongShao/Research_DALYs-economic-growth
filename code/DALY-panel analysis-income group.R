library(dplyr)
library(ggplot2)

### Clear R environment
rm(list=ls(all=TRUE))

getwd()
setwd('/Users/eva_shao/Documents/111-2/勞動經濟學專題：實證方法與應用/term paper')

### 1
data <- as.data.frame(read.csv('data/work data/DALY_panel_data.csv', header = TRUE, sep = ','))
## Subset panel to contain only variables I will use
data <- data[,-c(1)]
data1 <- data
data1$physician = NULL

## Drop countries with NA
countryvec <- unique(data1$country)
clean_data <- data.frame()
for (i in 1:length(countryvec)){
  country = countryvec[i]
  dt = data1[data1$country==country,]
  #print(data1[data1$country==country,])
  if (sum(is.na(dt)) == 0){
    clean_data <- rbind(clean_data,dt)
  }
}

clean_data$year <- as.factor(clean_data$year) 
clean_data$GDP_per_capita_k <- clean_data$GDP_per_capita/1000

data_low <- clean_data[clean_data$income_level=='Low income',]
data_lower_middle <- clean_data[clean_data$income_level=='Lower-middle income',]
data_upper_middle <- clean_data[clean_data$income_level=='Upper-middle income',]
data_high<- clean_data[clean_data$income_level=='High income',]

### 2: Fixed effect models
# FE-two-ways: Country Fix Effect + Time Fix Effect
## GDP growth
library(plm)
mod <- plm(DALY_per1000ppl ~ GDP_growth+urban_population+elderly_population,
            data = clean_data,
            index = c("country","year"),
            model = "within",
            effect = "twoways")
summary(mod)

mod_low <- plm(DALY_per1000ppl ~ GDP_growth+urban_population+elderly_population,
           data = data_low,
           index = c("country","year"),
           model = "within",
           effect = "twoways")
summary(mod_low)

mod_lower_middle <- plm(DALY_per1000ppl ~ GDP_growth+urban_population+elderly_population,
               data = data_lower_middle,
               index = c("country","year"),
               model = "within",
               effect = "twoways")
summary(mod_lower_middle)

mod_upper_middle <- plm(DALY_per1000ppl ~ GDP_growth+urban_population+elderly_population,
               data = data_upper_middle,
               index = c("country","year"),
               model = "within",
               effect = "twoways")
summary(mod_upper_middle)

mod_high <- plm(DALY_per1000ppl ~ GDP_growth+urban_population+elderly_population,
               data = data_high,
               index = c("country","year"),
               model = "within",
               effect = "twoways")
summary(mod_high)

## GDP per capita
mod_1 <- plm(DALY_per1000ppl ~ GDP_per_capita_k+urban_population+elderly_population,
           data = clean_data,
           index = c("country","year"),
           model = "within",
           effect = "twoways")
summary(mod_1)

mod_low_1 <- plm(DALY_per1000ppl ~ GDP_per_capita_k+urban_population+elderly_population,
               data = data_low,
               index = c("country","year"),
               model = "within",
               effect = "twoways")
summary(mod_low_1)

mod_lower_middle_1 <- plm(DALY_per1000ppl ~ GDP_per_capita_k+urban_population+elderly_population,
                        data = data_lower_middle,
                        index = c("country","year"),
                        model = "within",
                        effect = "twoways")
summary(mod_lower_middle_1)

mod_upper_middle_1 <- plm(DALY_per1000ppl ~ GDP_per_capita_k+urban_population+elderly_population,
                        data = data_upper_middle,
                        index = c("country","year"),
                        model = "within",
                        effect = "twoways")
summary(mod_upper_middle_1)

mod_high_1 <- plm(DALY_per1000ppl ~ GDP_per_capita_k+urban_population+elderly_population,
                data = data_high,
                index = c("country","year"),
                model = "within",
                effect = "twoways")
summary(mod_high_1)
