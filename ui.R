#--------------------------- Gráficos iterativos -----------------------------#
#------------------------- Sistema Biblioteca UFC ----------------------------#

source("00-pack.R", encoding = "UTF-8")
source("00-ui-elements.R", encoding = "UTF-8")
source("00-sv-elements.R", encoding = "UTF-8")
source("03-ui_Tutor.R", encoding = "UTF-8")
# Início Pagina do Usuário
#------------------------------------------------------------------------------#

shinyUI(
  dashboardPage( skin = "blue",
                 
                 # dashboardHeader(title = "Bibliotecas - UFC"),
                 dashboardHeader(title = "Bibliotecas - UFC"),
                 # tags$li(class = "dropdown",
                 # tags$img(height = "20px",  src="brasaoufc.png")
                 # )),
                 
                 
                 dashboardSidebar(
                   sidebarMenu(
                     menuItem("Tutorial", tabName = "Tutorial", icon = icon("book", lib = "font-awesome")),
                     menuItem("Dados", tabName = "Dados", icon = icon("usb")),
                     menuItem("Tabela", tabName = "Tabela", icon = icon("list-alt")),
                     menuItem("Gráfico Univariado", tabName = "Grafico", icon = icon("pie-chart")),
                     menuItem("Gráfico Bivariado", tabName = "Grafico2", icon = icon("bar-chart"))
                   ),
                   br(),
                   br(),
                   
                   # div("Universidade Federal do Ceará",style = "font-size: 10pt"),
                   # div("Campus do Pici Prof. Prisco Bezerra",style = "font-size: 10pt"), 
                   # div("Bloco 910",style = "font-size: 10pt"),
                   # div("Fone: +55 85 3366-9848/9840",style = "font-size: 10pt"),
                   # HTML('<Center><img src="ufc.jpg" width="125" height="50"></Center>'),
                   div(a(img(src='brasaoufc.jpg', height = 150, width = 175)), align = "center"),
                   div("Shiny app: ", a(target="_blank", "Gabriel Fernandes e Ronald Targino"), align="left", 
                       style = "font-size: 8pt"),
                   
                   div("Base R code: ", a(target="_blank", "Gabriel Fernandes e Ronald Targino"), align="left", 
                       style = "font-size: 8pt")
                   
                 ),
                 
                 dashboardBody(
                   tabItems(
                     tabItem(tabName = "Tutorial",
                             #titlePanel("Tutorial para abrir o banco de dados"),
                             box(title = strong("Aplicativo desenvolvido pelo LEMA-UFC"), status = "danger", width = 15,
                                 solidHeader = FALSE,
                                 # div(a(href="http://www.ufc.br/", target="_blank",
                                 #       strong("Universidade Federal do Ceará  - UFC"),style="color:black")),   
                                 div(a(href="http://www.dema.ufc.br/consultoria-estatistica", target="_blank",
                                       strong("Laboratório de Estatística e Matemática Aplicada - LEMA"),style="color:black")),
                                 div(a(href="http://www.dema.ufc.br/", target="_blank",
                                       strong("Departamento de Estatística e Matemática Aplicada  - DEMA"),style="color:black")),
                                 # div(a(href="http://www.dema.ufc.br/", target="_blank",
                                 #       strong("Departamento de Estatística e Matemática Aplicada  - DEMA"),style="color:black"),
                                 #     img(src="brasaoUFC.jpg")),
                                 div("Universidade Federal do Ceará",style = "font-size: 10pt"),
                                 div("Campus do Pici",style = "font-size: 10pt"), 
                                 div("Bloco 910",style = "font-size: 10pt"),
                                 div("Fone: +55 85 3366-9848/9840",style = "font-size: 10pt")
                                 # div(a(href="http://www.dema.ufc.br/", target="_blank",
                                 #       strong("Laboratório de Estatística e Matemática Aplicada - LEMA"),style="color:black"))
                                 # HTML('<Center><img src="ufc.png" width="125" height="50"></Center>')
                                 #div(a(img(src='ufc.png', align = "center"))),
                             ),
                             Tutorial
                     ),
                     tabItem(tabName = "Dados",
                             fluidRow(
                               box( title = "Arquivo de dados", solidHeader = TRUE, status = "danger", width = 4,
                                    Inform,
                                    Header,
                                    Linha,
                                    Separador,
                                    Decimal,
                                    CarregarDados,
                                    uiOutput("nomes_das_colunas")
                               ),
                               mainPanel(dataTableOutput("Dados"))
                             )
                     ),
                     tabItem(tabName = "Tabela",
                             #                 sidebarLayout(
                             #                   box( title = "Variável", solidHeader = TRUE, status = "danger",
                             #                        uiOutput("vartabela"),
                             #                        DownloadTabela,
                             #                        DownloadAll,
                             #                        format_arquivo_all
                             #                   ),
                             #                   mainPanel(dataTableOutput("Tabela"))
                             #                   
                             #                 )
                             fluidRow(
                               
                               box( title = "Variável", solidHeader = TRUE, status = "danger",
                                    uiOutput("vartabela"),
                                    DownloadTabela,
                                    format_arquivo_Tabela
                               ),
                               box(title = "Variável", solidHeader = TRUE, status = "danger",
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
                                      box(title = "Escolha do Gráfico", solidHeader = TRUE, status = "danger",
                                          width = NULL,
                                          TipoGrafico,
                                          uiOutput("vargrafico")
                                      ),
                                      box(title = "Formatação", solidHeader = TRUE, status = "danger",
                                          width = NULL,
                                          cor_barras,
                                          inserirTitulo,
                                          inserirEixo,
                                          size_titulo,
                                          size_titulo_eixo,
                                          size_eixos,
                                          size_rotulo,
                                          distancia_rotulo
                                      )
                               ),
                               column(8, 
                                      box(width = NULL, status = "danger" ,plotlyOutput("grafico", height = "550px"))
                               )
                             )
                             
                     ),
                     tabItem(tabName = "Grafico2",
                             fluidRow(
                               column(width=4,
                                      box(title = "Escolha do Gráfico", solidHeader = TRUE, status = "danger",
                                          width = NULL,
                                          uiOutput("TipoGrafico2"),
                                          uiOutput("vargrafico2_1"),
                                          uiOutput("mults"),
                                          uiOutput("vargrafico2_2"),
                                          uiOutput("mults2")
                                      ),
                                      box(title = "Formatação", solidHeader = TRUE, status = "danger",
                                          width = NULL,
                                          inserirTitulo2,
                                          inserirEixo2,
                                          inserirlegenda,
                                          size_titulo2,
                                          size_titulo_eixo2,
                                          size_eixos2
                                      )
                               ),
                               column(8, 
                                      box(width = NULL, status = "danger" ,plotlyOutput("grafico2"))
                               )
                             )
                             
                     )
                     
                   )
                 )
                 
  )
)

#------------------------------------------------------------------------------#
# Final do layout