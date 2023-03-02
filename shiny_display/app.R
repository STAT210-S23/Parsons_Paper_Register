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
        p("Note that pages 255-256 and 309-312 had been cut out of the register."),
        p("Note that revenue stamps appear for the first time on page 133."),
        p("The first pages are payroll. Financial accounting records for 1861 start on page 317."),
        p("Many thanks to Zoe Jacobs and Tim Pinault (Amherst College) for technical support."),
        p("This project would not have been made possible without the efforts of Eileen Crosby (Holyoke Public Library History Room)."),
        uiOutput("tab")
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
  
  url <- a("Register page scans on Google Drive", href="https://drive.google.com/drive/u/0/folders/18Aw57Hhga52E3skMttF7sxDfL6KWO-7q")
  output$tab <- renderUI({
    tagList("Link to scanned pages:", url)
  })
  
}






# Run the application 
shinyApp(ui = ui, server = server)

