
CarregarDados <-   fileInput("arquivoescolhido", label = "Escolha o seu arquivo .csv",
          accept = c(
            "text/csv",
            "text/comma-separated-values",
            "text/tab-separated-values",
            "text/plain",
            ".csv"
  ))

Inform <- strong("O arquivo possui")
Header <- checkboxInput(inputId = "header", "Cabeçalho", TRUE )
Linha <- checkboxInput(inputId = "linha", "Nome das linhas", FALSE)

Separador <- 
  radioButtons("sep", "Separador dos registros",
               c( Vírgula = ",", "Ponto e vírgula" = ";", Tabulação = "\t"),
               ";")

Decimal <-
  radioButtons("dec", "Separador de decimal",
               c( Vírgula = ",", Ponto = "."),
               ".")

TipoGrafico <-
  selectInput(inputId = "tipo", label = "Tipo de gráfico:",
              choices = c("Colunas","Barras", "Setores"),
              selected = "Setores")

# TipoGrafico2 <-
#   selectInput(inputId = "tipo2", label = "Tipo de gráfico:",
#               choices = c("Colunas Superpostas Prop.","Colunas Superpostas","Colunas Sobrepostas",
#                           "Barras Superpostas Prop.", "Barras Superpostas", "Barras Sobrepostas",
#                           "Linhas"))

inserirTitulo <-
  textInput("text_titulo", label = "Título", placeholder = "Digite o título do gráfico")

inserirEixo <-
  textInput("text_eixo", label = "Eixo x", placeholder = "Digite o titulo do eixo x")

inserirTitulo2 <-
  textInput("text_titulo2", label = "Título", placeholder = "Digite o título do gráfico")

inserirEixo2 <-
  textInput("text_eixo2", label = "Eixo x", placeholder = "Digite o titulo do eixo x")

DownloadTabela <-
  downloadButton('downloadData', 'Download tabela')

format_arquivo_Tabela <- 
  radioButtons('format_Tabela', 'Formato do documento', c('PDF', 'HTML', 'Word','.CSV'),
               inline = TRUE, selected = '.CSV')

DownloadAll <- 
  downloadButton("downloadAll","Download de todas as tabelas!")

format_arquivo_all <- 
radioButtons('format', 'Formato do documento', c('PDF', 'HTML', 'Word'),
             inline = TRUE)

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
