
CarregarDados <-   fileInput("arquivoescolhido", label = "Escolha o seu arquivo .csv",
          accept = c(
            "text/csv",
            "text/comma-separated-values",
            "text/tab-separated-values",
            "text/plain",
            ".csv"
  ))

Header <- checkboxInput(inputId = "header", "Header", TRUE)
Linha <- checkboxInput(inputId = "linha", "Linha", FALSE)

Separador <- 
  radioButtons("sep", "Separador",
               c( Virgula = ",", Ponto_e_Virgula = ";", Tab = "\t"),
               ";")

Decimal <-
  radioButtons("dec", "Decimal",
               c( Virgula = ",", ponto = "."),
               ".")

TipoGrafico <-
  selectInput(inputId = "tipo", label = "Tipo de gráfico:",
              choices = c("Colunas","Barras", "Pizza"))

TipoGrafico2 <-
  selectInput(inputId = "tipo2", label = "Tipo de gráfico:",
              choices = c("Colunas","Colunas2","Colunas3","Barras"))

inserirTitulo <-
  textInput("text_titulo", label = "Título", value = "Digite o título do gráfico")

inserirEixo <-
  textInput("text_eixo", label = "Eixo x", value = "Digite o titulo do eixo x")

inserirTitulo2 <-
  textInput("text_titulo2", label = "Título", value = "Digite o título do gráfico")

inserirEixo2 <-
  textInput("text_eixo2", label = "Eixo x", value = "Digite o titulo do eixo x")

#-----------------------------------------------------------------------------#
#----------------- UI funções

UIcolunas <- function(nomes)
  checkboxGroupInput('show_vars', 
                     'Colunas a mostrar:', 
                     choices = nomes,
                     selected = nomes[1])

UIvartabela <- function(nomes)
  selectInput('var_tabela', 
              'Selecione a variável:', 
              choices = nomes,
              selected = nomes[1])

UIvargrafico <- function(nomes)
  selectInput('var_grafico', 
              'Selecione a variável:', 
              choices = nomes,
              selected = nomes[1])

UIvargrafico2_1 <- function(nomes)
  selectInput('var_grafico2_1', 
              'Selecione a variável do eixo x:', 
              choices = nomes,
              selected = nomes[2])

UIvargrafico2_2 <- function(nomes)
  selectInput('var_grafico2_2', 
              'Selecione a variável do eixo y:', 
              choices = nomes,
              selected = nomes[1])