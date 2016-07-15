
#------------------------------------------------------------------------------#
# função que retorna os dados e um auxiliar
dados <- function(input){
      req(input$arquivoescolhido)
  
      inFile <- input$arquivoescolhido
      
      ifelse(input$linha, 
        dados <- read.csv(inFile$datapath, header = FALSE, sep = input$sep,
                          dec = input$dec, row.names = 1, encoding = "UTF-8" ),
        dados <- read.csv(inFile$datapath, header = FALSE,sep = input$sep,
                          dec = input$dec, encoding = "UTF-8" )
      )
      
      if(input$header == TRUE){
        # nome das colunas
        for(i in 1: ncol(dados)){
          colnames(dados)[i] <- as.character(dados[1,i])
        }
        dados <- dados[-1,]
      }

  return(list(dados = dados))
}
#------------------------------------------------------------------------------#

#------------------------------------------------------------------------------#
# Função que retorna 1 para sim e 0 para não possui função lapply é
# para aplicar na lista função str_count é contar quantas vezes certa
# 'string' aparece em um vetor função str_replace_all é para
# subistituir(remover) os parenteses que por algum motivo causavam erro
# na função str_count
sim_ou_nao <- function(separacao, nome) {
  unlist(lapply(separacao, function(x) {
    sum(str_count(str_replace_all(x, "[(,)]", ""), paste0("^",str_replace_all(nome, "[(,)]", ""),"$") ))
  }))
}
#------------------------------------------------------------------------------#

#------------------------------------------------------------------------------#
# Função que retorna a matriz binária para a Variável j isoladamente

Gerar_matriz_binaria <- function(x) {
  separacao <- strsplit(as.character(x), ",")     #separa as respostas de cada um pela vírgula, gera uma lista p/ cada respondente
  separacao <- lapply(separacao, function(x) {    # Faz uma correção em uma questão específica que continha um item com ","
    x[which(x == "Treinamentos de usuários (normalização" | 
              x == " Treinamentos de usuários (normalização")] <- c("Treinamentos de usuários (normalização, bases de dados etc.)")
    x[which(x == "bases de dados etc.)" | x == " bases de dados etc.)")] <- NA
    x <- na.exclude(x)
  })
  separacao <- lapply(separacao, function(x) str_trim(x, side = "left"))    # tira todos os espaços do início do vetor
  separacao <- lapply(separacao, function(x){if( all(nchar(gsub(" ","",x)) == 0) ) x<-NA else x<-x})   # transforma em NA os campos vazios
  
  
  nlevel <- length(levels(as.factor(unlist(separacao))))    # número de itens
  nameslevels <- levels(as.factor(unlist(separacao)))       # nomes dos itens
  
  # verificar se é uma questão multitem, 1 se sim e 0 se não
  if( sum(unlist(lapply(separacao, length))) > length(x) ) multitem <- 1 else multitem <- 0
  
  if(multitem == 0){  # caso não seja multitem ele retorna os próprios dados
    matriz <- as.data.frame(unlist(separacao))
#    colnames(matriz) <- dimnames(dados)[[2]][j]
  }else{    # caso seja multitem ele retorna a matriz de 0 e 1
    matriz <- sim_ou_nao(separacao, nameslevels[1])
    for (i in 2:nlevel) {
      matriz <- cbind(matriz, sim_ou_nao(separacao, nameslevels[i]))
    }
    #    colnames(matriz) <- paste0("V", j, ": ", nameslevels)
    colnames(matriz) <- paste0(nameslevels)
  }
  
  # retorna a matriz com os dados e as variáveis que são multitem
  return(list( Matriz = matriz, Multitem = multitem, levels = nameslevels))
}

#------------------------------------------------------------------------------#


#------------------------------------------------------------------------------#
# criando uma matriz Geral para todas as variaveis

# Gerar_Matriz_Ajustada <- function(dados, salvar = FALSE) {
#   
#   
#   # criando uma matriz Geral para todas as vari?veis
#   
#   j <- 1
#   #  multitem <- Gerar_matriz_binaria(dados[, 1], j)$Multitem
#   #  nlevel <- Gerar_matriz_binaria(dados[, 1], j)$N
#   matriz <- Gerar_matriz_binaria(dados[, 1], j, dados)$Matriz    # primeiro ? feita a primeira coluna
#   lista <- list(matriz)                                   # lista para conter a matriz das questões separadas
#   for (i in 2:ncol(dados)) {                # depois as demais colunas, pois uso o cbind para criar a matriz final
#     #    multitem <- c(multitem, Gerar_matriz_binaria(dados[, i], j)$Multitem)
#     #    nlevel <- c(nlevel, Gerar_matriz_binaria(dados[, i], j)$N)
#     j <- j + 1
#     matrizi <- Gerar_matriz_binaria(dados[, i], j, dados)$Matriz
#     lista <- c(lista, list(matrizi))
#     matriz <- cbind(matriz, matrizi)
#     
#   }
#   
#   names(lista) <- colnames(dados)       # nomeando os elementos da lista
#   
#   # ncolunas_var <- nlevel
#   # if(all(multitem == 0)) ncolunas_var <- rep(1, length(nlevel)) else ncolunas_var[which(multitem == 0)] <- 1
#   
#   # preparando a sa?da em xls
#   Resultado <- cbind(matriz, rep("", nrow(dados)), c(paste0("V", 1:ncol(dados)), rep("", (nrow(dados) - ncol(dados)))), 
#                      c(colnames(dados), rep("",(nrow(dados) - ncol(dados)))))
#   # salvando em xls
#   if(salvar == TRUE){
#     write.table(Resultado, file = "./Matrix_Ajustada.csv", sep = ";",row.names = FALSE, col.names = TRUE)
#   }
#   
#   # frequ?ncia e percentual
#   freq_aux <- function(x){
#     if(is.numeric(x)){
#       soma <- as.numeric( colSums(x, na.rm = TRUE) )
#       somaperc <- as.numeric( colSums( x, na.rm = TRUE) / nrow(dados)*100 )
#       somapercvalid <- as.numeric( colSums( x, na.rm = TRUE) / nrow(na.exclude(x))*100 )
#       aux <- data.frame(c(colnames(x),"TOTAL"), c(soma, sum(soma)) ,
#                         c(somaperc, round(sum(colSums( x, na.rm = TRUE) / nrow(dados)*100),1) ),
#                         c( somapercvalid, round(sum(colSums( x, na.rm = TRUE) / nrow(na.exclude(x))*100),1) ) )
#       colnames(aux) <- c("Opções","Frequência","%","% Válido")
#       #rownames(aux) <- NULL
#     }else{
#       soma <- as.numeric(table(x))
#       somaperc <- as.numeric( table(x) / nrow( dados )*100)
#       somapercvalid <- as.numeric( table(x) / nrow( na.exclude(x) )*100)
#       aux <- data.frame(c( names(table(x) ),"TOTAL"), c( soma, sum( soma ) ) , 
#                         c( somaperc, round( sum(somaperc),1) ), c( somapercvalid, round( sum(somapercvalid),1) ) )
#       colnames(aux) <- c("Opções","Frequência","%","% Válido")
#       #rownames(aux) <- NULL
#     }
#     #aux <- rbind(aux,c("TOTAL",sum(aux[,2]),sum(aux[,3])))
#     return(aux)
#   }
#   frequencia <- lapply(lista, freq_aux)
#   frequencia2 <- lapply(seq(frequencia),
#                         function(i) {
#                           y <- data.frame(frequencia[[i]])
#                           names(y) <- c(names(frequencia)[i], "Frequência","%")
#                           return(y)
#                         }
#   )
#   names(frequencia2) <- names(frequencia)
#   
#   
#   list(Matriz = matriz,  Lista = lista)
# }

#------------------------------------------------------------------------------#

#------------------------------------------------------------------------------#
# criando uma matriz Geral para todas as variaveis

Gerar_freq <- function(dados) {
  # Função que retorna uma lista com todas as observações já separadas,
  # individualmente para cada coluna do banco de dados a qual essa é
  # aplicada
  f <- function(x) {
    separacao <- unlist(strsplit(as.character(x), ","))  # separa os itens separado por ,
    retirar_espaco <- str_trim(separacao, side = "left")  # retira os espaços da frente
    # transforma em NA os campos vazios
    retirar_espaco <- ifelse( nchar(gsub(" ","",retirar_espaco))==0, NA,retirar_espaco)
    
    # corrigindo a opçao que tem virgula no meio da palavra
    retirar_espaco[which(retirar_espaco == "Treinamentos de usuários (normalização" | 
      retirar_espaco == " Treinamentos de usuários (normalização")] <- 
      c("Treinamentos de usuários (normalização, bases de dados etc.)")
    retirar_espaco[which(retirar_espaco == "bases de dados etc.)" | 
                           retirar_espaco == " bases de dados etc.)")] <- NA
    retirar_espaco <- na.exclude(retirar_espaco)
    return(retirar_espaco)
    
  }
  resumo <- apply(dados, 2, f)
  
  # verificando a frequência de cada uma das colunas ('Questões')
  
  freq_aux <- function(x){
    frequencia_absoluta <- as.numeric(table(x))
    
    frequencia_relativa <- as.numeric( table(x) / nrow( dados )*100)
    somapercvalid <- as.numeric( table(x) / length( na.exclude(x) )*100)
    
    
    if(length(x) > nrow(dados) ){ # condição para verificar se é multresposta
                                  # e colocar o Total só nas que não são.
      freq1 <- data.frame(c( names( table(x) )), c( frequencia_absoluta),
                          c( round( frequencia_relativa,1) ),
                          c( round( somapercvalid,1) )  )
      
      colnames(freq1) <- c( "Opções", "Frequência", "%", "% Válido")
    }else{
      freq1 <- data.frame(c(names(table(x)),"Total"), c(frequencia_absoluta,sum(frequencia_absoluta) ),
                          c(round(frequencia_relativa,1), round(sum( frequencia_relativa ),1) ),
                          c(round(somapercvalid,1), round( sum(somapercvalid),1) )  )
      
      colnames(freq1) <- c("Opções", "Frequência", "%", "% Válido")
    }
      #rownames(freq1) <- NULL
    return(freq1)
  }
  
  if(aux == "uma variavel") frequencia <- lapply(list(resumo), freq_aux)
  else
  frequencia <- lapply(resumo, freq_aux)

}

#------------------------------------------------------------------------------#

#------------------------------------------------------------------------------#
# função para saber as questões multiitem
mults <- function(dados){
  f <- function(x){
    separacao <- strsplit(as.character(x), ",")     #separa as respostas de cada um pela vírgula, gera uma lista p/ cada respondente
    separacao <- lapply(separacao, function(x) {    # Faz uma correção em uma questão específica que continha um item com ","
      x[which(x == "Treinamentos de usuários (normalização" | 
                x == " Treinamentos de usuários (normalização")] <- c("Treinamentos de usuários (normalização, bases de dados etc.)")
      x[which(x == "bases de dados etc.)" | x == " bases de dados etc.)")] <- NA
      x <- na.exclude(x)
    })
    
    # verificar se é uma questão multitem, 1 se sim e 0 se não
    if( sum(unlist(lapply(separacao, length))) > length(x) ) multitem <- 1 else multitem <- 0
    return(multitem)
  }
  questmult <- apply(dados, 2, f)
  if( length( which( questmult == 1 ) ) == 0) return(0) 
  else
  return( which(questmult == 1) )
}

# função para saber os itens das questões multiresposta
itensmults <- function(x){
  separacao <- strsplit(as.character(x), ",")     #separa as respostas de cada um pela vírgula, gera uma lista p/ cada respondente
  separacao <- lapply(separacao, function(x) {    # Faz uma correção em uma questão específica que continha um item com ","
    x[which(x == "Treinamentos de usuários (normalização" | 
              x == " Treinamentos de usuários (normalização")] <- c("Treinamentos de usuários (normalização, bases de dados etc.)")
    x[which(x == "bases de dados etc.)" | x == " bases de dados etc.)")] <- NA
    x <- na.exclude(x)
  })
  separacao <- lapply(separacao, function(x) str_trim(x, side = "left"))    # tira todos os espaços do início do vetor
  
  return( names( table( unlist(separacao) ) ) )
}