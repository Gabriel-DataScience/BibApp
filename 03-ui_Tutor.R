Tutorial <-
box( title = strong("Tutorial"), status = "danger", width = 15,
     includeMarkdown("lista_tutorial.md")
     
     # div("Shiny app: ", a(target="_blank", "Gabriel Fernandes e Ronald Targino"), align="center", 
     #     style = "font-size: 8pt"),
     # 
     # div("Base R code: ", a(target="_blank", "Gabriel Fernandes e Ronald Targino"), align="center", 
     #     style = "font-size: 8pt")
     
    # p("  Este aplicativo tem por finalidade ajudar 
    # os servidores do sistema de bibliotecas da Universidade Federal do Ceará
    #  a visualizar, de forma iterativa,
    # estatísticas descritivas, tabelas e gráficos. Além de poderem fazer o
    #   Download do relatório com essas informações."),
    # p("Abaixo segue um tutorial para uso do aplicativo de forma correta,
    #   o qual facilitará a compreensão dos resultados, tabelas e gráficos."),
    # p("Na Guia", strong("Dados", style = "color:blue"), ", especifique as 
    #   características do arquivo de dados e selecione-o através do botão",
    #   strong("Escolher arquivo"), ". O arquivo deve estar no formato '.csv' e 
    #   com a codificação de texto 'UTF-8'."),
    # p("Para abrir o arquivo de dados de forma correta: ",     style="list-style-type:disc"),
    # p("Para abrir o arquivo de dados de forma correta: "),
    # p("  - Marque a caixa", strong("Cabeçalho"),"caso a primeira linha
    #   do arquivo contenha o nome das variáveis."),
    # p("  - Marque a caixa", strong("Nome das linhas"),"caso a primeira coluna
    #   do arquivo contenha os nomes das linhas."),
    # p("  - Identifique no ", strong("Separador dos registros"),
    # "o caracter usado para separar os registros de cada linha."),
    # p("  -  Identifique no", strong("Separador de decimal"),
    # "o caracter usado como separados de decimais nos números."),
    # p("Após a seleção do arquivo:"),
    # includeMarkdown("lista1_tutorial.md")   
     # p("Selecione em ", strong("Colunas a mostrar:"),
     #   "as variáveis a serem apresentadas na tela."),
     # p("Agora você poderá visualizar o banco de dados, usar as caixas de texto
     #    para fazer buscas específicas e as abas para navegar no banco de dados."),
     # p("Na Guia" , span("Tabela", style = "color:blue"),
     #  "você poderá visualizar estatísticas descritivas para as questões 
     #  desejadas. Lembrando que para as questões com multiplas respostas, ou seja,
     #  questões que podem ser marcadas ou selecionadas mais de uma opção, será
     #  feito automaticamente o tratamento adequado"),
     # p("Na Guia ", span("Gráfico Univariado", style = "color:blue"),
     #   "você poderá criar e salvar seus gráficos univariados."),
     # p("Na caixa de seleção", strong("Tipo de gráfico"), "você poderá escolher
     #  o tipo de gráfico desejado: Colunas, Barras ou Setores, e na caixa 
     #  de seleção" , strong("Selecione a variável!"), "escolha a questão
     #   desejada."),
     # p("Nas caixas de texto", strong("Título"), "e", strong("Eixo x"), "você poderá
     #   colocar o título do gráfico e do Eixo x."),
     # p("Na Guia ", span("Gráficos Bivariados", style = "color:blue"),
     #   "você poderá criar e salvar seus gráficos Bivariados, onde o maior diferencial
     #   seria que caso selecione uma questão com multiplas respostas, surgirá a opção
     #   de escolher qual item específico você deseja testar.")
    
    
    # Na Guia <span style="color:blue"> **Gráfico Univariado** </span>, especifique o 
    # tipo de gráfico e a variável desejada, o título do gráfico e as denominações dos 
    # eixos.
    # 
    # Na Guia <span style="color:blue"> **Gráfico Bivariado** </span>, especifique o 
    # tipo de gráfico e as variáveis desejadas, o título do gráfico e as denominações 
    # dos eixos. Ao especificar uma variável (questão) com múltiplas respostas, a caixa de seleção 
    # **Selecione o item** surgirá, permitindo selecionar um item específico (resposta).  
    # 
    
    
)