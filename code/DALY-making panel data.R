library(data.table)
library(dplyr)

setwd('/Users/eva_shao/Documents/111-2/勞動經濟學專題：實證方法與應用/term paper')

##### read data #####
income_level <- as.data.frame(read.csv('data/work data/income_level_country.csv', check.names = FALSE))
## independent var
GDP_growth <- as.data.frame(read.csv('data/work data/GDP_growth.csv', check.names = FALSE))
GDP <- as.data.frame(read.csv('data/work data/GDP.csv', check.names = FALSE))
GDP_per_capita <- as.data.frame(read.csv('data/work data/GDP_per_capita.csv', check.names = FALSE))
urban_population <- as.data.frame(read.csv('data/work data/urban_population.csv', check.names = FALSE))
physician <- as.data.frame(read.csv('data/work data/physicians.csv', check.names = FALSE))
population_density <- as.data.frame(read.csv('data/work data/population_density.csv', check.names = FALSE))
elderly_population <- as.data.frame(read.csv('data/work data/elderly_population.csv', check.names = FALSE))
unemployment <- as.data.frame(read.csv('data/work data/unemployment_rate.csv', check.names = FALSE))
primary_schooling <- as.data.frame(read.csv('data/work data/primaryschool_enrollment.csv', check.names = FALSE))

## dependent var
DALY_2000 <- read.xlsx('data/work data/DALY.xlsx', sheet='2000')
DALY_2010 <- read.xlsx('data/work data/DALY.xlsx', sheet='2010')
DALY_2015 <- read.xlsx('data/work data/DALY.xlsx', sheet='2015')
DALY_2019 <- read.xlsx('data/work data/DALY.xlsx', sheet='2019')

# Set row names
rownames(DALY_2000) <- DALY_2000$Code
rownames(DALY_2010) <- DALY_2010$Code
rownames(DALY_2015) <- DALY_2015$Code
rownames(DALY_2019) <- DALY_2019$Code

DALY_2000_allcauses <- DALY_2000[c('pop','0','490','1130','1140','390','110','1530','1180','800','30','1400','100'),]
rownames(DALY_2000_allcauses) <- DALY_2000_allcauses[,2]
DALY_2000_allcauses <- DALY_2000_allcauses[,-c(1,2)]
DALY_2000_allcauses_t <- transpose(DALY_2000_allcauses)
rownames(DALY_2000_allcauses_t) <- colnames(DALY_2000_allcauses)
colnames(DALY_2000_allcauses_t) <- rownames(DALY_2000_allcauses)
colnames(DALY_2000_allcauses_t)[1] <- 'population_2000'
colnames(DALY_2000_allcauses_t)[2] <- 'DALY_2000'
DALY_2000_allcauses_t$population_2000 <- as.numeric(DALY_2000_allcauses_t$population_2000)
DALY_2000_allcauses_t$DALY_2000 <- as.numeric(DALY_2000_allcauses_t$DALY_2000)
DALY_2000_allcauses_t$DALY_2000_per1000ppl <- 1000*DALY_2000_allcauses_t$DALY_2000/DALY_2000_allcauses_t$population_2000
DALY_2000_allcauses_t <- DALY_2000_allcauses_t %>% mutate_at(c(1:14),as.numeric)

DALY_2010_allcauses <- DALY_2010[c('pop','0','490','1130','1140','390','110','1530','1180','800','30','1400','100'),]
rownames(DALY_2010_allcauses) <- DALY_2010_allcauses[,2]
DALY_2010_allcauses <- DALY_2010_allcauses[,-c(1,2)]
DALY_2010_allcauses_t <- transpose(DALY_2010_allcauses)
rownames(DALY_2010_allcauses_t) <- colnames(DALY_2010_allcauses)
colnames(DALY_2010_allcauses_t) <- rownames(DALY_2010_allcauses)
colnames(DALY_2010_allcauses_t)[1] <- 'population_2010'
colnames(DALY_2010_allcauses_t)[2] <- 'DALY_2010'
DALY_2010_allcauses_t$population_2010 <- as.numeric(DALY_2010_allcauses_t$population_2010)
DALY_2010_allcauses_t$DALY_2010 <- as.numeric(DALY_2010_allcauses_t$DALY_2010)
DALY_2010_allcauses_t$DALY_2010_per1000ppl <- 1000*DALY_2010_allcauses_t$DALY_2010/DALY_2010_allcauses_t$population_2010
DALY_2010_allcauses_t <- DALY_2010_allcauses_t %>% mutate_at(c(1:14),as.numeric)

DALY_2015_allcauses <- DALY_2015[c('pop','0','490','1130','1140','390','110','1530','1180','800','30','1400','100'),]
rownames(DALY_2015_allcauses) <- DALY_2015_allcauses[,2]
DALY_2015_allcauses <- DALY_2015_allcauses[,-c(1,2)]
DALY_2015_allcauses_t <- transpose(DALY_2015_allcauses)
rownames(DALY_2015_allcauses_t) <- colnames(DALY_2015_allcauses)
colnames(DALY_2015_allcauses_t) <- rownames(DALY_2015_allcauses)
colnames(DALY_2015_allcauses_t)[1] <- 'population_2015'
colnames(DALY_2015_allcauses_t)[2] <- 'DALY_2015'
DALY_2015_allcauses_t$population_2015 <- as.numeric(DALY_2015_allcauses_t$population_2015)
DALY_2015_allcauses_t$DALY_2015 <- as.numeric(DALY_2015_allcauses_t$DALY_2015)
DALY_2015_allcauses_t$DALY_2015_per1000ppl <- 1000*DALY_2015_allcauses_t$DALY_2015/DALY_2015_allcauses_t$population_2015
DALY_2015_allcauses_t <- DALY_2015_allcauses_t %>% mutate_at(c(1:14),as.numeric)

DALY_2019_allcauses <- DALY_2019[c('pop','0','490','1130','1140','390','110','1530','1180','800','30','1400','100'),]
rownames(DALY_2019_allcauses) <- DALY_2019_allcauses[,2]
DALY_2019_allcauses <- DALY_2019_allcauses[,-c(1,2)]
DALY_2019_allcauses_t <- transpose(DALY_2019_allcauses)
rownames(DALY_2019_allcauses_t) <- colnames(DALY_2019_allcauses)
colnames(DALY_2019_allcauses_t) <- rownames(DALY_2019_allcauses)
colnames(DALY_2019_allcauses_t)[1] <- 'population_2019'
colnames(DALY_2019_allcauses_t)[2] <- 'DALY_2019'
DALY_2019_allcauses_t$population_2019 <- as.numeric(DALY_2019_allcauses_t$population_2019)
DALY_2019_allcauses_t$DALY_2019 <- as.numeric(DALY_2019_allcauses_t$DALY_2019)
DALY_2019_allcauses_t$DALY_2019_per1000ppl <- 1000*DALY_2019_allcauses_t$DALY_2019/DALY_2019_allcauses_t$population_2019
DALY_2019_allcauses_t <- DALY_2019_allcauses_t %>% mutate_at(c(1:14),as.numeric)

#DALY <- merge(DALY_2000_allcauses_t, DALY_2010_allcauses_t, by='row.names', all = TRUE)
#DALY <- merge(DALY, DALY_2015_allcauses_t, by.x = 'Row.names', by.y = 'row.names', all = TRUE)
#DALY <- merge(DALY, DALY_2019_allcauses_t, by.x = 'Row.names', by.y = 'row.names', all = TRUE)
#colnames(DALY)[1] <- 'Country Code'

##### make panel data (2000,2010,2015,2019) #####
# make a vector of all country names
countryvec <- row.names(DALY_2000_allcauses_t)

## Country names
# make a panel of 266 countries for 4 years (2000,2010,2015,2019)
countryname_panel = c()
for (i in 1:length(countryvec)){
  x = rep(countryvec[i],4)
  countryname_panel = append(countryname_panel,x)
}

## Years
# make a panel of 266 countries for 10 years (2005-2014)
years_panel <- rep(c(2000,2010,2015,2019), length(countryvec))

## Make panel for the independent and dependent variables
panel_data <- data.frame(country = countryname_panel,
                         year = years_panel,
                         country_name = rep(NA, length(countryname_panel)),
                         income_level = rep(NA, length(countryname_panel)),
                         
                         ## independent var
                         GDP_growth = rep(NA, length(countryname_panel)),
                         GDP = rep(NA, length(countryname_panel)),
                         GDP_per_capita = rep(NA, length(countryname_panel)),
                         urban_population = rep(NA, length(countryname_panel)),
                         physician = rep(NA, length(countryname_panel)),
                         population_density = rep(NA, length(countryname_panel)),
                         elderly_population = rep(NA, length(countryname_panel)),
                         unemployment = rep(NA, length(countryname_panel)),
                         population = rep(NA, length(countryname_panel)),
                         #primary_schooling = rep(NA, length(countryname_panel)),
                         
                         ## dependent var
                         DALY = rep(NA, length(countryname_panel)),
                         DALY_per1000ppl = rep(NA, length(countryname_panel)),
                         Neonatal = rep(NA, length(countryname_panel)),
                         Ischaemic = rep(NA, length(countryname_panel)),
                         Stroke = rep(NA, length(countryname_panel)),
                         L_respiratory = rep(NA, length(countryname_panel)),
                         Diarrhoeal = rep(NA, length(countryname_panel)),
                         Road_inj = rep(NA, length(countryname_panel)),
                         Pulmonary = rep(NA, length(countryname_panel)),
                         Diabetes = rep(NA, length(countryname_panel)),
                         Tuberculosis = rep(NA, length(countryname_panel)),
                         Congenital = rep(NA, length(countryname_panel)),
                         HIV_AIDS = rep(NA, length(countryname_panel))
)


for (i in 1:length(countryname_panel)){
  country = panel_data[i, "country"]
  year = as.character(panel_data[i, "year"])
  if (country %in% as.list(income_level$`Country Code`)){
    panel_data[i,'country_name'] = income_level[income_level$`Country Code`==country,1]
    panel_data[i,'income_level'] = income_level[income_level$`Country Code`==country,2]
  }else{
    panel_data[i,'country_name'] = NA
    panel_data[i,'income_level'] = NA
  }

  if (country %in% as.list(GDP_growth$`Country Code`)){
    panel_data[i,'GDP_growth'] = GDP_growth[GDP_growth$`Country Code`==country,year]
  }else{
    panel_data[i,'GDP_growth'] = NA
  }
  if (country %in% as.list(GDP$`Country Code`)){
    panel_data[i,'GDP'] = GDP[GDP$`Country Code`==country,year]
  }else{
    panel_data[i,'GDP'] = NA
  }
  if (country %in% as.list(GDP_per_capita$`Country Code`)){
    panel_data[i,'GDP_per_capita'] = GDP_per_capita[GDP_per_capita$`Country Code`==country,year]
  }else{
    panel_data[i,'GDP_per_capita'] = NA
  }
  if (country %in% as.list(urban_population$`Country Code`)){
    panel_data[i,'urban_population'] = urban_population[urban_population$`Country Code`==country,year]
  }else{
    panel_data[i,'urban_population'] = NA
  }
  if (country %in% as.list(physician$`Country Code`)){
    panel_data[i,'physician'] = physician[physician$`Country Code`==country,year]
  }else{
    panel_data[i,'physician'] = NA
  }
  if (country %in% as.list(population_density$`Country Code`)){
    panel_data[i,'population_density'] = population_density[population_density$`Country Code`==country,year]
  }else{
    panel_data[i,'population_density'] = NA
  }
  if (country %in% as.list(elderly_population$`Country Code`)){
    panel_data[i,'elderly_population'] = elderly_population[elderly_population$`Country Code`==country,year]
  }else{
    panel_data[i,'elderly_population'] = NA
  }
  if (country %in% as.list(unemployment$`Country Code`)){
    panel_data[i,'unemployment'] = unemployment[unemployment$`Country Code`==country,year]
  }else{
    panel_data[i,'unemployment'] = NA
  }
  #panel_data[i,'primary_schooling'] = primary_schooling[primary_schooling$`Country Code`==country,year]
  
  if (year == '2000'){
    panel_data[i,'DALY'] = DALY_2000_allcauses_t[country,'DALY_2000']
    panel_data[i,'population'] = DALY_2000_allcauses_t[country,'population_2000']
    panel_data[i,'DALY_per1000ppl'] = DALY_2000_allcauses_t[country,'DALY_2000_per1000ppl']
    panel_data[i,'Neonatal'] = DALY_2000_allcauses_t[country,'Neonatal conditions']
    panel_data[i,'Ischaemic'] = DALY_2000_allcauses_t[country,'Ischaemic heart disease']
    panel_data[i,'Stroke'] = DALY_2000_allcauses_t[country,'Stroke']
    panel_data[i,'L_respiratory'] = DALY_2000_allcauses_t[country,'Lower respiratory infections']
    panel_data[i,'Diarrhoeal'] = DALY_2000_allcauses_t[country,'Diarrhoeal diseases']
    panel_data[i,'Road_inj'] = DALY_2000_allcauses_t[country,'Road injury']
    panel_data[i,'Pulmonary'] = DALY_2000_allcauses_t[country,'Chronic obstructive pulmonary disease']
    panel_data[i,'Diabetes'] = DALY_2000_allcauses_t[country,'Diabetes mellitus']
    panel_data[i,'Tuberculosis'] = DALY_2000_allcauses_t[country,'Tuberculosis']
    panel_data[i,'Congenital'] = DALY_2000_allcauses_t[country,'Congenital anomalies']
    panel_data[i,'HIV_AIDS'] = DALY_2000_allcauses_t[country,'HIV/AIDS']
  }else if (year == '2010'){
    panel_data[i,'DALY'] = DALY_2010_allcauses_t[country,'DALY_2010']
    panel_data[i,'population'] = DALY_2010_allcauses_t[country,'population_2010']
    panel_data[i,'DALY_per1000ppl'] = DALY_2010_allcauses_t[country,'DALY_2010_per1000ppl']
    panel_data[i,'Neonatal'] = DALY_2010_allcauses_t[country,'Neonatal conditions']
    panel_data[i,'Ischaemic'] = DALY_2010_allcauses_t[country,'Ischaemic heart disease']
    panel_data[i,'Stroke'] = DALY_2010_allcauses_t[country,'Stroke']
    panel_data[i,'L_respiratory'] = DALY_2010_allcauses_t[country,'Lower respiratory infections']
    panel_data[i,'Diarrhoeal'] = DALY_2010_allcauses_t[country,'Diarrhoeal diseases']
    panel_data[i,'Road_inj'] = DALY_2010_allcauses_t[country,'Road injury']
    panel_data[i,'Pulmonary'] = DALY_2010_allcauses_t[country,'Chronic obstructive pulmonary disease']
    panel_data[i,'Diabetes'] = DALY_2010_allcauses_t[country,'Diabetes mellitus']
    panel_data[i,'Tuberculosis'] = DALY_2010_allcauses_t[country,'Tuberculosis']
    panel_data[i,'Congenital'] = DALY_2010_allcauses_t[country,'Congenital anomalies']
    panel_data[i,'HIV_AIDS'] = DALY_2010_allcauses_t[country,'HIV/AIDS']
  }else if (year == '2015'){
    panel_data[i,'DALY'] = DALY_2015_allcauses_t[country,'DALY_2015']
    panel_data[i,'population'] = DALY_2015_allcauses_t[country,'population_2015']
    panel_data[i,'DALY_per1000ppl'] = DALY_2015_allcauses_t[country,'DALY_2015_per1000ppl']
    panel_data[i,'Neonatal'] = DALY_2015_allcauses_t[country,'Neonatal conditions']
    panel_data[i,'Ischaemic'] = DALY_2015_allcauses_t[country,'Ischaemic heart disease']
    panel_data[i,'Stroke'] = DALY_2015_allcauses_t[country,'Stroke']
    panel_data[i,'L_respiratory'] = DALY_2015_allcauses_t[country,'Lower respiratory infections']
    panel_data[i,'Diarrhoeal'] = DALY_2015_allcauses_t[country,'Diarrhoeal diseases']
    panel_data[i,'Road_inj'] = DALY_2015_allcauses_t[country,'Road injury']
    panel_data[i,'Pulmonary'] = DALY_2015_allcauses_t[country,'Chronic obstructive pulmonary disease']
    panel_data[i,'Diabetes'] = DALY_2015_allcauses_t[country,'Diabetes mellitus']
    panel_data[i,'Tuberculosis'] = DALY_2015_allcauses_t[country,'Tuberculosis']
    panel_data[i,'Congenital'] = DALY_2015_allcauses_t[country,'Congenital anomalies']
    panel_data[i,'HIV_AIDS'] = DALY_2015_allcauses_t[country,'HIV/AIDS']
  }else if (year == '2019'){
    panel_data[i,'DALY'] = DALY_2019_allcauses_t[country,'DALY_2019']
    panel_data[i,'population'] = DALY_2019_allcauses_t[country,'population_2019']
    panel_data[i,'DALY_per1000ppl'] = DALY_2019_allcauses_t[country,'DALY_2019_per1000ppl']
    panel_data[i,'Neonatal'] = DALY_2019_allcauses_t[country,'Neonatal conditions']
    panel_data[i,'Ischaemic'] = DALY_2019_allcauses_t[country,'Ischaemic heart disease']
    panel_data[i,'Stroke'] = DALY_2019_allcauses_t[country,'Stroke']
    panel_data[i,'L_respiratory'] = DALY_2019_allcauses_t[country,'Lower respiratory infections']
    panel_data[i,'Diarrhoeal'] = DALY_2019_allcauses_t[country,'Diarrhoeal diseases']
    panel_data[i,'Road_inj'] = DALY_2019_allcauses_t[country,'Road injury']
    panel_data[i,'Pulmonary'] = DALY_2019_allcauses_t[country,'Chronic obstructive pulmonary disease']
    panel_data[i,'Diabetes'] = DALY_2019_allcauses_t[country,'Diabetes mellitus']
    panel_data[i,'Tuberculosis'] = DALY_2019_allcauses_t[country,'Tuberculosis']
    panel_data[i,'Congenital'] = DALY_2019_allcauses_t[country,'Congenital anomalies']
    panel_data[i,'HIV_AIDS'] = DALY_2019_allcauses_t[country,'HIV/AIDS']
  }
  
  #print(year)
  #print(country)
  #print(undernourishment[undernourishment$`Country Code`==country,year])
}

write.csv(panel_data, 'data/work data/DALY_panel_data.csv')

