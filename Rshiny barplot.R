# Define a dataset globally which will be available 
# both to the UI and to the server.

# Rely on the 'WorldPhones' dataset in the datasets
# package (which generally comes preloaded).
install.packages("datasets")
library(datasets)


# Trim out the non-consecutive year from
# the 'WorldPhones' dataset (the first row).
myData <- read.csv(file.choose())
myData
install.packages("shiny")
library(shiny)

# Define the overall UI
ui <-
  
  # Use a fluid Bootstrap layout
  fluidPage(    
    # Give the page a title
    titlePanel("Top 4 Assessed Value Locations"),
    
    # Generate a row with a sidebar
    sidebarLayout(   
      # Define the sidebar with one input
      sidebarPanel(
        checkboxGroupInput("z", label = h3("Select Category"), 
                           choices = list("Residential"=1,"Commercial"=2),selected=1)
      ),
      
      # Create a spot for the barplot
      mainPanel(
        plotOutput("phonePlot")  
      ) 
    )
  )


# Define a server for the Shiny app
server <- (function(input, output) {
  
  # Fill in the spot we created for a plot
  output$phonePlot <- renderPlot({
    
    # Render a barplot
    
     ifelse(input$z==1,r <- subset(myData,Categories=="Residential"),r <- subset(myData,Categories=="Commercial"))

    
    library(ggplot2)
    
    ggplot(r,aes(Location, Median.Av.Total)) + geom_bar(stat="identity")
    
   # barplot(data=r, x=Location,y=Median.Av.Total,
    #        main=paste("Phones in"),
     #       ylab="Total Assessed Value",
      #      xlab="Location"
       #   )
  })
})
shinyApp(ui = ui, server = server)
