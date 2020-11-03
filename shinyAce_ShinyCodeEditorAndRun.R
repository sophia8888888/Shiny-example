# Download and install shinyAce
#install.packages('shinyAce')

library(shiny)

#runApp(system.file("examples/01-basic", package="shinyAce"))
runGitHub("shinyAce", "trestletech", subdir="inst/examples/02-eval")
