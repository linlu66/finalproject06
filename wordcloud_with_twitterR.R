
library(devtools)
library(twitteR)
library(tm)
library(wordcloud)
library(sp)
library(RgoogleMaps)
library(ggmap)
library(ggplot2)
library(maptools)
library(datasets)
library(tigris)

api_key <- "jZD20rkQPynqQ2bPXj4jPzPBp"
api_secret <- "FfbE0lSBQIlrKhrLI5H8SEq67gM4sfxmNrJcuKheEPvYSx3rZl"
access_token <- "4372594763-Y03isNmBPUIaTvOz9V8pIj9orOwmwHGW9ivmPTh"
access_token_secret <- "JGoiLtpy8I7Gdadt4RCxCHfbqJdzG0U2vQF2I9nnbCxfz"
  


setup_twitter_oauth(api_key, api_secret, access_token, access_token_secret)


# [1] "Using direct authentication"
# Use a local file ('.httr-oauth'), to cache OAuth access credentials between R sessions?
# 
# 1: Yes
# 2: No
# 
# Selection: 1
# Adding .httr-oauth to .gitignore

########################################## my code 

res_boston<- searchTwitter('restaurant Boston', lang='en',n=500)
res_boston.df<- twListToDF(res_boston)
res_boston_text <- gettext(res_boston.df$text)


res_boston_corpus <- Corpus(VectorSource(res_boston_text)) 



inspect(res_boston_corpus[5])
res_boston_clean <- tm_map(res_boston_corpus,removePunctuation)
#res_boston_clean <- tm_map(res_boston_clean,content_transformer(tolower))
res_boston_clean <- tm_map(res_boston_clean,removeWords,stopwords("english"))
res_boston_clean <- tm_map(res_boston_clean,removeNumbers)
res_boston_clean <- tm_map(res_boston_clean,stripWhitespace)
res_boston_clean <- tm_map(res_boston_clean,removeWords,c("restaurant","boston"))

wordcloud(res_boston_clean)
wordcloud(res_boston_clean,random.order = F)
wordcloud(res_boston_clean,col=rainbow(50))

#meaure the similarity between different documents.
#word frequency counts can be used to classify documents and measure similarity between documents.  
#For you, the word frequency list can guide you to modify the stop list used to remove common words 
#-- which will give you word clouds that are more representative of the tweets you have collected
tdm <- TermDocumentMatrix(res_boston_corpus)
findAssocs(tdm, c("food", "wine", "sauce"), c(0.7, 0.75, 0.1))

findFreqTerms(tdm, lowfreq = 0, highfreq = Inf)

findAssocs(tdm, c("food", "restaurant", "cambridge"), c(0.7, 0.75, 0.1))





