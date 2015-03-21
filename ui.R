library(shiny)
library(shinythemes)

# Define UI for slider demo application
shinyUI(fluidPage(theme = shinytheme("spacelab"),

  titlePanel("Data Science Specilization Asssignment"),
  br(),
  
  #  Application title
  titlePanel("Input values"),
  
  # Sidebar with sliders that demonstrate various available
  # options
  sidebarLayout(
    sidebarPanel(
      
      selectInput("cylinder", "Cylinder:", 
                  choices = c(4,6,8)),
      
      # provide range for Mpg  
      sliderInput("mpgRange", "Mpg:",
                  min = floor(min(mtcars$mpg)), max = ceiling(max(mtcars$mpg)), value = c(floor(min(mtcars$mpg)),ceiling(max(mtcars$mpg)))),
      
      # provide range for hp
      sliderInput("hpRange", "HP:",
                  min = floor(min(mtcars$hp)), max = ceiling(max(mtcars$hp)), value = c(floor(min(mtcars$hp)),ceiling(max(mtcars$hp))))
      #actionButton("go", "Submit")
      ),
    
    # Show a table summarizing the values entered
    mainPanel(
      h4(textOutput("sectionSummary", container = span)),
      h4(textOutput("notes1", container = span)),
      br(),
      
      plotOutput('plot'),
      tableOutput("values"),
      h4(textOutput("notes2", container = span)),
      h4(textOutput("notes3", container = span)),
      h4(textOutput("notes4", container = span)),
      h4(textOutput("notes5", container = span))
      #textOutput("notes1")
      
    )
  )
))