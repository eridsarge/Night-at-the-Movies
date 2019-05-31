
#Import Data
batting<-'https://raw.github.com/eridsarge/Sandlot-Superstition/master/Batting_Data.csv'
ejections<-'https://raw.github.com/eridsarge/Sandlot-Superstition/master/ejections.csv'
player_names<-'https://raw.github.com/eridsarge/Sandlot-Superstition/master/player_names.csv'
games<-'https://raw.github.com/eridsarge/Sandlot-Superstition/master/games.csv'

#Set up Data to Work with
batting_data<-read.csv(batting)
ejection_data<-read.csv(ejections)
player_names_data<-read.csv(player_names)
games_data<-read.csv(games)


#look at data variables to understand what we are working with
head(batting_data)

head(ejection_data)

head(player_names_data)

head(games_data)

#First thought, do left handed batters and pitchers really have an advantage over righties?
#Who are some of the best hitters in the data set?
#lets join to our name data so we can later look at players that perform better than others
#using dplyr package
install.packages('dplyr')
library(dplyr)

install.packages('ggplot2')
library(ggplot2)

Bat_and_Name<-inner_join(batting_data,player_names_data,by=c("batter_id"='id'))

#lets do some basic exploration
#which batters have the most home runs?
install.packages('sqldf')
library(sqldf)

#used sqldf package since I have a background in sql and sometimes prefer it over dplyr
#when performing queries that do not require mutations
Big_Hitters<-sqldf('Select last_name, first_name, count(event) as Home_Runs
      from Bat_and_Name
      where event="Home Run"
      group by last_name,first_name
      order by count(event) desc
      Limit 10
      ')

ggplot(data=Big_Hitters,aes(x=last_name,y=Home_Runs,fill=Home_Runs))+
  geom_bar(stat="identity")
#No Babe Ruth? The Sultan of Swat? The King of Crash? The Great Bambino?



#now lets look at the possible outcomes from an at bat by looking at the possible events
#we need to recode these so we can better measure our outcomes
#my inital reaction is to make them a 2 level categorical variable "Safe" or "Out"
install.packages('tidyverse')
library(tidyverse)



distinct(Bat_and_Name,event)

case_when(Bat_and_Name$event=="Single"~"Safe",
          Bat_and_Name$event=="Groundout"~"Out",
          Bat_and_Name$event=="Hit By Pitch"~"Safe",
          Bat_and_Name$event=="Walk"~"Safe",
          Bat_and_Name$event=="Forceout"~"Out",
          Bat_and_Name$event=="Pop Out"~"Out",
          Bat_and_Name$event=="Strikeout"~"Out",
          Bat_and_Name$event=="Flyout"~"Out",
          Bat_and_Name$event=="Double"~"Safe",
          Bat_and_Name$event=="Grounded Into DP"~"Out",
          Bat_and_Name$event=="Field Error"~"Safe",
          Bat_and_Name$event=="Lineout"~"Out",
          Bat_and_Name$event=="Bunt Pop Out"~"Out",
          Bat_and_Name$event=="Home Run"~"Safe",
          Bat_and_Name$event=="Sac Bunt"~"Out",
          Bat_and_Name$event=="Sac Fly"~"Out",
          Bat_and_Name$event=="Double Play"~"Safe",
          Bat_and_Name$event=="Intent Walk"~"Safe",
          Bat_and_Name$event=="Triple"~"Safe",
          Bat_and_Name$event=="Catcher Interference"~"Safe",
          Bat_and_Name$event=="Strikeout - DP"~"Out",
          Bat_and_Name$event=="Fielders Choice"~"Out",
          Bat_and_Name$event=="Runner Out"~"Out",
          Bat_and_Name$event=="Sac Fly DP"~"Out",
          Bat_and_Name$event=="Bunt Lineout"~"Out",
          Bat_and_Name$event=="Triple Play"~"Safe"
            #TRUE~"Out"
          )
