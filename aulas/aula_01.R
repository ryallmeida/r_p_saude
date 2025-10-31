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
# AULA 01: O ZERO DO ZERO
# ==============================================================================

# TÓPICO: R COMO UMA CALCULADORA

2+2

2*2

2/2

2-2

2^2

# USE PARENTESE PARA SEPARAR PARTES DO CALCULO 

((4+14)/4)^2

# COMO ACESSAR A AJUDA NO R?

help.search("logaritmo")
help.search("logarithms")

# OU

??logatithms

# QUAIS SÃO AS FUNÇÕES MAIS BÁSICAS DO R COMO CALCULADORA? 

sqrt(9)
sqrt(3*3^2) #27
sqrt((3*3)^2) #81

prod(2,2)
prod(2,4,5,6,7)

log(3)
log(3, 10)
log10(3)

# abs pega valores em modulo 
abs(3-9)

# para fatoriais
factorial(4)

# COMO CRIAR FUNÇÕES NO R? 


if(!require("MASS")) {
  install.packages("MASS")
}

try(data(package = "MASS"), silent = TRUE)
data(UScereal)



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


