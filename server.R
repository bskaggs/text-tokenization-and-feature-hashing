library(shiny)
library(Matrix)
library(hashFunction)

tokenize <- function(text, regex = "\\W+", lowercase = FALSE) {
  tokens <- strsplit(text, regex)
  if (lowercase) {
    tokens <- lapply(tokens, tolower)
  }
  tokens
}

#http://en.wikipedia.org/wiki/Feature_hashing
features <- function(tokens, ncol, numHashes = 1) {
  matrix <- Matrix(0, nrow = 1, ncol = ncol, sparse = TRUE)
  numTokens <- 0
  
  lapply(tokens, function(x) {
    numTokens <<- numTokens + 1
    for (i in 1:numHashes) {
      h <- murmur3.32(paste(x, i))
      s <- sign(h)
      pos <- abs(h) %% ncol
      matrix[1, pos] <<- matrix[1, pos] + s
    }
  })
  matrix
}

shinyServer(function(input, output) {
  output$tokens <- renderDataTable({
    if (nchar(input$text) > 0) {
      tokens <- tokenize(input$text, regex = input$regex, lowercase = input$lowercase)
      df <- as.data.frame(table(tokens))
      names(df) <- c("Token", "Count")
      df
    } else {
      data.frame(Token = c(), Count = c())
    }
  })
  
  output$features <- renderDataTable({
    tokens <- tokenize(input$text, regex = input$regex, lowercase = input$lowercase)
    feats <- features(tokens[[1]], input$dimensions, numHashes = input$hashes)
    df <- summary(feats)
    df$i <- NULL
    names(df) <- c("Position", "Value")
    df
  })
})