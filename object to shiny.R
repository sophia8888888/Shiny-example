library(shiny)

x <- 5
x
deparse(substitute(x)) # is going to do the trick

#source('~/presagia-beta-multiverse/inst/code/multiverse/Utils/VarDesShiny/app.R')


fun <- function(obj) {

  # get the name of the passed object
  object_to_change <- deparse(substitute(obj))

  # get the object from a given environment
  val <- get(object_to_change, envir = .GlobalEnv)
  # ?environment

  # Save the object as a reactive value
  values <- reactiveValues(x = val)

  # Now define the app that is going to change the value of x
  ui <- shinyUI(fluidPage(
    br(),
    actionButton("quit", "Apply changes and quit"),
    textInput("new", "", value = NULL, placeholder = "Set new value of x"),
    textOutput("out")
  ))

  server <- function(input, output) {

    output$out <- renderPrint({
      values$x
    })

    # change the value of x
    observe({``
      req(input$new)
      values$x <- as.numeric(input$new)
    })

    # Apply changes and quit
    observe({
      if (input$quit == 1) {
        assign(x = object_to_change, value = values$x, envir = .GlobalEnv)
        stopApp()
      }
    })
  }
  # Run the app
  shiny::shinyApp(ui, server)
}

fun(x)

# Check the new value of x in the .GlobalEnv
x
