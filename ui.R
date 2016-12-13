library(shiny)


fluidPage(
  titlePanel("Image output"),

  fluidRow(

      radioButtons("type","Image type:",c("wordcloud" = "cloud","mapping"="map"))
                  
      ),
  imageOutput("image2")
  
)

