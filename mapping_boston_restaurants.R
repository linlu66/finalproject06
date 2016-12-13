

library(streamR)
library(ggmap)
library(ggplot2)
library(grid)
library(dplyr)

load("my_oauth.Rdata")

filterStream("tweetsUS.json",track=c("restaurant boston"),
             timeout=120,
             oauth=my_oauth)

tweets.df <- parseTweets("tweetsUS.json",verbose=TRUE)



length(tweets.df$location)


c <- na.omit(tweets.df$location[1:953])
length(c)

g1 <- geocode(c[1:100],messaging = FALSE)
g1 <- filter(g1, lat > 20)  
# this dplyr function will get rid 
# of the NA rows and will eliminate locations south of Hawaii

g2 <- geocode(c[101:200])

g2 <- filter(g2, lat > 20)

g3 <- geocode(c[201:300])
g3 <- filter(g3, lat > 20)

dim(g1)
dim(g2)
dim(g3)

#gg <- rbind(g1,g2,g3)

load("mapping_boston_rest.Rda")

dim(gg)


map <- get_map(location='united states',zoom = 4,maptype = "terrain",
               source='google',color = 'color')

ggmap(map)+geom_point(data=gg,aes(x=lon,y=lat))


save(tweets.df, file="boston-rest.Rda")

# you can reload the data frame with load("data.Rda")
