# UNIVERSIDADE FEDERAL DE PERNAMBUCO 
# PROGRAMA DE PÓS-GRADUAÇÃO EM NUTRIÇÃO & DEPARTAMENTO DE CIÊNCIA POLÍTICA
# CURSO: R PARA SAÚDE, 3 A 7 DE NOVEMBRO DE 2025

# ==============================================================================
# CODADO ORIGINALMENTE EM R, V. 4.5.1 EM 30 DE OUTUBRO DE 2025
# ==============================================================================

# DOCENTES: MARIA DO CARMO SOARES DE LIMA (PPGE/UFPE) E DALSON BRITTO (DCP/UFPE)
# MONITORES: RYAN ALMEIDA (DCP/UFPE) E CARLA CAVALCANTE (DCP/UFPE)

# ==============================================================================
# INSTALANDO OS PACOTES 

if(!require("pacman")) {
  install.packages("pacman")
}

pacman::p_load(tidyverse)

# ==============================================================================
# AULA 03: MANIPULAÇÃO DE DADOS
# ==============================================================================

aa<-c(1,3,5,7,9)
bb<-c(5,6,3,8,9)
cc<-c("a","a","b","a","b")

cbind(aa,bb) # junta os vetores em colunas
rbind(aa,bb) # junta os vetores em linhas

cbind(aa,bb,cc) # junta os vetores em colunas, mas transforma números emcaracteres.Para criar uma dataframe com valores numéricos e de caracteres use a função data.frame:


data.frame(aa,bb,cc) # agora temos números e letras.

# ==============================================================================
# OPERAÇÕES COM MATRIZES
# ==============================================================================

if(!require("MASS")) {
  install.packages("MASS")
}

try(data(package = "MASS"), silent = TRUE)
data(UScereal)

# View(UScereal)

mean(UScereal$calories)

UScereal[,1] # extrai a primeira coluna e todas as linhas
UScereal[,2] # extrai a segunda coluna e todas as linhas
UScereal[1,] # extrai a primeira linha e todas as colunas
UScereal[3,3] # extrai a terceira linha e a terceira coluna, 1 valor
UScereal[1,3] # extrai o valor da primeira linha e terceira coluna
UScereal[c(1:5),c(2,3)] # extrais somente as linhas 1 a 5 e as colunas 2 e 3

# ORDENANDO DADOS EM UM DATA FRAME ---------------------------------------------

C <- UScereal[order(UScereal$calories),]
View(C)

# media de colunas

m <- mean(UScereal$calorie)
print(m)

cs <- colSums(UScereal[, 5:8])
print(cs)

rs <- rowSums(UScereal[2:5,2:6])

cm <- colMeans(UScereal[2:5,2:6])

rm <- rowMeans(UScereal[2:5,2:6])

# ==============================================================================
# AGORA UMA INTRODUÇÃO AO MAIOR E MELHOR PACOTE DE MANIPULAÇÃO DE DADOS
# ==============================================================================

if(!require("dplyr")) {
  install.packages("dplyr")
}

# OUUUUUUU

if(!require("tidyverse")) {
  install.packages("tidyverse")
}







if(!require("NHANES")) {
  install.packages("NHANES")
}

# PARA MAIS DATALHES SOBRE O BANCO DE DADOS. ACESSE:
# https://www.cdc.gov/nchs/nhanes/about/

data(NHANES)

# PEÇA AJUDA AO SISTEMA ATRAVES DESSES CÓDIGOS
help("NHANES", package = "NHANES")
try(data(package = "NHANES"), silent = TRUE)

# ==============================================================================

if(!require("Epi")) {
  install.packages("Epi")
}

try(data(package = "Epi"), silent = TRUE)

data(DMepi)
data(diet)

# ==============================================================================

if(!require("MASS")) {
  install.packages("MASS")
}

try(data(package = "MASS"), silent = TRUE)

data(anorexia)