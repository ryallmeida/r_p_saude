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

# select() - seleciona colunas
# arrange() - ordena a base
# filter() - filtra linhas
# mutate() - cria/modifica colunas
# group_by() - agrupa a base
# summarise() - sumariza a base

coluna_gender <- dplyr::select(df, Gender)
coluna <- dplyr::select(df, Gender:Weight)
coluna <- dplyr::select(df, Gender, Age, Height)

# o dplyr possui um conjunto de funções auxiliares muito úteis para seleção de colunas. As principais são:
  
# starts_with(): para colunas que começam com um texto padrão
# ends_with(): para colunas que terminam com um texto padrão
# contains(): para colunas que contêm um texto padrão

select(df, starts_with("texto")) #textos em comum
select(df, -starts_with("texto"))

# ordenando base de dados via alguma coluna/variável

data("UScereal")
UScereal$mfr <- dplyr::arrange(UScereal, desc(mfr))
UScereal <- dplyr::arrange(UScereal, desc(mfr), desc(calories))


a <- UScereal %>% 
  select(mft, calories) %>% 
  arrange(mfr)
View(a)

# Para filtrar valores de uma coluna da base, utilizamos a função filter().


# perguntar aos discentes parametros interessantes para realizar a filtragem
# exemplo sodio altissimo, qual os parametros?
b <- UScereal %>% filter(variavel > parametro)

c <- UScereal %>% 
  filter(variavel > parametro em comum) %>% 
  select(variavel, variavel2)

d <- df %>% filter(Gender == "Female", NObeyesdad == "Insufficient_Weight")
# Podemos estender o filtro para duas ou mais colunas. Para isso, separamos cada operação por uma vírgula.

# Também podemos fazer operações com as colunas da base dentro da função filter. O código abaixo devolve uma tabela apenas com os filmes que lucraram.

e <- sqrt(df$Weight)
mean(e)
median(e)

f <- df %>% filter(sqrt(Weight) > 9.196058)
View(data.frame(f))

g <- df %>% filter(MTRANS %in% c("Walking", "Bike"))
View(data.frame(g))

# ==============================================================================
# MODIFICANDO OU CRIANDO NOVAS COLUNAS
# ==============================================================================

# PERCENTUAL DE CALORIAS VINDA DE AÇUCARES

UScereal <- UScereal %>% mutate(cal_sugg = ((sugars*4)/calories)*100)

# INTERPRETAÇÃO
# < 20% CARBOIDRATOS PREDOMINAM A DIETA
# 20% - 40% MODERADO
# > 40% ALTA PROPORÇÃO DE AÇUCARES SIMPLES

range(UScereal$cal_sugg)
summary(UScereal$cal_sugg)
hist(UScereal$cal_sugg)

h <- df %>% 
  filter(!is.na(SMOKE), !is.na(Weight))  %>% 
  group_by(SMOKE) %>% 
  summarise(peso_medio_fumante = mean(Weight, na.rm = TRUE))

i <- df %>% 
  group_by(MTRANS) %>% 
  summarise(peso_medio = mean(Weight, na.rm = TRUE))
View(i)


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

help("DMepi", package = "Epi")
data(DMepi)

help("diet", package = "Epi")
data(diet)

# ==============================================================================

if(!require("MASS")) {
  install.packages("MASS")
}

try(data(package = "MASS"), silent = TRUE)

help("anorexia", package = "MASS")
data(anorexia)