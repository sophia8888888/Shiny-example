library(shiny)
library(rhandsontable)
ui=fluidPage(
  tags$script('
              $(document).on("keydown", function (e) {
              Shiny.onInputChange("keypressed", e.which);
              });
              $(document).on("keyup", function (e) {
              Shiny.onInputChange("keypressed", 16);
              });
              '),
  # tags$script('
  #             $(document).on("keydown", function (e) {
  #             if(event.ctrlKey){
  #             Shiny.onInputChange("keypressed", 17);
  #             }
  #             });
  #             '),
  rHandsontableOutput('table'),
  verbatimTextOutput('selected')

)

server=function(input,output,session)({

  values <- reactiveValues()
  df=data.frame(N=c(1:10),L=LETTERS[1:10],M=LETTERS[11:20])
  output$table=renderRHandsontable(
    rhandsontable(df,selectCallback = TRUE,readOnly = FALSE)
  )
  output$selected=renderPrint({
    cat('Selected Row:',input$table_select$select$r)
    cat('\nSelected Column:',input$table_select$select$c)
    cat('\nSelected Cell Value:',
        input$table_select$data[[
          input$table_select$select$r]][[input$table_select$select$c]])
    cat('\nSelected Range: R',input$table_select$select$r,
        'C',input$table_select$select$c,':R',input$table_select$select$r2,
        'C',input$table_select$select$c2,sep="")
    cat('\nChanged Cell Row Column:',input$table$changes$changes[[1]][[1]],
        input$table$changes$changes[[1]][[2]])
    cat('\nChanged Cell Old Value:',input$table$changes$changes[[1]][[3]])
    cat('\nChanged Cell New Value:',input$table$changes$changes[[1]][[4]])
    cat("\n+++++++++++")
    cat('\nSelected Row after control:',input$table_select$select$r)
    print(input$table_select)

    if(!is.null(values[["before"]])){
      cat('\nSelected Row before control:',values[["before"]])
    }
  })

  observeEvent(input$keypressed,
               {print(input$keypressed == 17)
                 if ( input$keypressed == 17){
                 values[["before"]]  = input$table_select$select$r
               }
               })



}) # end server
shinyApp(ui = ui, server = server)

