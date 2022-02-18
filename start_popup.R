library(shiny)
library(dplyr)

ui <- fluidPage(
  dataTableOutput('my_table'),
  actionButton('change','Change query')
)

server <- function(input,output,session)
{
  # the modal dialog where the user can enter the query details.
  query_modal <- modalDialog(
    title = "Important message",
    selectInput('input_query','Select # cyl:',unique(mtcars$cyl)),
    easyClose = F,
    footer = tagList(
      actionButton("run", "Run query")
    )
  )

  # Show the model on start up ...
  showModal(query_modal)

  # ... or when user wants to change query
  observeEvent(input$change,
               {
                 showModal(query_modal)
               })

  # reactiveVal to store the dataset
  my_dataset <- reactiveVal()

  observeEvent(input$run, {
    removeModal()

    # Your query here
    my_data <- mtcars %>% filter(cyl %in% input$input_query)
    my_dataset(my_data)

  })

  # render the output
  output$my_table <- renderDataTable(my_dataset())

}

shinyApp(ui,server)
