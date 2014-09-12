library(shiny)
library(shinyAce)

shinyUI(fluidPage(
  titlePanel("Text Tokenization and Feature Hashing"),
  wellPanel(
    helpText(
      includeHTML("help.html"),
      HTML("<button type='button' class='btn' data-toggle='collapse' data-target='#instructions'>Extended instructions</button>")
    )
  ),
  
  h3("Input"),
  sidebarLayout(
    sidebarPanel(
      h4("Tokenization Options"),
      textInput("regex", "Splitting regular expression", value = "\\W+"),
      checkboxInput("lowercase", "Convert tokens to lowercase", value = FALSE),
      h4("Hash Options"),
      sliderInput("hashes",
                  "Number of hashes",
                  min = 1,
                  max = 10,
                  value = 1),
      sliderInput("dimensions",
                  "Array size",
                  min = 10,
                  max = 1000,
                  value = 50)
    ),
    mainPanel(aceEditor("text", value=paste("Here is some sample text!\n\nPlease feel free to put whatever you want in this box."), mode = "text"))
  ),
  h3("Output"),
  tabsetPanel(
    tabPanel("Token Counts", dataTableOutput("tokens")),
    tabPanel("Feature Hashes", dataTableOutput("features"))
  )
))
