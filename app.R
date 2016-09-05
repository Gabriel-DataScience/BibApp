#--------------------------- Gráficos iterativos -----------------------------#
#------------------------- Sistema Biblioteca UFC ----------------------------#

source("00-pack.R", encoding = "UTF-8")
source("00-ui-elements.R", encoding = "UTF-8")
source("00-sv-elements.R", encoding = "UTF-8")


ui <-
  dashboardPage( skin = "green",
    
    dashboardHeader( title = "UFC"),
    
    dashboardSidebar(
      sidebarMenu(
        menuItem("Tutorial", tabName = "Tutorial", icon = icon("fa fa-book")),
        menuItem("Dados", tabName = "Dados", icon = icon("fa fa-usb")),
        menuItem("Tabela", tabName = "Tabela", icon = icon("fa fa-list-alt")),
        menuItem("Gráfico Univariado", tabName = "Grafico", icon = icon("fa fa-list-alt")),
        menuItem("Gráfico Bivariado", tabName = "Grafico2", icon = icon("fa fa-list-alt"))
      )
    ),
    
    dashboardBody(
      tabItems(
        tabItem(tabName = "Tutorial",
                titlePanel("Tutorial para abrir o banco de dados"),
                paste("  Esse é o Tutorial para abrir o banco de dados")
        ),
        tabItem(tabName = "Dados",
                fluidRow(
                  box( title = "Escolha dos dados", solidHeader = TRUE, status = "success", width = 4,
                       CarregarDados,
                       Header,
                       Linha,
                       Separador,
                       Decimal,
                       uiOutput("nomes_das_colunas")
                  ),
                  mainPanel(dataTableOutput("Dados"))
                )
        ),
        tabItem(tabName = "Tabela",
#                 sidebarLayout(
#                   box( title = "Variável", solidHeader = TRUE, status = "success",
#                        uiOutput("vartabela"),
#                        DownloadTabela,
#                        DownloadAll,
#                        format_arquivo_all
#                   ),
#                   mainPanel(dataTableOutput("Tabela"))
#                   
#                 )
fluidRow(

    box( title = "Variável", solidHeader = TRUE, status = "success",
         uiOutput("vartabela"),
         DownloadTabela,
         format_arquivo_Tabela
    ),
    box(title = "Variável", solidHeader = TRUE, status = "success",
        DownloadAll,
        format_arquivo_all
    )
  ,
  mainPanel(dataTableOutput("Tabela"))
  
)
          
        ),
        tabItem(tabName = "Grafico",
                fluidRow(
                  column(width=4,
                          box(title = "Escolha do Gráfico", solidHeader = TRUE, status = "success",
                             width = NULL,
                             TipoGrafico,
                             uiOutput("vargrafico")
                          ),
                          box(title = "Formatação", solidHeader = TRUE, status = "success",
                             width = NULL,
                             inserirTitulo,
                             inserirEixo
                          )
                  ),
                  column(8, 
                         box(width = NULL, status = "success" ,plotlyOutput("grafico"))
                  )
                )
          
        ),
        tabItem(tabName = "Grafico2",
                fluidRow(
                  column(width=4,
                         box(title = "Escolha do Gráfico", solidHeader = TRUE, status = "success",
                             width = NULL,
                             uiOutput("TipoGrafico2"),
                             uiOutput("vargrafico2_1"),
                             uiOutput("mults"),
                             uiOutput("vargrafico2_2"),
                             uiOutput("mults2")
                         ),
                         box(title = "Formatação", solidHeader = TRUE, status = "success",
                             width = NULL,
                             inserirTitulo2,
                             inserirEixo2
                         )
                  ),
                  column(8, 
                         box(width = NULL, status = "success" ,plotlyOutput("grafico2"))
                  )
                )
                
        )
        
      )
    )
    
  )


server <- function(input, output, session){

  #dados <- dados(input)
 # Resultado <- Gerar_Matriz_Ajustada(dados,salvar = FALSE)
  #------------------------------------------------------------------------------# 
  # função para a seleção das colunas a visualizar do banco de dados
  output$nomes_das_colunas <- renderUI({
    dados <- dados(input)
    nomes <- as.matrix(colnames(dados$dados))
    
    UIcolunas(nomes)
  })
  #------------------------------------------------------------------------------#
  #------------------------------------------------------------------------------# 
  # função para a seleção da variavel para a tabela
  output$vartabela <- renderUI({
    dados <- dados(input)
    nomes <- as.matrix(colnames(dados$dados))
    
    UIvartabela(nomes)
  })
  
  # função para a seleção do item da questão multiresposta
  output$mults <- renderUI({
    dados <- dados(input)$dados
    nomes <- names(mults(dados))
    
    if( any(nomes == input$var_grafico2_1) ){
      
      nomes2 <- nomes[which(nomes == input$var_grafico2_1)]
      nomesitens <- itensmults(dados[,which(names(dados) == nomes2)])
      
      selectInput('var_mults',
                  'Selecione o item:',
                  choices = nomesitens,
                  selected = nomesitens[1]
      )
    }

  })

  # função para a seleção do item da questão multiresposta 2
  output$mults2 <- renderUI({
    dados <- dados(input)$dados
    nomes <- names(mults(dados))
    
    if( any(nomes == input$var_grafico2_2) ){
      
      nomes2 <- nomes[which(nomes == input$var_grafico2_2)]
      nomesitens <- itensmults(dados[,which(names(dados) == nomes2)])
      selectInput('var_mults2',
                  'Selecione o item:',
                  choices = nomesitens,
                  selected = nomesitens[1]
      )
    }
    
  })
  
  # função para a seleção do tipo de gráfico bidimensional
  output$TipoGrafico2 <- renderUI({
    dados <- dados(input)$dados
    nomes <- names(mults(dados))
    
    if( any(nomes == input$var_grafico2_1) | any(nomes == input$var_grafico2_2) )
      tipo <- c("Colunas","Barras", "Setores")
    else
      tipo <- c("Colunas Superpostas Prop.","Colunas Superpostas","Colunas Sobrepostas",
                "Barras Superpostas Prop.", "Barras Superpostas", "Barras Sobrepostas",
                "Linhas")
    
    selectInput(inputId = "tipo2", label = "Tipo de gráfico:",
                choices = tipo,
                selected = tipo[3]
    )
    
  })
  
    
  #------------------------------------------------------------------------------#
  #------------------------------------------------------------------------------# 
  # função para a seleção da variavel para o gráfico
  output$vargrafico <- renderUI({
    dados <- dados(input)
    nomes <- as.matrix(colnames(dados$dados))
    
    UIvargrafico(nomes)
  })
  
  output$vargrafico2_1 <- renderUI({
    dados <- dados(input)
    nomes <- as.matrix(colnames(dados$dados))
    
    UIvargrafico2_1(nomes)
  })
  
  output$vargrafico2_2 <- renderUI({
    dados <- dados(input)
    nomes <- as.matrix(colnames(dados$dados))
    
    UIvargrafico2_2(nomes)
  })
  #------------------------------------------------------------------------------#
  
  
  #------------------------------------------------------------------------------#
  # Tabela com os dados
  output$Dados <- renderDataTable({
    dados <- dados(input)
    as.matrix(dados$dados[,input$show_vars, drop = FALSE])
  }, options = list(pageLength = 10))
  #------------------------------------------------------------------------------#
  
  mytable <- reactive({
    dados <- dados(input)
    Resultado <- Gerar_freq(dados$dados)
    return(Resultado[[req(input$var_tabela)]])
  })
  
  #------------------------------------------------------------------------------#
  # Tabela
  output$Tabela <- renderDataTable({
    mytable()
  })
  
  # função para download da Tabela em .csv
  output$downloadData <- downloadHandler(
    
    filename = function(){
      if(req(input$format_Tabela) == ".CSV")
        "Tabela freq.csv"
      else
        paste('Tabela freq', sep = '.', switch(
          input$format_Tabela, PDF = 'pdf', HTML = 'html', Word = 'docx'
        )) 
    },
    content = function(file) {
      if(req(input$format_Tabela) == ".CSV")
        write.table(mytable(), file, row.names = FALSE, sep = ";", dec = ",")
      else{
        aux <- "uma variavel"
        src <- normalizePath('04-export_document.Rmd')
        owd <- setwd(tempdir())
        on.exit(setwd(owd))
        file.copy(src, '04-export_document17.Rmd')
        
        out <- render('04-export_document17.Rmd', switch(
          input$format_Tabela,
          PDF = pdf_document(), HTML = html_document(), Word = word_document()
        ))
        file.rename(out, file)
      }
        
    }
  )
  
  output$downloadAll <-  downloadHandler(
    filename = function() {
      paste('Frequencias', sep = '.', switch(
        input$format, PDF = 'pdf', HTML = 'html', Word = 'docx'
      ))
    },
    
    content = function(file) {
      aux <- "todas variaveis"
      
      src <- normalizePath('04-export_document.Rmd')
      # temporarily switch to the temp dir, in case you do not have write
      # permission to the current working directory
      owd <- setwd(tempdir())
      on.exit(setwd(owd))
      file.copy(src, '04-export_document1.Rmd')
      
      out <- render('04-export_document1.Rmd', switch(
        input$format,
        PDF = pdf_document(), HTML = html_document(), Word = word_document()
      ))
      file.rename(out, file)
    }
  )
  
  #------------------------------------------------------------------------------#
  # Grafico
  
  output$grafico <- renderPlotly({
    dados0 <- dados(input)
    dados <- Gerar_freq(dados0$dados)
    dados <- dados[[ req(input$var_grafico) ]]

    if( any(dados[,1] == "Total") ) dados <- dados[-nrow(dados),]
    
    X <- dados[,1]
    Frequencia <- dados[,2]
    
    Titulo <-  ggtitle(input$text_titulo)
    Eixo_x <- xlab(input$text_eixo)
    Eixo_y <- ylab("Frequência")
    
    Config <- theme(
      plot.title = element_text(color="darkgreen", size=14, face="bold"),
      axis.title.x = element_text(color="darkgreen", size=14, face="bold"),
      axis.title.y = element_text(color="darkgreen", size=14, face="bold"),
      axis.text.y = element_text(face = "bold.italic", color = "darkgreen", size = 10),
      axis.text.x = element_text(face = "bold.italic", color = "darkgreen", size = 10)
    )
    
    BASE <- ggplot(na.omit(dados), aes(x = X, y = Frequencia, fill = X ))
#    BASEpie <- ggplot(na.omit(dados), aes(x = "", y = Frequencia, fill = X ))
    Colunas <- BASE + geom_bar(stat = "identity", colour = "lightgreen")
#    Pizza <- BASEpie + geom_bar(width = 1,stat = "identity") + coord_polar(theta = "y", start = 0)
    Pizza <- plot_ly(dados, labels = X, values = Frequencia, type = "pie") %>%
      layout(title = input$text_titulo)
    
    
    if(input$tipo == "Colunas") result <- Colunas + Titulo + Eixo_x + Eixo_y + 
      Config + scale_x_discrete( breaks = c("") )
    if(input$tipo == "Setores") result <- Pizza
    if(input$tipo == "Barras") result <- Colunas + coord_flip() + xlab("") + Eixo_y +
      guides(fill=FALSE) + Config + 
      scale_x_discrete( breaks = c("") ) + Titulo
    
    if(input$tipo == "Setores") result else ggplotly(result)

  })
  

  output$grafico2 <- renderPlotly({
    dados <- dados(input)$dados
    nomes <- names(mults(dados))
    
    Titulo <-  ggtitle(input$text_titulo2)
    Eixo_x <- xlab(input$text_eixo2)
    Eixo_y <- ylab("Frequência absoluta")
    
    Config <- theme(
      plot.title = element_text(color="darkgreen", size=14, face="bold"),
      axis.title.x = element_text(color="darkgreen", size=14, face="bold"),
      axis.title.y = element_text(color="darkgreen", size=14, face="bold"),
      axis.text.y = element_text(face = "bold.italic", color = "darkgreen", size = 10),
      axis.text.x = element_text(face = "bold.italic", color = "darkgreen", size = 10)
    )
    
    if( any( nomes == input$var_grafico2_1 | nomes == input$var_grafico2_2) ){
      
      aux1 <- 0; aux2 <- 0; aux3 <- 0
      
      if( any( nomes == input$var_grafico2_1) ){
        a <- req(input$var_mults)
        aux <- as.data.frame(Gerar_matriz_binaria( dados[[ input$var_grafico2_1 ]] )$Matriz)
        dadosx <- aux[a][,1]
        aux1 <- 1
      } else dadosx <- Gerar_matriz_binaria( dados[[input$var_grafico2_1]] )$Matriz
      
      if( any( nomes == input$var_grafico2_2) ){
        req(input$var_mults2)
        aux <- as.data.frame(Gerar_matriz_binaria( dados[[ input$var_grafico2_2 ]] )$Matriz)
        dadosy <- aux[input$var_mults2][,1]
        aux2 <- 1
      } else dadosy <- Gerar_matriz_binaria( dados[[input$var_grafico2_2]] )$Matriz
      
      if( aux1 == 1 & aux2 == 1) aux3 <- 1
      
      dados_aux <- data.frame(X = dadosx, Y = dadosy)
      dados_aux <- na.omit(dados_aux)
      
      if(aux1 == 1) dados_aux <- subset(dados_aux, X == 1)
      if(aux2 == 1) dados_aux <- subset(dados_aux, Y == 1)
      
      if(aux3 == 1){
        req(input$var_mults)
        req(input$var_mults2)
        tab_freq <- count(dados_aux)
        tab_freq[,1] <- "Frequência"
        aux4 <- 1
      }else{
        aux4 <- which(c(aux1,aux2) == 0)
        tab_freq <- count(dados_aux)
      }

      BASE <- ggplot( tab_freq, aes(x = tab_freq[,aux4], y = freq, fill = tab_freq[,aux4] ))+
        guides(fill=guide_legend(title=NULL))
      Colunas <- BASE + geom_bar(stat = "identity", colour = "lightgreen")
      Pizza <- plot_ly( tab_freq, labels = tab_freq[,aux4], values = freq, type = "pie") %>%
         layout(title = input$text_titulo2)
      
      if(input$tipo2 == "Colunas") result <- Colunas + Titulo + Eixo_x + Eixo_y + 
        Config + scale_x_discrete( breaks = c("") )
      if(input$tipo2 == "Setores") result <- Pizza
      if(input$tipo2 == "Barras") result <- Colunas + coord_flip() + xlab("") + Eixo_y +
        guides(fill=FALSE) + Config + 
        scale_x_discrete( breaks = c("") ) + Titulo
      
      if(input$tipo2 == "Setores") result else ggplotly(result)
      
    }else{

      dadosx <- Gerar_matriz_binaria( dados[[req(input$var_grafico2_1)]] )$Matriz
      dadosy <- Gerar_matriz_binaria( dados[[req(input$var_grafico2_2)]] )$Matriz
      
      dados_aux <- data.frame(X = dadosx, Y = dadosy)
      
      colnames(dados_aux) <- c("X","Y")
      dados_aux <- na.omit(dados_aux)
      
      BASE <- ggplot(dados_aux, aes( x = X, fill = Y))
      
      Colunas <- BASE + geom_bar( aes(y = ..count../sum(..count..)) , position = "fill", colour = "lightgreen") 
      Colunas2 <- BASE + geom_bar( position = "stack", colour = "lightgreen") 
      Colunas3 <- BASE + geom_bar( position = "dodge", colour = "lightgreen")      
      
      req(input$tipo2)
      if(input$tipo2 == "Colunas Superpostas Prop.")  result <- Colunas + Config + Titulo +
        Eixo_x  + ylab("Frequência relativa")
      if(input$tipo2 == "Colunas Superpostas")  result <- Colunas2 + Config + Titulo + Eixo_x + Eixo_y
      if(input$tipo2 == "Colunas Sobrepostas")  result <- Colunas3 + Config + Titulo + Eixo_x + Eixo_y
      if(input$tipo2 == "Barras Superpostas Prop.") result <- Colunas + coord_flip() + xlab("") +
        ylab("Frequência relativa") + Config
      if(input$tipo2 == "Barras Superpostas") result <- Colunas2 + coord_flip() + xlab("") +
        Eixo_y + Config
      if(input$tipo2 == "Barras Sobrepostas") result <- Colunas3 + coord_flip() + xlab("") +
        Eixo_y + Config
      
      if(input$tipo2 == "Linhas"){
        
        aux <- count(dados_aux, vars = c("X","Y"))
        
        result <- ggplot(data = aux, aes( x = X, y = freq ,group = Y, colour = Y)) + geom_line() +
          geom_point() + Config + Titulo + Eixo_x + Eixo_y
        
      }
      
      
      ggplotly(result)  
    }
    
    
    
  })
  
  #------------------------------------------------------------------------------#

}

shinyApp(ui = ui, server = server) 