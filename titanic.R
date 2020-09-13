library(dplyr)
library(ggplot2)

titanic <- read.csv("~/titanic.csv",TRUE)
head(titanic)


#What was the survival rate? 
ggplot(titanic, aes(x=Survived))+
  geom_bar()


#If you really want percentages
prop.table(table(titanic$Survived))


#Add some customasization for labels and themes
ggplot(titanic, aes(x=Survived))+
  theme_bw()+
  geom_bar()+
  labs(y="Passenger Count",
       title = "Titanic Survival Rates")

#Second question: What was the survival rate by gender? 

ggplot(titanic, aes(x=Sex, fill = Survived))+
  theme_bw()+
  geom_bar()+
  labs(y="Passenger Count",
       title = "Titanic Survival Rates by Sex")

#Third Question: What was the survival rate by the class of ticket?
#Identifying classes that survived the most and not survived
ggplot(titanic, aes(x=Pclass, fill=Survived))+
  geom_bar()+
  labs(y="Passenger Count",
       title = "Titanic Survival by Pclass")


#Fourth Question: What was the survival rate by class of ticket and gender? 
#Dividing based on Pclass(using facet_wrap/facet_grid) and identifying male-female population survived in that
ggplot(titanic, aes(x=Sex, fill=Survived))+
  theme_bw()+
  facet_wrap(~Pclass)+
  geom_bar()+
  labs(y="Passenger Count",
       title = "Titanic Survival by Pclass and Sex")

#Fifth Question: What is the distribution of passenger ages? 
ggplot(titanic, aes(x=Age))+
  theme_bw()+
  geom_histogram(binwidth = 5)+
  labs(y="Passenger count",
       x="Age(binwidth=5)",
       title="Titanic Age Distribution")

#Sixth Question: What are the survival rates by age? 
ggplot(titanic, aes(x=Age, fill=Survived))+
  theme_bw()+
  geom_histogram(binwidth = 5)+
  labs(y="Passenger Count",
       x="Age(binwidth=5)",
       title = "Titanic Survival Rates by Age")

#Another great viz for this question is box and whisker plot
ggplot(titanic, aes(x=Age, fill=Survived))+
  theme_bw()+
  geom_boxplot(binwidth = 5)+
  labs(y="Passenger Count",
       x="Age(binwidth=5)",
       title = "Titanic Survival Rates by Age")

#Using geom density
ggplot(titanic, aes(x=Age, fill = Survived))+
  theme_bw()+
  facet_wrap(Sex~Pclass)+
  geom_density(alpha=0.5)+
  labs(y="Age",
       x="Survived",
       title = "Titanic Survival Rates by Age, Pclass and Sex")







  
