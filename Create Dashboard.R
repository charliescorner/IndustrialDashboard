library(shiny)
library(shinydashboard)
library(ggplot2)

#plot1values
a = 75
b = a * .15
#sliderinputs
c = 100 #(totalmachines)
d = 75 #(howmanymachinesareconnectedtoday)
#DD%completes
e = 85
f = 27

ui <- dashboardPage(
    skin = "yellow",
  dashboardHeader(
    title = "Johnson's Chemical",
  dropdownMenu(type = "messages",
               messageItem(
                 from = "California Refinery",
                 message = "Refinery closed because of wildfires."
               ),
               messageItem(
                 from = "Support",
                 message = "The new server is ready.",
                 icon = icon("life-ring"),
                 time = "2020-12-11"
               ),
               taskItem(value = e, color = "green",
                        "New Equipment Training"
               ),
               taskItem(value = f, color = "red",
                        "Progress on Fargo Pipeline"
               )
             )
          ),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Production Output", tabName = "productionoutput", icon = icon("calendar")),
      menuItem("Ask Assistant", icon = icon("comment-dots"), 
               href = "https://vcheng2.github.io/COVID/")
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "dashboard",
              fluidRow(
                box(plotOutput("plot1", height = 300, width = 300),
                    title = "Total Production Forecast (Liters)"),
                
                box(
                  title = "Sensor control observations:",
                  sliderInput("slider", "Machines connected to IOT:", 0, c, d),
                )
              ),
              br(),
              map,),
      
      tabItem(tabName = "productionoutput",
            fluidPage(
              selectInput("download1", "Select Plant", choices = c("California", "Alaska", "North Dakota", "Texas")),
              downloadButton("downloadData1"),
              br(),
              
              selectInput("download2", "Select Sensor", choices = c("Pump1", "Pump2", "Pump3", "Pump4", "Pump5", "Pump6", "Pump6")),
              downloadButton("downloadData2"),
              br(),br(),
              
              box(plotOutput("plot2", height = 350, width = 350),
                  title = "Total Output Sensor (Liters)"),
            )
         )
       )
     )
   )

server <- function(input, output, session) {
  histdata <- rnorm(500, mean = a,  sd = b)
  plotplot <- c(5.5, 4.7, 3.8, 5.1, 3.4, 2.1, .84, .07, 0, 0, 0, 0)
  
  output$plot1 <- renderPlot({
    data1 <- histdata[seq_len(input$slider)]
    barplot(data1)
  })
    
  output$plot2 <- renderPlot({
    data2 <- plotplot
    plot(plotplot, type = "o", xlab = "Hour", ylab = "Liters")
  })
  
}

shinyApp(ui, server)