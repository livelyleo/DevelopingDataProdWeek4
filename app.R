#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)

# Define UI for application that draws a histogram
ui <- fluidPage(
   # Application title
   titlePanel("Statistics on California State Fires"),
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        fluidRow(column(8,
         radioButtons("buttons","Type of Statistic:",c("Plot No. of Fires per year (Color code: Acres Burned)"="plot1","Plot the amount of damage caused for number of acres burned (color code: No. of Fires)"="plot2"))))
      ),
      
      # Show a plot of the generated distribution
      mainPanel(h5("Please select the type of plot to be seen from the left panel:"),
                h5("The following data is collected by Government of California. It represents the no. of fires taken place in the entire state of California due to arsons."),
                h5("We have attempted to show the data in two formats:"),
                h5("1. Plotting the total number of fires per year with color representing the total acres of land burned"),
                h5("2. Plotting the total cost of damage due to these fires as a function of acres burned. The color represents no. of fires"),
                h5("Any type of plot can be viewed by sleecting the option on left panel."),
         plotlyOutput("distPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  #data<-read.csv("~/Data1.csv")
  data<-as.data.frame(data)
  colnames(data)<-c("Year","No.Of.Fires","Acres.Burned","Cost.Of.Damage")
  
   output$distPlot <- renderPlotly({
     if(input$buttons=="plot1")
     {
       plot_ly(data,x=data$Year,y=data$No.Of.Fires,type="bar",color=data$Acres.Burned)%>%layout(xaxis=list(title="Year"),yaxis=list(title="No. of Fires"),legend=list(titlePanel="Acres Burned"))
       
     } else
     if(input$buttons=="plot2")
     {
       plot_ly(data,x=data$Acres.Burned,y=data$Cost.Of.Damage,color=data$No.Of.Fires,size=data$No.Of.Fires,mode="markers") %>% layout(xaxis=list(title="Acres Burned"),yaxis=list(title="Cost of Damage"),legend=list(title="No. Of Fires"))
     }
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

