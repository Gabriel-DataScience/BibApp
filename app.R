#--------------------------- Gráficos iterativos -----------------------------#
#------------------------- Sistema Biblioteca UFC ----------------------------#
#--------------------------- Gabriel Fernandes -------------------------------#
require(shiny)
require(markdown)
require(datasets)
require(fBasics)
library(shinydashboard)
library(stringr)
library(ggplot2)
library(plotly)
library(plyr)

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
                sidebarLayout(
                  box( title = "Variável", solidHeader = TRUE, status = "success",
                       uiOutput("vartabela")
                  ),
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
                             TipoGrafico2,
                             uiOutput("vargrafico2_1"),
                             uiOutput("vargrafico2_2")
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
  #------------------------------------------------------------------------------#
  #------------------------------------------------------------------------------# 
  # função para a seleção da variavel para a tabela
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
  #------------------------------------------------------------------------------#
  # Tabela
  output$Tabela <- renderDataTable({
    dados <- dados(input)
    
#      n <- which(colnames(dados$dados) ==  input$var_tabela)
    Resultado <- Gerar_freq(dados$dados)
    Resultado[[input$var_tabela]]

  })
  #------------------------------------------------------------------------------#
  
  #------------------------------------------------------------------------------#
  # Grafico
  
  output$grafico <- renderPlotly({
    dados0 <- dados(input)
    dados <- Gerar_freq(dados0$dados)
    dados <- dados[[input$var_grafico]]
    dados <- dados[-nrow(dados),]
    
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
    BASEpie <- ggplot(na.omit(dados), aes(x = "", y = Frequencia, fill = X ))
    Colunas <- BASE + geom_bar(stat = "identity", colour = "lightgreen")
#    Pizza <- BASEpie + geom_bar(width = 1,stat = "identity") + coord_polar(theta = "y", start = 0)
    Pizza <- plot_ly(dados, labels = X, values = Frequencia, type = "pie") %>%
      layout(title = input$text_titulo)
    
    
    if(input$tipo == "Colunas") result <- Colunas + Titulo + Eixo_x + Eixo_y + 
      Config + scale_x_discrete( breaks = c("") )
    if(input$tipo == "Pizza") result <- Pizza
    if(input$tipo == "Barras") result <- Colunas + coord_flip() + xlab("") + Eixo_y +
      guides(fill=FALSE) + Config + 
      scale_x_discrete( breaks = c("") ) + Titulo
    
    if(input$tipo == "Pizza") result else ggplotly(result)

  })
  

  output$grafico2 <- renderPlotly({ 
    dados <- dados(input)$dados
    
    dadosx <- Gerar_matriz_binaria(dados[,which(colnames(dados)==input$var_grafico2_1)])$Matriz
    dadosy <- Gerar_matriz_binaria(dados[,which(colnames(dados)==input$var_grafico2_2)])$Matriz
    dados_aux <- cbind(dadosx,dadosy)
    
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
    
    colnames(dados_aux) <- c("X","Y")
    dados_aux <- na.omit(dados_aux)
    
    BASE <- ggplot(dados_aux, aes( x = X, fill = Y))
    
    Colunas <- BASE + geom_bar( position = "fill", colour = "lightgreen") 
    Colunas2 <- BASE + geom_bar( position = "stack", colour = "lightgreen") 
    Colunas3 <- BASE + geom_bar( position = "dodge", colour = "lightgreen")      
    
    if(input$tipo2 == "Colunas")  result <- Colunas + Config + Titulo +
      Eixo_x  + ylab("Frequência relativa")
    if(input$tipo2 == "Colunas2")  result <- Colunas2 + Config + Titulo + Eixo_x + Eixo_y
    if(input$tipo2 == "Colunas3")  result <- Colunas3 + Config + Titulo + Eixo_x + Eixo_y
    if(input$tipo2 == "Barras") result <- Colunas + coord_flip() + xlab("") +
      ylab("Frequência relativa") + Config
    if(input$tipo2 == "Barras2") result <- Colunas2 + coord_flip() + xlab("") +
      Eixo_y + Config
    if(input$tipo2 == "Barras3") result <- Colunas3 + coord_flip() + xlab("") +
      Eixo_y + Config
    
    if(input$tipo2 == "Linhas"){
      
      aux <- count(dados_aux, vars = c("X","Y"))
      
      result <- ggplot(data = aux, aes( x = X, y = freq ,group = Y, colour = Y)) + geom_line() +
        geom_point() + Config + Titulo + Eixo_x + Eixo_y
      
    }
    
    
    ggplotly(result)
    
  })
  
  #------------------------------------------------------------------------------#

}

shinyApp(ui = ui, server = server) 