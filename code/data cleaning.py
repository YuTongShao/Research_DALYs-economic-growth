import pandas as pd
import numpy as np

## Independent variables
GDP_growth = pd.read_csv('/Users/eva_shao/Documents/111-2/勞動經濟學專題：實證方法與應用/term paper/data/work data/GDP_growth.csv')
GDP_per_capita = pd.read_csv('/Users/eva_shao/Documents/111-2/勞動經濟學專題：實證方法與應用/term paper/data/work data/GDP_per_capita.csv')
unemployment_rate = pd.read_csv('/Users/eva_shao/Documents/111-2/勞動經濟學專題：實證方法與應用/term paper/data/work data/unemployment_rate.csv')
urban_population = pd.read_csv('/Users/eva_shao/Documents/111-2/勞動經濟學專題：實證方法與應用/term paper/data/work data/urban_population.csv')
hospital_beds = pd.read_csv('/Users/eva_shao/Documents/111-2/勞動經濟學專題：實證方法與應用/term paper/data/work data/hospital_beds.csv')
physicians = pd.read_csv('/Users/eva_shao/Documents/111-2/勞動經濟學專題：實證方法與應用/term paper/data/work data/physicians.csv')
population_density = pd.read_csv('/Users/eva_shao/Documents/111-2/勞動經濟學專題：實證方法與應用/term paper/data/work data/population_density.csv')
elderly_population = pd.read_csv('/Users/eva_shao/Documents/111-2/勞動經濟學專題：實證方法與應用/term paper/data/work data/elderly_population.csv')
primaryschool_enrollment = pd.read_csv('/Users/eva_shao/Documents/111-2/勞動經濟學專題：實證方法與應用/term paper/data/work data/primaryschool_enrollment.csv')


## Dependent variables
tobacco_prevalence = pd.read_csv('/Users/eva_shao/Documents/111-2/勞動經濟學專題：實證方法與應用/term paper/data/work data/tobacco_prevalence.csv')
HIV_prevalence = pd.read_csv('/Users/eva_shao/Documents/111-2/勞動經濟學專題：實證方法與應用/term paper/data/work data/HIV_prevalence.csv')
overweight_percentage = pd.read_csv('/Users/eva_shao/Documents/111-2/勞動經濟學專題：實證方法與應用/term paper/data/work data/overweight_percentage.csv')
hypertension_prevalence = pd.read_csv('/Users/eva_shao/Documents/111-2/勞動經濟學專題：實證方法與應用/term paper/data/work data/hypertension_prevalence.csv')
diabetes_prevalence = pd.read_csv('/Users/eva_shao/Documents/111-2/勞動經濟學專題：實證方法與應用/term paper/data/work data/diabetes_prevalence.csv')

COVID_19_20201231 = pd.read_csv('/Users/eva_shao/Documents/111-2/勞動經濟學專題：實證方法與應用/term paper/data/work data/COVID_19_20201231.csv')
COVID_19_20211231 = pd.read_csv('/Users/eva_shao/Documents/111-2/勞動經濟學專題：實證方法與應用/term paper/data/work data/COVID_19_20211231.csv')
COVID_19_20221231 = pd.read_csv('/Users/eva_shao/Documents/111-2/勞動經濟學專題：實證方法與應用/term paper/data/work data/COVID_19_20221231.csv')
COVID_19_20230430 = pd.read_csv('/Users/eva_shao/Documents/111-2/勞動經濟學專題：實證方法與應用/term paper/data/work data/COVID_19_20230430.csv')

print(GDP_growth)

### Combine all the independent and dependent data to a dataframe
## Independent variables
# GDP_growth: 2018
data = GDP_growth[['Country Name','Country Code','2018']]
data.rename({'2018': 'GDP_growth'}, axis=1, inplace=True)

# GDP_per_capita: 2018
data = pd.merge(data,GDP_per_capita[['Country Code','2018']],how='inner',on='Country Code')
data.rename({'2018': 'GDP_per_capita'}, axis=1, inplace=True)

# unemployment_rate: 2018
data = pd.merge(data,unemployment_rate[['Country Code','2018']],how='inner',on='Country Code')
data.rename({'2018': 'unemployment_rate'}, axis=1, inplace=True)

# urban_population: 2018
data = pd.merge(data,urban_population[['Country Code','2018']],how='inner',on='Country Code')
data.rename({'2018': 'urban_population'}, axis=1, inplace=True)

# physicians: 2016-2018 avg
physicians['mean_2016_2018'] = physicians[['2016','2017','2018']].mean(axis=1)
data = pd.merge(data,physicians[['Country Code','mean_2016_2018']],how='inner',on='Country Code')
data.rename({'mean_2016_2018': 'physicians'}, axis=1, inplace=True)

# population_density: 2018
data = pd.merge(data,population_density[['Country Code','2018']],how='inner',on='Country Code')
data.rename({'2018': 'population_density'}, axis=1, inplace=True)

# elderly_population: 2018
data = pd.merge(data,elderly_population[['Country Code','2018']],how='inner',on='Country Code')
data.rename({'2018': 'elderly_population'}, axis=1, inplace=True)

# primaryschool_enrollment: 2016-2018 avg
primaryschool_enrollment['mean_2016_2018'] = primaryschool_enrollment[['2016','2017','2018']].mean(axis=1)
data = pd.merge(data,primaryschool_enrollment[['Country Code','mean_2016_2018']],how='inner',on='Country Code')
data.rename({'mean_2016_2018': 'primaryschool_enrollment'}, axis=1, inplace=True)

## Dependent variables
# tobacco_prevalence: 2018
data = pd.merge(data,tobacco_prevalence[['Country Code','2018']],how='inner',on='Country Code')
data.rename({'2018': 'tobacco_prevalence'}, axis=1, inplace=True)

# HIV_prevalence: 2018
data = pd.merge(data,HIV_prevalence[['Country Code','2018']],how='inner',on='Country Code')
data.rename({'2018': 'HIV_prevalence'}, axis=1, inplace=True)

# overweight_percentage: 2016
data = pd.merge(data,overweight_percentage[['Country Code','2016']],how='inner',on='Country Code')
data.rename({'2016': 'overweight_percentage'}, axis=1, inplace=True)

# hypertension_prevalence: 2018
data = pd.merge(data,hypertension_prevalence[['Country Code','2018']],how='inner',on='Country Code')
data.rename({'2018': 'hypertension_prevalence'}, axis=1, inplace=True)
data['hypertension_prevalence'] = data['hypertension_prevalence']*100

# diabetes_prevalence: 2021
data = pd.merge(data,diabetes_prevalence[['Country Code','2021']],how='inner',on='Country Code')
data.rename({'2021': 'diabetes_prevalence'}, axis=1, inplace=True)

# COVID-19: 2020.12.31
COVID_19_20201231.rename({'Cumulative_cases_20201231': 'COVID_cumCases_20201231','Cumulative_deaths_20201231':'COVID_cumDeaths_20201231'}, axis=1, inplace=True)
data = pd.merge(data,COVID_19_20201231[['Country Code','COVID_cumCases_20201231','COVID_cumDeaths_20201231']],how='inner',on='Country Code')

# COVID-19: 2021.12.31
COVID_19_20211231.rename({'Cumulative_cases_20211231': 'COVID_cumCases_20211231','Cumulative_deaths_20211231':'COVID_cumDeaths_20211231'}, axis=1, inplace=True)
data = pd.merge(data,COVID_19_20211231[['Country Code','COVID_cumCases_20211231','COVID_cumDeaths_20211231']],how='inner',on='Country Code')

# COVID-19: 2022.12.31
COVID_19_20221231.rename({'Cumulative_cases_20221231': 'COVID_cumCases_20221231','Cumulative_deaths_20221231':'COVID_cumDeaths_20221231'}, axis=1, inplace=True)
data = pd.merge(data,COVID_19_20221231[['Country Code','COVID_cumCases_20221231','COVID_cumDeaths_20221231']],how='inner',on='Country Code')

# COVID-19: 2023.04.30
COVID_19_20230430.rename({'Cumulative_cases_20230430': 'COVID_cumCases_20230430','Cumulative_deaths_20230430':'COVID_cumDeaths_20230430'}, axis=1, inplace=True)
data = pd.merge(data,COVID_19_20230430[['Country Code','COVID_cumCases_20230430','COVID_cumDeaths_20230430']],how='inner',on='Country Code')


# Add 'WHO_region'
data = pd.merge(data,COVID_19_20201231[['Country Code','WHO_region']],how='inner',on='Country Code')


## Drop na
data = data.dropna()

print(data)
# print(COVID_19)

data.to_csv('/Users/eva_shao/Documents/111-2/勞動經濟學專題：實證方法與應用/term paper/data/work data/clean_data.csv', index=False)
