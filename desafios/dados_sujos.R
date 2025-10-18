# UNIVERSIDADE FEDERAL DE PERNAMBUCO
# PROGRAMA DE PÓS-GRADUAÇÃO EM NUTRIÇÃO
# DEPARTAMENTO DE CIÊNCIA POLÍTICA
# CURSO: R PARA SAÚDE
# -------------------------------------

# DOCENTE PROF.ª DR.ª MARIA DO CARMO E DALSON BRITTO (DCP/UFPE)
# MONITORES RYAN ALMEIDA E CARLA CAVALCANTE (DCP/UFPE)

# -------------------------------------
# CODADO ORIGINALMENTE EM R, V. 4.4.1 EM 11 DE OUTUBRO DE 2025

# DESAFIO 1: LIMPANDO OS RUÍDOS DOS DADOS


if(!require("pacman")) {
  install.packages("pacman")
}

pacman::p_load(tidyverse, stringr)

# ==============================================================================
# CRIANDO UMA BASE DADE COM DISTRIBUIÇÃO NORMAL 

set.seed(123) 
n <- 2000

# Gera alturas "reais" em metros
alturas_m <- rnorm(n, mean = 1.70, sd = 0.12) 

# Converte parte em cm, mistura formatos
alturas_sujas <- sapply(alturas_m, function(x) {
  formato <- sample(1:6, 1)
  valor_cm <- x * 100
  
  switch(as.character(formato),
         # 1 - valor em metros com ponto decimal
         "1" = sprintf("%.2f", x),
         # 2 - valor em metros com vírgula
         "2" = gsub("\\.", ",", sprintf("%.2f", x)),
         # 3 - valor em cm sem unidade
         "3" = sprintf("%.0f", valor_cm),
         # 4 - valor em cm com unidade
         "4" = paste0(sprintf("%.0f", valor_cm), "cm"),
         # 5 - valor em metros com unidade
         "5" = paste0(sprintf("%.2f", x), "m"),
         # 6 - valor com ruído (letra ou símbolo)
         "6" = paste0(sample(c("a","b","@","?"),1), sprintf("%.2f", x))
  )
})


# Cria data frame
dados_altura <- data.frame(id = 1:n, altura = alturas_sujas)
head(dados_altura, 10)

# write.csv(dados_altura, file = "C:/Users/Notebook/Desktop/R PARA SAUDE/r_p_saude/desafios/dados_sujos.csv")

dados <- dados_altura %>%
  mutate(
    # Remove letras e símbolos
    altura_limpa = str_replace_all(altura, "[^0-9,\\.]", ""),
    
    # Substitui vírgula por ponto
    altura_limpa = str_replace_all(altura_limpa, ",", "."),
    
    # Converte para número
    altura_num = as.numeric(altura_limpa),
    
    # Se o valor for maior que 10, provavelmente está em cm
    altura_metros = ifelse(altura_num > 10, altura_num / 100, altura_num)
  )

