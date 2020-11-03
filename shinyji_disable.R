library(shiny)
runApp(shinyApp(
  ui = fluidPage(
    shinyjs::useShinyjs(),
    numericInput("test", "Test", 5),
    actionButton("submit", "Choose")
  ),
  server = function(input, output, session) {
    observeEvent(input$submit, {
      shinyjs::disable("test")
    })
  }
))
