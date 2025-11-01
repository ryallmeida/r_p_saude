# UNIVERSIDADE FEDERAL DE PERNAMBUCO 
# PROGRAMA DE PÓS-GRADUAÇÃO EM NUTRIÇÃO & DEPARTAMENTO DE CIÊNCIA POLÍTICA
# CURSO: R PARA SAÚDE, 3 A 7 DE NOVEMBRO DE 2025

# ==============================================================================
# CODADO ORIGINALMENTE EM R, V. 4.5.1 EM 30 DE OUTUBRO DE 2025
# ==============================================================================

# DOCENTES: MARIA DO CARMO SOARES DE LIMA (PPGE/UFPE) E DALSON BRITTO (DCP/UFPE)
# MONITORES: RYAN ALMEIDA (DCP/UFPE) E CARLA CAVALCANTE (DCP/UFPE)

# ==============================================================================
# AULA BONUS: ESTATÍSTICA DESCRITIVA
# ==============================================================================
# INSTALANDO OS PACOTES

if(!require("pacman")) {
  install.packages("pacman")
}

pacman::p_load(tidyverse, readxl, psych)
# ==============================================================================
# LENDO OS DADOS
# ==============================================================================

df <- read.csv("https://raw.githubusercontent.com/ryallmeida/r_p_saude/refs/heads/main/database/dados_obesidade.csv")

# ==============================================================================
# FREQUÊNCIA RELATIVA (PORCENTAGEM/NORMALIZADO) OU ABSOLUTA (NUMERO INTEIRO) 
# PARA VARIAVEIS NUMERICAS
# ==============================================================================

# PARA VARIÁVEIS CATEGORICAS
prop.table(table(df$Gender))

prop.table(table(df$NObeyesdad))
# FAZEMOS COM AS OUTROS VARIÁVEIS ...

# MAS ESSE BANCO DE DADOS TAMBÉM CONTEM VARIAVEIS DISCRETAS
# PRIMEIRO PASSO, ANALISAR A AMPLITUDE DA VARIÁVEL QUE ESTAMOS TRABALHANDO
# EXEMLO PESO E ALTURA

mean(df$Height) 
range(df$Height, na.rm = TRUE)
altos <- which(df$Height <= 1.90)
length(df[altos,])

mean(df$Weight) 
range(df$Weight, na.rm = TRUE)
acima_pesos <- which(df$Weight >= 86.58606)
length(df[acima_pesos,])

# MEDIANA ----------------------------------------------------------------------
median(df$Height)

median(df$Weight)
# AJUSTANDO INFOMRAÇÕES PELA MEDIANAN
acima_pesos2 <- which(df$Weight >= 83)
length(df[acima_pesos2,])

# NÃO MUDA MUIDA COISA NESSE DATASET

# PACOTE NATIVO DO R QUE GERENCIA DISPOSITIVOS GRAFICOS, CONTROLA CORES E FORMATOS , BASE TÉCNICA PARA QUALQUER PACOTE QUE DESENHA GRAFICOS

grDevices::nclass.Sturges(df$Height)
grDevices::nclass.Sturges(df$Weight)

# NOVE 9 CATEGORIAS
# Calcula o número ideal de classes (intervalos) para construir um histograma, segundo a regra de Sturges.
# Essa regra é uma fórmula empírica usada para determinar quantos intervalos devem existir, com base no tamanho da amostra n:

# k=1+log2(n)

hist(df$Height, breaks = "Sturges")
hist(df$Weight, breaks = "Sturges")


table(cut(df$Height, seq(1.45, 1.98, l = 13)))
table(cut(df$Weight, seq(39, 173, l = 13)))

# ==============================================================================
# ANÁLISES INICIAIS E DESCRITIVAS
# ==============================================================================

# MEDIDAS DE TENDÊNCIA CENTRAL E MEDIDAS SEPARATRIZES -------------------------------------------------

summary(df$IMC)

# NOTA DE AULA -----------------------------------------------------------------
# INTERPOLAÇÃO: TÉCNICA MATEMÁTICA  USADA PARA ESTIMAR VALORES QUE ESTÃO "ENTRE" PONTOS CONHECIDOS, MAIS USADO, POIS É MAIS CONFIÁVEIS E VOCE NÃO INVENTA VALORES

# EXTRAPOLÇÃO: ESTIMA VALORES FORA DO INTERVALO (ARRISCADO, POIS DISTORCE TENDÊNCIAS)
# ------------------------------------------------------------------------------

mean(df[-x]) # REMOVER PONTOS DE ALAVANCAGEM E OUTLIERS

# QUARTIS ----------------------------------------------------------------------
# "AH, MAS ... PROF, COMO A AMPLITUDE INTERQUARTILICA PODE SER ÚTIL NA MINHA PESQUISA?"

# PODERIA USAR A FUNÇÃO order() PARA TIRAR OS QUARTIS


quantile(df$Weight, type = 4, na.rm = TRUE)

# O PRIMEIRO QUARTIL É O PONTO QUE SEPARA OS 25% MENORES VALORES DA SUA AMOSTRA DE DADOS

# O TERCEITO QUARTIL SEPARA OS 75% MENORES VALORES DA AMOSTRA, DESPREZA OS 25% DE DADOS MAIORES ACIMA DELE DE LADO

# ASSIM O INTERVALO INTERQUARTILICO ABRANGE OS 50% CENTRAIS DOS DADOS, DESCARTANDO OS 25% MAIS BAIXO E 25% MAIS ALTOS 

# EXEMPLO: IMAGINE A TAXA DE DESEMPREGO EM PERNAMBUCO
# Q1 = 7%
# Q3 = 13%
# ENTÃO, AIQ = 6%

# ISSO SIGNIFICA DIZER QUE METADE DOS MUNICIPIOS TEM TAXA DE DESEMPREGO ENTRE 7 E 13%
# SERVE COMO UM MEDIDOR DE DISPERSÃO COMPLEMENTAR A À MEDIA E MEDIANA, MAIS "ROBUSTO" DIANTE DE DISTRIBUIÇÕES ASSIMÉTRICAS 

# PERCENTIS --------------------------------------------------------------------

quantile(df$Weight, probs = 0.001, type = 4, na.rm = T)

# ==============================================================================
# PARA MEDIDAS DE TENDENCIA CENTRAL
# ==============================================================================
# PODE-SE USAR O PACOTE psych()
# REFERENCIA DE PACOTE BOM 

psych::describe(dados$Ano_2018)

# ==============================================================================
# VARIÂNCIA E DESVIO PADRÃO
# ==============================================================================

var(df$Height)
sd(df$Height)

# HIPOTESE: O QUANTO QUE OS DADOS ESTÃO FLUTUANDO EM RELAÇÃO À MÉDIA?
# OS OUTPUTS DO CALCULO DA VARIÃNCIA PODEM SER CHAMADOS DE RESIDUOS OU DE DESVIOS
# A SOMA DOS RESIDUOS NESSE CASO TEM QUE OBRIGATORIAMENTE DAR ZERO, VISTO ISSO A SOLUÇÃO ESTÁ NA ALGEBRA VIA A SOMA DOS QUADRADOS (DA SOMA E/POU DIFERENÇA)

# A SOMA DOS QUADRADO DOS RESIDUOS SERÁ UM NÚMERO POSITIVO USADO PARA, NÃO PODEMOS OLHAR PARA ESSE NUMERO BRUTO, PORQUE ASSIM ELE NÃO SIGNIFICA NADA 

# O TAMANHO DA SOMA DEPENDE É ALTAMENTE DO TAMANHO DA AMOSTRA 

# VARIANCIA AMOSTRAL É DIFERENTE DA VARIANCIA POPULACIONAL 

# O COEFICIENTE DE VARIAÇÃO SERVE PARA CALCULAR QUALQUER COISA EM QUALQUER UNIDADE DE MEDIDA, PORTAMDO, TORNA-SE UMA VARIAVEL ADMENSIONAL 

# ==============================================================================
# TRAMENTO DE ALGUMAS VARIAVEIS
# ==============================================================================
# TRATAMENTO PARA VARIAVEIS CATEGORIS ORDENÁVEIS (RECODIFICAÇÃO DE VARIAVEIS QUALITATIVAS)

unique(df$NObeyesdad)

df$NObeyesdad <- factor(df$NObeyesdad, 
                        levels = c("Insufficient_Weight",
                                   "Normal_Weight", 
                                   "Overweight_Level_I",
                                   "Overweight_Level_II",
                                   "Obesity_Type_I",
                                   "Obesity_Type_II",
                                   "Obesity_Type_III"),
                        ordered = TRUE)

barplot(table(df$NObeyesdad))

prop.table(table(df$NObeyesdad))

# QUANTIFICANDO QUALITATIVAMENTE UMA ESCALA USANDO ESTRUTURAS CONDICIONAIS

df$Weight_Status <- ifelse(df$NObeyesdad == "Insufficient_Weight", 1,
                           ifelse(df$NObeyesdad == "Normal_Weight", 2,
                                  ifelse(df$NObeyesdad == "Overweight_Level_I",3,
                                         ifelse(df$NObeyesdad == "Overweight_Level_II",4, ifelse(df$NObeyesdad == "Obesity_Type_I", 5, 
                                                                                                 ifelse(df$NObeyesdad == "Obesity_Type_I", 5, 
                                                                                                        ifelse(df$NObeyesdad == "Obesity_Type_II", 6, 
                                                                                                               ifelse(df$NObeyesdad == "Obesity_Type_III", 7, NA))))))))

# AS VEZES ESTRUTURAS CONDIIONAIS PODEM SER UM POUCO CANSATIVAS
# MAS NO R, A PERGUNTA NÃO É "SERA QUE DÁ PRA FAZER?" MAS SIM... "COMO FAZER?"

df$Weight_Status2 <- as.numeric(factor(df$NObeyesdad, 
                                       levels = c("Insufficient_Weight",
                                                  "Normal_Weight", 
                                                  "Overweight_Level_I",
                                                  "Overweight_Level_II",
                                                  "Obesity_Type_I",
                                                  "Obesity_Type_II",
                                                  "Obesity_Type_III"),
                                       ordered = TRUE))

