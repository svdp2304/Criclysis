for(i in 1:max(odi2$match_id)){                         ##Loop for matches
  temp <- arrange(filter(odi2, match_id == i), Inns)    ## dataframe filtered by match_id and sorted by Inns
  counter == 1
  for(j in 1:length(temp$match_id)){                    ## Loop for total iteration in match_id 'i'
    if(j == 1){
        batsman_id <- c(counter)                        ## initializing batsman_id vector with 1
        counter = counter + 1
    }
    else if(temp$Inns[j] != temp$Inns[j-1]){
      counter == 1                                      ## resetting counter when innings changes
      batsman_id <- c(batsman_id, counter)
      counter = counter + 1
    }
    else{
      batsman_id <- c(batsman_id, counter)
      counter = counter +1
    }
  }
}
batsman_id <- as.integer(batsman_id)                    ## convertng type of batsman_id to integer
odi_H1 <- cbind(odi2, batsman_id)                       ## binding batsman_id with the dataframe
