#####################################################################
# Crandash App - Dashboard com dados de downloads de pacotes do CRAN
# Arquivo para organização dos dados que vão alimentar o Dashboard
#####################################################################

# Pacotes (instale os pacotes antes de executar o projeto)

# install.packages(c("shiny", "dplyr", "htmlwidgets", "digest", "bit", "devtools"))
# devtools::install_github("rstudio/shinydashboard")
# devtools::install_github("jcheng5/bubbles")
# devtools::install_github("hadley/shinySignals")

library(shiny)
library(shinySignals)
library(dplyr)
library(shinydashboard)
library(bubbles)
source("bloomfilter.R")

# Criando um dataframe vazio para alimentar os dados
prototype <- data.frame(date = character(), time = character(),
                        size = numeric(), r_version = character(), r_arch = character(),
                        r_os = character(), package = character(), version = character(),
                        country = character(), ip_id = character(), received = numeric())

# Conecta o streaming de log de dados do site cran.rstudio.com e
# retorna as expressões que server resultado cumulativo para o dataframe
packageStream <- function(session) {
  # Conecta a fonte de dados
  sock <- socketConnection("cransim.rstudio.com", 6789, blocking = FALSE, open = "r")
  # Encerra a sessão
  session$onSessionEnded(function() {
    close(sock)
  })
  
  # Retorna novas linhas
  newLines <- reactive({
    invalidateLater(1000, session)
    readLines(sock)
  })
  
  # Transforma novas linhas em um dataframe
  reactive({
    if (length(newLines()) == 0)
      return()
    read.csv(textConnection(newLines()), header=FALSE, stringsAsFactors=FALSE,
             col.names = names(prototype)
    ) %>% mutate(received = as.numeric(Sys.time()))
  })
}

# Acumula as linhas do pkgStream ao longo do tempo e descarta dados antigos fora da janela de tempo considerada
packageData <- function(pkgStream, timeWindow) {
  shinySignals::reducePast(pkgStream, function(memo, value) {
    rbind(memo, value) %>%
      filter(received > as.numeric(Sys.time()) - timeWindow)
  }, prototype)
}

# Conta o número total de linhas pkgStream
downloadCount <- function(pkgStream) {
  shinySignals::reducePast(pkgStream, function(memo, df) {
    if (is.null(df))
      return(memo)
    memo + nrow(df)
  }, 0)
}

# Conecta no CRAN e probabilisticamente conta o número de usuários únicos
userCount <- function(pkgStream) {
  bloomFilter <- BloomFilter$new(5000, 0.01)
  total <- 0
  reactive({
    df <- pkgStream()
    if (!is.null(df) && nrow(df) > 0) {
      ids <- paste(df$date, df$ip_id) %>% unique()
      newIds <- !sapply(ids, bloomFilter$has)
      total <<- total + length(newIds)
      sapply(ids[newIds], bloomFilter$set)
    }
    total
  })
}
