library(shiny)
runApp( list(ui = bootstrapPage(
  #verbatimTextOutput("results"),
  tags$script('
              $(document).on("keyup", function (e) {
              Shiny.onInputChange("keypressed", e.which);
              });
              '),
  p('This is a demo app')
)
, server = function(input, output, session) {

  observeEvent(input$keypressed,
               {
                 print(input$keypressed == 17)
               })
}
))
