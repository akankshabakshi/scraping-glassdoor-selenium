#General data investigation using R
#Load packages
install.packages("dplyr")
library(dplyr)
install.packages("data.table")
library(data.table)

#Read cms files
cms_df <- read.csv("~/CMS.csv", header = TRUE)

#View first five rows of the data frame
head(cms_df,5)

#View counts for the column selected below
table(cms_df$FirstNameoftheProvider)

#Total count of procedures without duplicate codes
length(cms_df$HCPCSCode)

table(cms_df$HCPCSCode) #Command+Enter to run

#Distinct count of procedures - HCPCS code
length(unique(cms_df$HCPCSCode)) #6048 codes

#Select one procedure and output should be count of NPIs in that ZIP code
table(cms_df$HCPCSCode)
cms_df[cms_df$HCPCSCode == '28126',]
#Select only the relevant columns
cms_df[cms_df$HCPCSCode == '28126',c('HCPCSCode','ZipCodeoftheProvider','NPI')]



#To view the data type
class(cms_df)
#convert abc into data.table for less memory consumption
abc <- cms_df
setDT(abc)
class(abc)

#To check rows and columns of the data frame
dim(cms_df)
#To display the structure of the data frame
str(cms_df)

#To remove NAs
dim(cms_df)
abc <- cms_df[,c('NPI')]
valid_rows <- complete.cases(cms_df[,"NPI"])
abc <- abc[valid_rows,]
dim(abc)

#To view counts
n_distinct(abc$NPI)
length(abc$NPI)

#To create a new column - count
abc$count <- 1
#To view column names
colnames(abc)
