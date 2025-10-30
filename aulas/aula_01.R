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

if(!require("NHANES")) {
  install.packages("NHANES")
}

data(NHANES)

# PEÇA AJUDA AO SISTEMA 
help("NHANES", package = "NHANES")
try(data(package = "NHANES"), silent = TRUE)

# ==============================================================================

if(!require("Epi")) {
  install.packages("Epi")
}

data(births)
data(melanoma)

try(data(package = "Epi"), silent = TRUE)

# ==============================================================================

if(!require("MASS")) {
  install.packages("MASS")
}

data(anorexia)

try(data(package = "MASS"), silent = TRUE)

# ==============================================================================

if(!require("foodcomex")) {
  install.packages("foodcomex")
}

library(foodcomex)

try(data(package = "foodcomex"), silent = TRUE)

data(food_composition)



