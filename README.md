# Research_DALYs-economic-growth
This repo contains the data and the codes that I use for my term paper "Exploring the Relationship Between Economic Growth, Income Levels, and Public Health: An Analysis of Global Data".

## Data
The data I use in the term paper consist two components: public health data and socioeconomic data of countries worldwide. The public health data contain the disability-adjusted life years (DALYs). The socioeconomic data include GDP, GDP growth, GDP per capita, urban population, physician (density), population density, elderly population, unemployment (rate), and population.
I combine all the data into a collection of panel data named "DALY_panel_data.csv".

## Code
In the file "code", there are one Python code file and three R code files in it. I perform the analysis through these codes in order.
1. data cleaning.py: I use this code to clean the raw data downloaded from World Bank and WHO.
2. DALY-making panel data.R: I use this code to organize the data into panel data for the later fixed-effect regression analysis.
3. DALY-panel analysis.R: I use this code to conduct fixed-effect regression for the panel data.
4. DALY-panel analysis-income group.R: I use this code to conduct a simple regression for the effect of different income groups on DALYs.
