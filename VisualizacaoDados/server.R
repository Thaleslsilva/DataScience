
function(input, output, session) {
  
  # pkgStream é um objeto que representa o fluxo de
  # Download de novos dados de pacotes; Retorna
  # o número de novos downloads desde a última atualização.
  pkgStream <- packageStream(session)
  
  # Idade máxima dos dados (5 minutes)
  maxAgeSecs <- 60 * 5
  
  # pkgData é um objeto que acumula valores de pkgStream, 
  # descartando quaisquer que sejam mais antigos do que MaxAgeSecs.
  pkgData <- packageData(pkgStream, maxAgeSecs)
  
  # Contabiliza o total de linhas no objeto pkgStream
  dlCount <- downloadCount(pkgStream)
  
  # Total de usuários únicos
  usrCount <- userCount(pkgStream)
  
  # Tempo total da sessão
  startTime <- as.numeric(Sys.time())
  
  output$rate <- renderValueBox({
    # O downloadRate é o número de linhas no pkgData desde
    # startTime ou maxAgeSecs, o que for mais recente
    elapsed <- as.numeric(Sys.time()) - startTime
    downloadRate <- nrow(pkgData()) / min(maxAgeSecs, elapsed)
    
    valueBox(
      value = formatC(downloadRate, digits = 1, format = "f"),
      subtitle = "Downloads por segundo (últimos 5 min)",
      icon = icon("area-chart"),
      color = if (downloadRate >= input$rateThreshold) "yellow" else "aqua"
    )
  })
  
  output$count <- renderValueBox({
    valueBox(
      value = dlCount(),
      subtitle = "Total downloads",
      icon = icon("download")
    )
  })
  
  output$users <- renderValueBox({
    valueBox(
      usrCount(),
      "Usuários únicos",
      icon = icon("users")
    )
  })
  
  output$packagePlot <- renderBubbles({
    if (nrow(pkgData()) == 0)
      return()
    
    order <- unique(pkgData()$package)
    df <- pkgData() %>%
      group_by(package) %>%
      tally() %>%
      arrange(desc(n), tolower(package)) %>%
      # Mostra apenas os Top 60 (mais do que isso pode deixar o gráfico poluído)
      head(60)
    
    bubbles(df$n, df$package, key = df$package)
  })
  
  output$packageTable <- renderTable({
    pkgData() %>%
      group_by(package) %>%
      tally() %>%
      arrange(desc(n), tolower(package)) %>%
      mutate(percentage = n / nrow(pkgData()) * 100) %>%
      select("Nome do Pacote" = package, "% de downloads" = percentage) %>%
      as.data.frame() %>%
      head(13)
  }, digits = 1)
  
  output$downloadCsv <- downloadHandler(
    filename = "cranlog.csv",
    content = function(file) {
      write.csv(pkgData(), file)
    },
    contentType = "text/csv"
  )
  
  output$rawtable <- renderPrint({
    orig <- options(width = 1000)
    print(tail(pkgData(), input$maxrows))
    options(orig)
  })
}