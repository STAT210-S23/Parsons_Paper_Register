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
file_names <- lapply(files, get_Filename, pattern = "[.]") |> unlist()

ui <-
  navbarPage("Parson's Paper Exploration",
    tabPanel(
      title = "About",
      mainPanel(
        p("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Accumsan lacus vel facilisis volutpat. Posuere lorem ipsum dolor sit. Gravida arcu ac tortor dignissim convallis. Pulvinar pellentesque habitant morbi tristique. Facilisis mauris sit amet massa vitae tortor condimentum lacinia quis. Sed turpis tincidunt id aliquet risus feugiat in. Eget dolor morbi non arcu risus quis. Ultricies lacus sed turpis tincidunt id aliquet. Ac turpis egestas integer eget aliquet nibh praesent. Est ullamcorper eget nulla facilisi etiam. Nulla aliquet enim tortor at."),
        p("Lacus luctus accumsan tortor posuere ac ut consequat semper viverra. Massa sed elementum tempus egestas sed sed risus pretium. Purus faucibus ornare suspendisse sed nisi lacus sed viverra. Lorem ipsum dolor sit amet consectetur adipiscing elit ut aliquam. Amet massa vitae tortor condimentum lacinia quis vel eros. Turpis egestas integer eget aliquet nibh praesent tristique magna sit. Rhoncus mattis rhoncus urna neque viverra. Malesuada fames ac turpis egestas integer. Amet nisl suscipit adipiscing bibendum est. Eget mi proin sed libero enim sed faucibus turpis in."),
        p("Tellus elementum sagittis vitae et leo. Pellentesque id nibh tortor id. Eget est lorem ipsum dolor sit amet consectetur adipiscing elit. Pellentesque adipiscing commodo elit at. Mus mauris vitae ultricies leo integer. Donec et odio pellentesque diam volutpat commodo. Faucibus pulvinar elementum integer enim neque volutpat ac tincidunt vitae. Auctor urna nunc id cursus metus aliquam eleifend. Et magnis dis parturient montes nascetur ridiculus. Dictum fusce ut placerat orci nulla pellentesque dignissim. Justo nec ultrices dui sapien eget mi."),
        p("Enim facilisis gravida neque convallis a cras semper. Morbi leo urna molestie at elementum eu facilisis sed. Gravida neque convallis a cras semper auctor neque vitae. Et netus et malesuada fames ac turpis egestas maecenas pharetra. Mi ipsum faucibus vitae aliquet nec ullamcorper sit. Elit scelerisque mauris pellentesque pulvinar. Sed velit dignissim sodales ut eu sem integer vitae. Nulla aliquet porttitor lacus luctus accumsan. Imperdiet massa tincidunt nunc pulvinar sapien. Neque laoreet suspendisse interdum consectetur libero id faucibus nisl tincidunt."),
        p("Tincidunt tortor aliquam nulla facilisi cras fermentum odio eu. Mattis rhoncus urna neque viverra justo nec ultrices dui. Semper eget duis at tellus at. Auctor eu augue ut lectus arcu. Nisl suscipit adipiscing bibendum est ultricies integer quis. Nulla pharetra diam sit amet nisl suscipit adipiscing. Non tellus orci ac auctor augue mauris augue neque. Lorem ipsum dolor sit amet consectetur. Maecenas sed enim ut sem viverra. Aliquam id diam maecenas ultricies mi eget mauris pharetra et. Scelerisque eu ultrices vitae auctor eu. Et ligula ullamcorper malesuada proin libero nunc consequat interdum varius.")
    )),

    
    
    tabPanel(
      title = "Pages",
      helpText("Image output: your working directory must be in the top level of the Parsons Paper Company GitHub repo"),
    
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

