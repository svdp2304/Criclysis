# Loading necessary packages
library(dplyr)

## Loading the data

rm(list = ls(all=T))
odi <- read.csv("I:/R Prog/Cricket Scores - ODI.csv")

## checking the structure and summary of the data

head(odi)
str(odi)
summary(odi)

## cleaning the data
# converting Runs.1 to integer
odi$Runs.1 <- as.integer(as.character(odi$Runs.1)) #NAs denote DNB

# converting Not.Out to factor
odi$Not.Out <- as.factor(odi$Not.Out)

# converting Batted to factor
odi$Batted <- as.factor(odi$Batted)

# converting Mins to integer
odi$Mins <- as.integer(as.character(odi$Mins))

# converting BF to integer
odi$BF <- as.integer(as.character(odi$BF))

# converting X4s to integer
odi$X4s <- as.integer(as.character(odi$X4s))

# converting X6s to integer
odi$X6s <- as.integer(as.character(odi$X6s))

# converting SR to numeric
odi$SR <- as.numeric(as.character(odi$SR))

# deleting Opposition variable
# odi <- odi[, !names(odi) %in% "Opposition", drop = F]

# converting Start.Date to date
odi$Start.Date <- as.Date(as.character(odi$Start.Date), format = "%d-%b-%y")
str(odi)
summary(odi)

## creating new variables for analysis

# Ordering the dataframe by Start.Date, Ground and Inns

odi_new <- odi %>%
  arrange(Start.Date, Ground, Inns)


# creating a new variable match_id

for(i in 1:length(odi_new$Start.Date)){
  if(i == 1){
    id = 1
    match_id <- c(id)
  }
  else if((odi_new$Ground[i] != odi_new$Ground[i-1]) | (odi_new$Start.Date[i] != odi_new$Start.Date[i-1])){
    match_id <- c(match_id, id + 1)
    id = id + 1
  }
  else{
    match_id <- c(match_id, id)
  }
}
match_id <- as.integer(match_id)
odi1 <- cbind(odi_new, match_id)


# creating a new variable decade

for(i in 1:length(odi$Start.Date)){
  if(i == 1){
    date <- as.integer(format(odi$Start.Date[i], "%Y"))
    x <- (floor(date/10)) * 10
    decade <- c(x)
  }
  else{
    date <- as.integer(format(odi$Start.Date[i], "%Y"))
    x <- (floor(date/10)) * 10
    decade <- c(decade, x)
  }
}
decade <- as.factor(decade)
odi2 <- cbind(odi1, decade)

# creating a new variable batsman_id


for(i in 1:max(odi2$match_id)){
  if(i == 1){
    temp <- filter(odi2, match_id == i)
    counter = 1
    for(j in 1:length(temp$match_id)){
      if(j == 1){
        batsman_id <- c(counter)
        counter = counter + 1
      }
      else if(temp$Inns[j] != temp$Inns[j-1]){
        counter = 1
        batsman_id <- c(batsman_id, counter)
        counter = counter + 1
      }
      else{
        batsman_id <- c(batsman_id, counter)
        counter = counter +1
      }
    }
  }
  else{
    temp <- filter(odi2, match_id == i)
    counter = 1
    for(j in 1:length(temp$match_id)){
      if(j == 1){
        batsman_id <- c(batsman_id, counter)
        counter = counter + 1
      }
      else if(temp$Inns[j] != temp$Inns[j-1]){
        counter = 1
        batsman_id <- c(batsman_id, counter)
        counter = counter + 1
      }
      else{
        batsman_id <- c(batsman_id, counter)
        counter = counter +1
      }
    }
  }
}
batsman_id <- as.integer(batsman_id)
odi_H1 <- cbind(odi2, batsman_id)

