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

### 2
# Show the variable names in data
names(clean_data)
# Summary statistics
summary(clean_data)

### 3 Figures
# Plot a scatter plot with EVI versus GDP per capita
library(tidyverse)
library(ggplot2)

data_no_year <- clean_data
data_no_year$year <- NULL

ggplot(clean_data, aes(x = GDP_growth, y = DALY_per1000ppl)) +
  geom_point() +
  geom_smooth(method = lm) +
  labs(x = 'GDP_growth', y = 'DALY_per 1000 population',
       title = 'The relation between DALY per 1000 population and GDP growth (2000,2010,2015,2019)') +
  theme(plot.title = element_text(face = "bold", color = "steelblue", lineheight = 1.2, size = 12),
        axis.title.x = element_text(size = 8),
        axis.title.y = element_text(size = 8),
        axis.text.x = element_text(size = 6),
        axis.text.y = element_text(size = 6))
ggsave('figure/DALY-GDPgrowth-all.png', width = 6, height = 4)

ggplot(clean_data, aes(x = GDP_growth, y = DALY_per1000ppl)) +
  geom_point(data = data_no_year, color = "grey75") +
  geom_point() +
  facet_wrap(~ year) +
  geom_smooth(method = lm) +
  labs(x = 'GDP_growth', y = 'DALY per 1000 population',
       title = 'The relation between DALY per 1000 population and GDP growth') +
  theme(plot.title = element_text(face = "bold", color = "steelblue", lineheight = 1.2, size = 12),
        axis.title.x = element_text(size = 8),
        axis.title.y = element_text(size = 8),
        axis.text.x = element_text(size = 6),
        axis.text.y = element_text(size = 6))
ggsave('figure/DALY-GDPgrowth.png', width = 6, height = 4)

### 4
## Panel data analysis
library(plm)
## 1. EVI
# FE-individual: Country Fix Effect
mod1 <- plm(DALY_per1000ppl ~ GDP_growth+urban_population+population_density+elderly_population+unemployment,
            data = clean_data,
            index = "country",
            model = "within",
            effect = "individual")
summary(mod1)

# FE-two-ways: Country Fix Effect + Time Fix Effect
mod2 <- plm(DALY_per1000ppl ~ GDP_growth+urban_population+elderly_population,
            data = clean_data,
            index = c("country","year"),
            model = "within",
            effect = "twoways")
summary(mod2)

mod3 <- plm(DALY_per1000ppl ~ GDP_per_capita_k+urban_population+elderly_population,
            data = clean_data,
            index = c("country","year"),
            model = "within",
            effect = "twoways")
summary(mod3)


clean_data$Neonatal_per1000ppl <- 1000*clean_data$Neonatal / clean_data$population
mod_Neo <- plm(Neonatal_per1000ppl ~ GDP_growth+urban_population+elderly_population,
               data = clean_data,
               index = c("country","year"),
               model = "within",
               effect = "twoways")
summary(mod_Neo)
mod_Neo_3 <- plm(Neonatal_per1000ppl ~ GDP_per_capita_k+urban_population+elderly_population,
               data = clean_data,
               index = c("country","year"),
               model = "within",
               effect = "twoways")
summary(mod_Neo_3)

clean_data$Ischaemic_per1000ppl <- 1000*clean_data$Ischaemic / clean_data$population
mod_Ish <- plm(Ischaemic_per1000ppl ~ GDP_growth+urban_population+elderly_population,
               data = clean_data,
               index = c("country","year"),
               model = "within",
               effect = "twoways")
summary(mod_Ish)
mod_Ish_3 <- plm(Ischaemic_per1000ppl ~ GDP_per_capita_k+urban_population+elderly_population,
               data = clean_data,
               index = c("country","year"),
               model = "within",
               effect = "twoways")
summary(mod_Ish_3)

clean_data$Stroke_per1000ppl <- 1000*clean_data$Stroke / clean_data$population
mod_Str <- plm(Stroke_per1000ppl ~ GDP_growth+urban_population+elderly_population,
               data = clean_data,
               index = c("country","year"),
               model = "within",
               effect = "twoways")
summary(mod_Str)
mod_Str_3 <- plm(Stroke_per1000ppl ~ GDP_per_capita_k+urban_population+elderly_population,
               data = clean_data,
               index = c("country","year"),
               model = "within",
               effect = "twoways")
summary(mod_Str_3)

clean_data$L_respiratory_per1000ppl <- 1000*clean_data$L_respiratory / clean_data$population
mod_Res <- plm(L_respiratory_per1000ppl ~ GDP_growth+urban_population+elderly_population,
               data = clean_data,
               index = c("country","year"),
               model = "within",
               effect = "twoways")
summary(mod_Res)
mod_Res_3 <- plm(L_respiratory_per1000ppl ~ GDP_per_capita_k+urban_population+elderly_population,
               data = clean_data,
               index = c("country","year"),
               model = "within",
               effect = "twoways")
summary(mod_Res_3)

clean_data$Diarrhoeal_per1000ppl <- 1000*clean_data$Diarrhoeal / clean_data$population
mod_Dia <- plm(Diarrhoeal_per1000ppl ~ GDP_growth+urban_population+elderly_population,
               data = clean_data,
               index = c("country","year"),
               model = "within",
               effect = "twoways")
summary(mod_Dia)
mod_Dia_3 <- plm(Diarrhoeal_per1000ppl ~ GDP_per_capita_k+urban_population+elderly_population,
               data = clean_data,
               index = c("country","year"),
               model = "within",
               effect = "twoways")
summary(mod_Dia_3)

clean_data$Road_inj_per1000ppl <- 1000*clean_data$Road_inj / clean_data$population
mod_Roa <- plm(Road_inj_per1000ppl ~ GDP_growth+urban_population+elderly_population,
               data = clean_data,
               index = c("country","year"),
               model = "within",
               effect = "twoways")
summary(mod_Roa)
mod_Roa_3 <- plm(Road_inj_per1000ppl ~ GDP_per_capita_k+urban_population+elderly_population,
               data = clean_data,
               index = c("country","year"),
               model = "within",
               effect = "twoways")
summary(mod_Roa_3)

clean_data$Pulmonary_per1000ppl <- 1000*clean_data$Pulmonary / clean_data$population
mod_Pul <- plm(Pulmonary_per1000ppl ~ GDP_growth+urban_population+elderly_population,
               data = clean_data,
               index = c("country","year"),
               model = "within",
               effect = "twoways")
summary(mod_Pul)
mod_Pul_3 <- plm(Pulmonary_per1000ppl ~ GDP_per_capita_k+urban_population+elderly_population,
               data = clean_data,
               index = c("country","year"),
               model = "within",
               effect = "twoways")
summary(mod_Pul_3)

clean_data$Diabetes_per1000ppl <- 1000*clean_data$Diabetes / clean_data$population
mod_Dia_3<- plm(Diabetes_per1000ppl ~ GDP_growth+urban_population+elderly_population,
                data = clean_data,
                index = c("country","year"),
                model = "within",
                effect = "twoways")
summary(mod_Dia)
mod_Dia_3 <- plm(Diabetes_per1000ppl ~ GDP_per_capita_k+urban_population+elderly_population,
               data = clean_data,
               index = c("country","year"),
               model = "within",
               effect = "twoways")
summary(mod_Dia_3)

clean_data$Tuberculosis_per1000ppl <- 1000*clean_data$Tuberculosis / clean_data$population
mod_Tub <- plm(Tuberculosis_per1000ppl ~ GDP_growth+urban_population+elderly_population,
               data = clean_data,
               index = c("country","year"),
               model = "within",
               effect = "twoways")
summary(mod_Tub)
mod_Tub_3 <- plm(Tuberculosis_per1000ppl ~ GDP_per_capita_k+urban_population+elderly_population,
               data = clean_data,
               index = c("country","year"),
               model = "within",
               effect = "twoways")
summary(mod_Tub_3)

clean_data$Congenital_per1000ppl <- 1000*clean_data$Congenital / clean_data$population
mod_Con <- plm(Congenital_per1000ppl ~ GDP_growth+urban_population+elderly_population,
               data = clean_data,
               index = c("country","year"),
               model = "within",
               effect = "twoways")
summary(mod_Con)
mod_Con_3 <- plm(Congenital_per1000ppl ~ GDP_per_capita_k+urban_population+elderly_population,
               data = clean_data,
               index = c("country","year"),
               model = "within",
               effect = "twoways")
summary(mod_Con_3)

clean_data$HIV_AIDS_per1000ppl <- 1000*clean_data$HIV_AIDS / clean_data$population
mod_HIV_AIDS <- plm(HIV_AIDS_per1000ppl ~ GDP_growth+urban_population+elderly_population,
                data = clean_data,
                index = c("country","year"),
                model = "within",
                effect = "twoways")
summary(mod_HIV_AIDS)
mod_HIV_AIDS_3 <- plm(HIV_AIDS_per1000ppl ~ GDP_per_capita_k+urban_population+elderly_population,
                    data = clean_data,
                    index = c("country","year"),
                    model = "within",
                    effect = "twoways")
summary(mod_HIV_AIDS_3)

mod2_2 <- plm(DALY_per1000ppl ~ GDP_growth+urban_population+population_density+elderly_population+unemployment,
            data = clean_data,
            index = c("country","year"),
            model = "within",
            effect = "twoways")
summary(mod2_2)


#library(stargazer)
#stargazer(mod1,mod2,type='latex',
#          column.labels = c("FE-individual","FE-two-ways"))

#stargazer(PooledOLS,re1,mod1,mod2,type='latex',
#          column.labels = c("Pooled OLS","Random Effect","FE-individual","FE-two-ways"))


data_order_GDPgrowth <- clean_data[order(clean_data$GDP_growth),]
data_order_GDPpercapita <- clean_data[order(clean_data$GDP_per_capita),]


