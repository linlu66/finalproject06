library(png) # For writePNG function



function(input, output, session) {



  # image2 sends pre-rendered images
  output$image2 <- renderImage({
   

    if (input$type == "cloud") {
      return(list(
        src = "wordcloudplot02.png",
        contentType = "png",
        alt="cloud"
        
      ))
    } else if (input$type == "map") {
      return(list(
        src = "Rplot.jpeg",
        filetype = "jpeg",
        alt = "map"
      ))
    }

  }, deleteFile = FALSE)
}

