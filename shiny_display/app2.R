library(png) # For writePNG function
library(shiny)
library(stringr)

get_Filename <- function(string = "", pattern = "[.]"){
  header <- str_split(string = string, pattern = pattern)[[1]][1]
  display <- paste("page", header)
  return(paste("page", header))
}

jpeg_path = "../jpeg"


files <- list.files(jpeg_path)
file_names <- lapply(files, get_Filename, pattern = "[.]") |> unlist()

ui <-
  fluidPage(
    titlePanel("Image output: your working directory must be in the top level of the Parsons Paper Company GitHub repo"),
    
    fluidRow(
      column(4, wellPanel(
        radioButtons("picture", "Picture:",
                     file_names)
      )),
      column(4,
             imageOutput("image2")
      )
    )
  )

  
server <- function(input, output) {
  # image2 sends pre-rendered images
  output$image2 <- renderImage({
    index <- which(file_names == input$picture)
    return(list(
      src = paste0(jpeg_path, "/", files[index]),
      filetype = "image/jpeg",
      alt = paste("This is", input$picture)
    ))
  }, deleteFile = FALSE)
}






# Run the application 
shinyApp(ui = ui, server = server)

