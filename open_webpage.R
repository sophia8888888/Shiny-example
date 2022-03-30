library(shiny)
ui <- fluidPage(
  titlePanel("Browser test"),
  sidebarLayout(
    sidebarPanel(
      shiny::actionButton(inputId = "gen_report", label = "Generate Report")
    ),
    mainPanel(   )
  ))

server <- function(input, output) {
  observeEvent(input$gen_report,{
    browseURL("https://www.r-project.org")
  })
}

shinyApp(ui = ui, server = server)