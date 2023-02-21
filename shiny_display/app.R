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
clean_files <- files[str_detect(files, "[0-9][0-9][0-9]\\.jpeg")]  # check for correct format
file_names <- lapply(clean_files, get_Filename, pattern = "[.]") |> unlist()

ui <-
  navbarPage("Parsons Paper Company Payroll Register Exploration",
    tabPanel(
      title = "About",
      mainPanel(
        p("This app displays information about a payroll register for the Parsons Paper Company (Holyoke, MA) from 1861-1869."),
        p("Scans, image manipulation, and analyses conducted by Amherst College students, faculty, and staff in STAT210 (Mining the History of Holyoke)."),
        p("Additional support was provided by Eileen Crosby (Holyoke Public Library History Room).")
    )),

    
    
    tabPanel(
      title = "Pages",
      helpText("Image output:"),
    
      fluidRow(
        column(4, wellPanel(
          radioButtons("picture", "Picture:",
                       file_names)
        )),
        column(4,
               imageOutput("image")
        )
      )
      
    )
  )

  
server <- function(input, output) {
  # image2 sends pre-rendered images
  output$image <- renderImage({
    index <- which(file_names == input$picture)
    src <- paste0(jpeg_path, "/", files[index])
    results <- file.exists(src)
    if (!results) {
      showNotification(paste0("unable to open ", src, "\n"))
    }
    return(list(
      src = src,
      filetype = "image/jpeg",
      alt = paste("This is", input$picture)
    ))
  }, deleteFile = FALSE)
}






# Run the application 
shinyApp(ui = ui, server = server)

