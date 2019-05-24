
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