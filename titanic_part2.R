library(dplyr)
install.packages("stringr")
library(stringr)
library(ggplot2)

titanic.test <- read.csv("/Users/akankshabakshi/Downloads/test.csv",header = TRUE)
head(titanic.test)

titanic.train <- read.csv("/Users/akankshabakshi/Downloads/train.csv",header = TRUE)
head(titanic.train)

titanic.test$Survived <- 0

str(titanic.test$Survived)
levels(titanic.test$Survived)
levels(titanic.train$Survived)

titanic.full <- rbind(titanic.test,titanic.train)
head(titanic.full)
#titanic_full <- rbind(titanic.test,titanic.train)
#titanic_full <- as.character(titanic_full$Ticket)
head(titanic_full)
#titanic.full$ticket[1:20]
str(titanic.full)

#There's no immediately apparent structure in the data, let's see if we can find some.
#We'll start with taking a look t just first char for each 
ticket_first_char <- ifelse(titanic.full$Ticket == "", " ", substr(titanic.full$Ticket,1,1))
head(ticket_first_char)

table(ticket_first_char)
unique(ticket_first_char)

#Let's make it a factor for analysis purposes and visualizations
titanic.full$ticket_first_char <- as.factor(ticket_first_char)
str(titanic.full)
unique(titanic.full$ticket_first_char)

#A high level plot of the data
ggplot(titanic.full[1:891,],aes(x=ticket_first_char, fill = Survived))+
  geom_bar()+
  ggtitle("Survivability by ticket.first.char")+
  xlab("Ticket_first_char")+
  ylab("TotalCount")

#Let's see if it matches with Pclass
ggplot(titanic.full,aes(x=ticket_first_char, fill = Survived))+
  geom_bar()+
  facet_wrap(~Pclass)+
  ggtitle("Pclass")+
  xlab("Ticket_first_char")+
  ylab("TotalCount")+
  ylim(0,150)+
  labs(fill = "Survived")

#Convert survived variable into factor
titanic.full$Survived <- as.factor(titanic.full$Survived)
str(titanic.full)


library(stringr)

#See if there is a pattern when using combination of pclass and title
#Before that,we need to generate title

extractTitle <- function(Name){
 Name <- as.character(Name)
 
 if (length(grep("Miss.",Name))>0) {
   return("Miss.")
 } else if (length(grep("Master.", Name)) >0) {
   return("Master")
 } else if (length(grep("Mrs.", Name)) >0) {
   return("Mrs.")
 } else if(length(grep("Mr.", Name)) >0) {
   return ("Mr.")
 } else {
  return ("Other")
 }
}
#Keep name of the columns properly
titles <- NULL
for(i in 1:nrow(titanic.full)){
  titles <- c(titles, extractTitle(titanic.full[i,"Name"]))
}
titanic.full$title <- as.factor(titles)

# Check for duplicate names
dup.names <- as.character(titanic.full[which(duplicated(as.character(titanic.full$Name))),"Name"])
#Take a look at those records
titanic.full[titanic.full$Name %in% dup.names,]
#Other way of implementing the same
titanic.full[which(titanic.full$Name %in% dup.names),]

#Plotting graph related to titles
ggplot(titanic.full[1:891,],aes(x= title, fill = Survived))+
  geom_bar(binwidth = 0.5)+
  facet_wrap(~Pclass)+
  ggtitle("Pclass")














