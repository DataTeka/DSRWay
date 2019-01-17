#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(gapminder)


# Define UI for application that draws a histogram
ui <- fluidPage(
  
  headerPanel("Hello from DataTeka!"),
  
  sidebarPanel(
    sliderInput("year",
                "Date",
                #
                # By default, sliderInput will format numbers like 1,957. Since we want to see 
                # 1957 we have to set the seperator to be blank "". 
                # 
                sep = "",
                #
                # Set the beginning and end values for the slider.
                #
                min = min(gapminder$year),
                max = max(gapminder$year),
                #
                # Set the starting position for the draggable part of the slider. By passing a vector
                # we can have multiple handles on a single slider
                #
                value=c(min(gapminder$year), max(gapminder$year))
                
    )
  ),
  
  mainPanel(plotOutput("main_plot"))
  
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
#  randomVals <- eventReactive(input$go, input$n)
  
#  v<- function() {
#    return(rnorm(randomVals(),mean=as.numeric(input$Vector)))  
#  }

# gapminder_yr <- renderTable(gapminder %>% filter(year==input$Godina), triped = FALSE, hover = FALSE, bordered = FALSE)
  
  output$main_plot <- renderPlot( 
    
    ggplot(data = gapminder[gapminder$year > input$year[1] & gapminder$year < input$year[2], ], aes(x = continent, y = lifeExp)) +
      geom_boxplot(outlier.colour = "hotpink") +
      geom_jitter(position = position_jitter(width = 0.1, height = 0), alpha = .2) +
      labs (title= "Life Exp. vs. Continent", 
            x = "Continent", y = "Life Exp.") +
      theme(legend.position = "none", 
            panel.border = element_rect(fill = NA, 
                                        colour = "black",
                                        size = .75),
            plot.title=element_text(hjust=0.5))
    )
}
# Run the application 
shinyApp(ui = ui, server = server)

