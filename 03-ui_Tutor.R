Tutorial <-
box( title = "", status = "danger", width = 15,
       p("  Este aplicativo tem por finalidade ajudar 
       os servidores do sistema de bibliotecas da Universidade Federal do Ceará
        a visualizar, de forma iterativa,
       estatísticas descritivas, tabelas e gráficos. Além de poderem fazer o
         Download do relatório com essas informações."),
     p("Abaixo segue um tutorial para uso do aplicativo de forma correta,
       o qual facilitará a compreensão dos resultados, tabelas e gráficos."),
     p("Na Guia", span("Dados", style = "color:blue"), "você poderá escolher 
        o banco de dados que deseja usar Através do botão",
       strong("Selecionar arquivo..."), ", com a especificação que o banco de
       dados deve ser um arquivo em formato '.csv' e estar com
        a codificação de texto 'UTF-8', além de que as 'variáveis' estudadas
       devem ser as colunas do banco de dados"),
     p("Você poderá customizar algumas opções para abrir o banco de dados de 
       forma correta."),
     p("Marque a caixa", strong("Cabeçalho"),"caso você queira que a primeira linha
       do banco de dados seja considerado o nome das variáveis."),
     p("Marque a caixa", strong("Nome das linhas"),"caso você queira que a 
        primeira coluna
       do banco de dados seja considerado o nome das linhas do banco de dados"),
     p("Na seção de marcadores", strong("Separador dos registros"),
        "você poderá escolher o separador de células."),
     p("Na seção de marcadores", strong("Separador de decimal"),
        "você poderá escolher a string de décimos dos números."),
     p("Através da seção de marcadores", strong("Colunas a mostrar:"),
       "você poderá selecionar as variáveis que queira visualizar."),
     p("Agora você poderá visualizar o banco de dados, e usar as caixas de texto
        para fazer buscas específicas, e as abas para navegar no banco de dados"),
     p("Na Guia" , span("Tabela", style = "color:blue"),
      "você poderá visualizar estatísticas descritivas para as questões 
      desejadas. Lembrando que para as questões com multiplas respostas, ou seja,
      questões que podem ser marcadas ou selecionadas mais de uma opção, será
      feito automaticamente o tratamento adequado"),
     p("Na Guia ", span("Gráfico Univariado", style = "color:blue"),
       "você poderá criar e salvar seus gráficos univariados."),
     p("Na caixa de seleção", strong("Tipo de gráfico"), "você poderá escolher
      o tipo de gráfico desejado: Colunas, Barras ou Setores, e na caixa 
      de seleção" , strong("Selecione a variável!"), "escolha a questão
       desejada."),
     p("Nas caixas de texto", strong("Título"), "e", strong("Eixo x"), "você poderá
       colocar o título do gráfico e do Eixo x."),
     p("Na Guia ", span("Gráficos Bivariados", style = "color:blue"),
       "você poderá criar e salvar seus gráficos Bivariados, onde o maior diferencial
       seria que caso selecione uma questão com multiplas respostas, surgirá a opção
       de escolher qual item específico você deseja testar.")
)