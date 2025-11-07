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

pacman::p_load(tidyverse, 
               rio,
               car, 
               rstatix)

# ==============================================================================
# AULA 05: TESTES DE HIPÓTESES MAIS COMUNS
# ==============================================================================

# IMPORTANDO BANCOS DE DADOS
# SCORES DE SAUDE
bd <- rio::import("https://raw.githubusercontent.com/ryallmeida/r_p_saude/refs/heads/main/database/synthetic_health_data.csv")

# DADOS SOBRE OBESIDADE
df <- rio::import("https://raw.githubusercontent.com/ryallmeida/r_p_saude/refs/heads/main/database/dados_obesidade.csv")
# -----------------------------------
# TESTES ESTATÍSTICOS NO R

# TESTES PARAMETRICOS ANALISAM VARIAVEIS DEPENDENTES COM DISTRIBUIÇÃO CONHECIDA
# TESTES NÃO-PARAMETRICOS, ONDE O INVERSO DA QUESTÃO ANTERIOR É VERDADEIRO

# PRESSUPOSTOS DE TESTES PARAMETRICOS:
# 1. DADOS EM INTERVALO, LOGO A VD DEVE VARIAR 
# 2. NORMALIDADE SE APROXIMA DA GAUSSIANA
# 3. HOMOGENEIDADE DA VARIÂNCIA
# 4. INDEPENDEÊNCIA DOS DADOS AMOSTRAIS


# TESTE T: USADO QUANDO TEMOS APENAS UM GRUPO DE ANÁLISE, E QUEREMOS COMPARAAR A MEDIA DESSE  GRUPO COM UM VALOR DE REFERÊNCIA


# ALTURA MÉDIA DO BRASILEIRO É DE 1,67 M
# TESTES PARAMETRICOS 

shapiro.test(df$Height)

# H0: distribuição dos dados = normal, se p > 5% 
# h1: distribuição dos dados != normal, se p <= 5%

g <- rnorm(1:2111, 
           mean = , 
           sd = 1)
gaussian <- curve(dnorm(x, mean = 0, sd = 1),
           from = -4, to = 4)
plot(gaussian)

grDevices::nclass.Sturges(df$Height)
hist(df$Height,
     breaks = 13,
     probability = TRUE, # TRANSFORMA EM DENSIDADE, NÃO EM FREQUÊNCIA
     xlab = "Altura (M)",
     ylab = "Frequência",
     main = "Análise de Probabilidade da Normal")
lines(density(df$Height))
qqline(df$Height, col = "red")
qqnorm(df$Height)

psych::describe(df$Height)
var(df$Height)

# fazer teste de levene
# car::leveneTest(BC ~ Grupo, dados, center = mean)
# para o teste de levene
# se h0: as variancias dos grupos são homogeneas, logo p > 5%
# se h1: as variancias não sao homogeneas, entao p <= 5%

# skewness mede grau de assimetria da distribuição
# kurtosis mede o grau de achatamento em relação à normal

# mostra a hispersesibilidade do teste de shapiro wilk

t.test(df$Height, mu = 1.67)

# h0: a media da amostra = valor da referência na literatura, se p > 5%
# h1: media da amostra != valor da referencia, se p <= 5%

# Como escrever isso num trabalho?

# O teste t para uma amostra mostrou que a media de altura da amostra (1.7 m) é diferente da media de altura nacional (1.67 m) (t(2110) = 15.599, p = 2.2e-16)

# ANOVA DE UMA VIA, PERMITE QUE COMPAREMOS MEDIAS DE MAIS DE UM GRUPO

dados <- rio::import("https://raw.githubusercontent.com/ryallmeida/r_p_saude/refs/heads/main/database/control_placebo.csv")
# Fonte: Fernanda Peres

# teste de normalidade agrupado

install.packages("RVAdeMemoire")
RVAdeMemoire::byf.shapiro(BC ~ Grupo, dados)

dados %>%  
  group_by(Grupo) %>% 
  statix::identify_outliers(Pressao)



# ==============================================================================
# TESTES NÃO-PARAMETRICOS 

