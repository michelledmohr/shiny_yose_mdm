### Attach necessary packages
library(shiny)
library(tidyverse)
install.packages("palmerpenguins")
library(palmerpenguins)

### Create the user interface:
ui <- fluidPage(
  titlePanel("White pine blister rust assessments in Yosemite National Park"),
  sidebarLayout(
    sidebarPanel("Plots in Yosmite National Park",
                 
       radioButtons(
         inputId = "penguin_species",
         label = "Choose plot number",
         choices = c("1", "2", "3", "4", "5", "6", "7", "8", "9", "10")
       )          
      ),
    mainPanel("put my graph here")
  ) # end sidebar layout
) # end of my fluidPage

### Create the server function:
server <- function(input, output) {
  
  penguin_select <- reactive({
    penguins_df <- penguins %>%
      filter(species == input$penguin_species)
    return(penguins_df)
  }) # end of penguin select reactive function 
  
  output$penguin_plot <- renderPlot({
    ggplot(data = penguin_select()) +
      geom_point(aes(x = flipper_length_mm, y = body_mass_g))
  }) # end of penguin plot 
} # end of server

### Combine them into an app:
shinyApp(ui = ui, server = server)

