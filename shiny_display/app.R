library(png) # For writePNG function
library(shiny)

# Return a matrix with 2d guassian distribution
gauss2d <- function(x, y, r = 0.15) {
  exp(
    -((x - 0.5)^2 + (y - 0.5)^2) /
      (2 * r^2)
  )
}


ui <-
  fluidPage(
    titlePanel("Image output"),
    
    fluidRow(
      column(4, wellPanel(
        radioButtons("picture", "Picture:",
                     c("chainring", "face"))
      )),
      column(4,
             imageOutput("image2")
      )
    )
  )

  
server <- function(input, output) {
  # image2 sends pre-rendered images
  output$image2 <- renderImage({
    if (is.null(input$picture))
      return(NULL)
    
    if (input$picture == "face") {
      return(list(
        src = "jpg/253.jpg.png",
        contentType = "image/png",
        alt = "Face"
      ))
    } else if (input$picture == "chainring") {
      return(list(
        src = "chainring.jpg",
        filetype = "image/jpeg",
        alt = "This is a chainring"
      ))
    }
    
  }, deleteFile = FALSE)
}






# Run the application 
shinyApp(ui = ui, server = server)

