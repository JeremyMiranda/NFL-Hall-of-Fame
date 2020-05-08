#Abe Stephenson, Jeremy Miranda group 11
# stat 480 final projects
# data wrangling


# Imports
library(fivethirtyeight)
library(tidyverse)
library(ggplot2)

#538 data set
library(fivethirtyeight)
wr = nflwr_hist
##View(wr)

# our data sets, #1 
#REPLACE WITH YOUR OWN FILEPATH!
football = read_csv("~/classes/2020spring-480stat/project/football.csv")
complete = football
head(complete)

#out data sets #2 
#REPLACE WITH YOUR OWN FILEPATH!
hofPositions = read_csv("~/classes/2020spring-480stat/project/HoFPlayer_Position_updated.csv")
hofPositions = select(hofPositions, -X1)
hofPositions = hofPositions %>%
  mutate(hof = "yes")


#renaming "name" column so that we can join tables
wr = rename(wr, name = player_name)
complete = rename(complete, name = Player)
hofPositions = rename(hofPositions, name = Player)
complete = select(complete, -Rank)

#Clean off asterisks because we will cross reference HOF players later
complete$name = gsub( "\\*", "", as.character(complete$name) )


# # We only want post merger players, to deal with one less confounding variable
# nfl = complete %>%
#   filter(From > 1969)

# ## try all the joins because I don't fully understand the difference between them 
# #left join
# leftNfl = nfl %>%
#   left_join(wr, by = "name")
# 
# #right join
# rightNfl = nfl %>%
#   right_join(wr, by = "name")
# View(rightNfl)
# 
# #inner join
# innerNfl = nfl %>%
#   inner_join(wr, by = "name")

# #full join
# fullNfl = nfl %>%
#   full_join(wr, by = "name")

# # find players where there was a name conflict
# nameConflict = fullNfl[grep("2.", fullNfl$name),]
# 
# write_csv(fullNfl, "~/classes/nfl.csv")
# write_csv(nameConflict, "~/classes/nflNameDuplicates.csv")

## attempting to see differences between the joined tables
#install.packages(compareDF)
#library(compareDF)
#differences = compare_df(leftNfl, rightNfl, c("name"))

#Want to make sure that chopping out the pre 1970 players is not making too big an impact
allFootball = complete %>%
  full_join(wr, by = "name")

# find players where there was a name conflict
nameConflictAll = allFootball[grep("2.", allFootball$name),]

#bcs statistic is only present in 1/15 cases, removing it
allFnobcs = select(allFootball, -bcs_rating)
#nflnobcs = select(fullNfl, -bcs_rating)

#Want to see players that appear in both 538 and our data set
naFreeAll = na.omit(allFnobcs) #2426 observations
#naFreeNFL = na.omit(nflnobcs)

write_csv(naFreeAll, "~/classes/ourDatav3.csv")


#join set with positions set
completeData = naFreeAll %>% 
  full_join(hofPositions, by = "name") #2616

completeData2 = allFnobcs %>%
  full_join(hofPositions, by = "name")

completeData3 = complete %>%
  full_join(hofPositions, by = "name")

write_csv(completeData, "~/classes/copmleteData")
