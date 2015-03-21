library(shiny)
library(ggplot2)

# Define server logic for slider examples
shinyServer(function(input, output) {
  
  # Reactive expression to compose a data frame containing all of
  # the values
  sliderValues <- reactive({
    
    cyll <- as.numeric(input$cylinder)
    
    mpgMin <- as.numeric(input$mpgRange[1])
    mpgMax <- as.numeric(input$mpgRange[2])
    hpMin <- as.numeric(input$hpRange[1])
    hpMax <- as.numeric(input$hpRange[2])
    
    myCars <- mtcars[mtcars$cyl == cyll & mtcars$mpg >= mpgMin & mtcars$mpg <= mpgMax & mtcars$hp >= hpMin & mtcars$hp <= hpMax, ]
    
    validate(
      need(nrow(myCars) > 0, "Your selection yielded in no data")
    )
    
    if (nrow(myCars) > 0){
      myCars$num <- 1:nrow(myCars)
      myCars
      
          
    }else {
      data.frame()      
    }
    
  }) 
  
  output$sectionSummary <- renderText({
    paste("The plot and table below show the data from mtcars dataset for cars with ", 
          input$cylinder, 
          " cylinders having horse power in the range of ", 
          paste(input$hpRange, collapse='-'), 
          " and giving gas milage in the range of ", 
          paste(input$mpgRange, collapse='-'),
          ". Make your choice!!!")
  })

  output$notes1 <- renderText({
    "Please see below the table for some notes on the assignment." 
  })

  output$notes2 <- renderText({
    "Notes on the assignment:" 
  })
  
  output$notes3 <- renderText({
    "1. I have used bootstrap stylesheets for rendering. That seems to render well on Chrome compared to IE" 
  })
  
  output$notes4 <- renderText({
    "2. Not much processing is done in the server.R. Although this assignment can be extended to do some computations, generate a model etc." 
  })  
  output$notes5 <- renderText({
    "3. Some performance improvement is possible (through use of variables declared in global.R etc" 
  })    
  output$plot <- renderPlot({
 
    myCars <- sliderValues()
    
    if (nrow(myCars) > 0) {
      p <- ggplot(myCars, aes(x = hp,  y = mpg, label=rownames(myCars)), environment=environment()) 
      p <- p + geom_point(aes(colour=factor(myCars$num)), size = 3)
      #p <- p + coord_cartesian(ylim=c(0, 7))
      p <- p + geom_text(size = 5, fontface = "bold", vjust = 0, aes(colour=factor(myCars$num)), angle = 30,  position = "jitter") 
      p <- p + scale_x_continuous(limits=c(min(myCars$hp) - 20, max(myCars$hp) + 20))
      p <- p + scale_y_continuous(limits=c(min(myCars$mpg) - 2, max(myCars$mpg) + 2))
      p <- p + theme(legend.position="none")
      p
      
    } 
    
  })

output$values <- renderTable({
  #if (input$go == 0)
  #  return()  
  sliderValues()[, c("mpg", "hp")]
  })

})
