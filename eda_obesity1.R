# UNIVERSIDADE FEDERAL DE PERNAMBUCO
# PROGRAMA DE PÓS-GRADUAÇÃO EM NUTRIÇÃO
# DEPARTAMENTO DE CIÊNCIA POLÍTICA
# CURSO: R PARA SAÚDE
# -------------------------------------

# DOCENTE PROF.ª DR.ª MARIA DO CARMO E DALSON BRITTO (DCP/UFPE)
# MONITORES RYAN ALMEIDA E CARLA CAVALCANTE (DCP/UFPE)

# -------------------------------------
# CODADO ORIGINALMENTE EM R, V. 4.4.1 EM 11 DE OUTUBRO DE 2025

# HIPOTESE: COMO DESCREVER ESSA AMOSTRA EM TERMOS DE CENTRALIDADE, DISPERSÃO, FORMA E FREQUÊNCIA?

# =====================================
# IMPORTANDO BIBLIOTECAS

if(!require("pacman")) {
  install.packages("pacman")
}

pacman::p_load(tidyverse, 
               psych, 
               likert, 
               table1, 
               flextable, 
               RColorBrewer, 
               viridis)

# =====================================
# IMPORTANDO DADOS

arquivos <- unzip("C:/Users/Notebook/Downloads/DOC-20250921-WA0022.zip", 
                  list = TRUE)
# print(arquivos)

dados <- read.csv(unz("C:/Users/Notebook/Downloads/DOC-20250921-WA0022.zip", "ObesityDataSet_raw_and_data_sinthetic.csv"))

# =============================================================================
# ANÁLISE EXPLORATÓRIA DE DADOS
# =============================================================================

# NOTA ------------------------------------------------------------------------
# LEMBRE-SE QUE HÁ VARIÁVEIS QUALITATIVAS NOMINAIS E ORDINAIS E QUANTITATIVAS DISCRETA E CONTINUA 

# VARIAVEIS DICOTÔMICAS-BINÁRIAS TEORICAMENTE SÃO VARIAVEIS QUALITATIVAS NOMINAIS POIS NÃO HA UMA ORDEM NATURAL-TEÓRICA PARA DESCREVÊ-LA, ENTRENTANTO PARA MODELAGENS ELA DEVE SER TRATADAS COMO UMA VARIAVEL QUANTITATIVA DISCRETA (VIA TRATAMENTO ESTATISTICO)

view(dados)
# HIPOTESE: COMO A MAQUINA ESTA LENDO ESSAS VARIÁVEIS?
dplyr::glimpse(dados)

# TRANSFORMAÇÕES BÁSICAS
dados$Gender <- as.factor(dados$Gender)
dados$Age <- as.integer(dados$Age)
# =============================================================================
# dados$Gender ---------------------------------------------------------------
# =============================================================================
# VARIÁVEL CATEGÓRICA DICOTÔMICA

plot(dados$Gender)

table(dados$Gender)
# Female   Male 
#   1043   1068 

prop.table(table(dados$Gender))
#    Female      Male 
# 0.4940786 0.5059214 

# =============================================================================
# dados$Age -------------------------------------------------------------------
# =============================================================================
# VARIÁVEL CONTINUA DISCRETA

hist(dados$Age, include.lowest = T)
# Observa-se que a amostra gira em torno de pessoas de aproximadamente 15 a 45 anos 

length(which(dados$Age < 14))
length(which(dados$Age > 61))
# POR TENTATIVA E ERRO OBSERVEI QUE A AMOSTRA É COMPOSTA DE PESSOAS QUE TÊM ENTRE 14 A 61 ANOS

# ENTENDENDO COMO QUE A AMOSTRA ELA É COMPOSTA, AGRUPANDO POR FAIXA DE IDADE E SEXO
# PROPORCIONALMENTE E NORMALIZADO OS DADOS

k <- grDevices::nclass.Sturges(dados$Age)
faixa_idade <- cut(dados$Age, breaks = k)

prop.table(table(cut(dados$Age, 
                     breaks = grDevices::nclass.Sturges(dados$Age))))

tabela_freq <- table(dados$Gender, faixa_idade)
print(as.data.frame(prop.table(tabela_freq)))

view(df_prop)

# EXTREMAMENTE MUITO BEM REPRESENTADO ESSA AMOSTRA DE PESSOAS 

round(100 * prop.table(table(cut(dados$Age, 
                                 breaks = grDevices::nclass.Sturges(dados$Age)))), 2)

# VARIAVEL CATEGORICA (GENDER)  X VARIAVE QUANT DISCRETA (AGE)

dados$Gender <- as.factor(dados$Gender)

ggplot2::ggplot(dados, aes(x = Age,
                           fill = Gender)) +
  geom_density(alpha = 0.5, 
               color = NA) +
  labs(title = "", 
       x = "Idade",
       y = "Densidade") + 
  theme_gray()

# ALTURA ----------------------------------------------------------------------
# VARIÁVEL CONTINUA 

p1 <- dados %>%
  ggplot( aes(x= Gender, 
              y= Height, 
              fill= Gender)) +
  geom_violin(alpha = 0.2, 
              scale = "width") +
  geom_boxplot() +
  viridis::scale_fill_viridis(discrete = TRUE, 
                              alpha=0.6) +
  geom_jitter(color="black", 
              size=0.2, 
              alpha=0.7,
              width = 0.4,
              shape = 10) +
  theme(
    legend.position="none",
    plot.title = element_text(size=11)
  ) +
  ggtitle("") +
  xlab("")

# ggsave("C:/Users/Notebook/Downloads/bloxplot1.png", plot = p1, width = 10, height = 6, dpi = 300)

p1_void <- dados %>%
  ggplot( aes(x= Gender, 
              y= Height, 
              fill= Gender)) +
  geom_violin(alpha = 0.2, 
              scale = "width") +
  geom_boxplot() +
  viridis::scale_fill_viridis(discrete = TRUE, 
                              alpha=0.6) +
  geom_jitter(color="black", 
              size=0.2, 
              alpha=0.7,
              width = 0.4,
              shape = 10) +
  theme_void() +
  ggtitle("") +
  xlab("")

# ggsave("C:/Users/Notebook/Downloads/bloxplot1_void.png", plot = p1_void, width = 10, height = 6, dpi = 300)

summary(dados$Height)
#  Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 1.450   1.630   1.700   1.702   1.768   1.980 

psych::describe(dados$Height)
hist(dados$Height, probability = TRUE, main = "")
lines(density(dados$Height))
rug(dados$Height)


boxplot(dados$Height)

# PESO -----------------------------------------------------------------------
# VARIÁVEL CONTINUA

p2 <- dados %>%
  ggplot( aes(x= Gender, 
              y= Weight, 
              fill= Gender)) +
  geom_violin(alpha = 0.2, 
              scale = "width") +
  geom_boxplot() +
  viridis::scale_fill_viridis(discrete = TRUE, 
                              alpha=0.6) +
  geom_jitter(color="black", 
              size=0.2, 
              alpha=0.7,
              width = 0.4,
              shape = 10) +
  theme(
    legend.position="none",
    plot.title = element_text(size=11)
  ) +
  ggtitle("") +
  xlab("")

print(p2)

# ggsave("C:/Users/Notebook/Downloads/bloxplot_peso.png", plot = p2, width = 10, height = 6, dpi = 300)

p2_void <- dados %>%
  ggplot( aes(x= Gender, 
              y= Weight, 
              fill= Gender)) +
  geom_violin(alpha = 0.2, 
              scale = "width") +
  geom_boxplot() +
  viridis::scale_fill_viridis(discrete = TRUE, 
                              alpha=0.6) +
  geom_jitter(color="black", 
              size=0.2, 
              alpha=0.7,
              width = 0.4,
              shape = 10) +
  theme_void() +
  ggtitle("") +
  xlab("")

# ggsave("C:/Users/Notebook/Downloads/bloxplot_peso_void.png", plot = p2_void, width = 10, height = 6, dpi = 300)

summary(dados$Weight)
#  Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 39.00   65.47   83.00   86.59  107.43  173.00 

psych::describe(dados$Weight)

hist(dados$Weight, probability = TRUE, main = "") 
lines(density(dados$Weight)) 
rug(dados$Weight)

boxplot(dados$Weight)

# ------------------------------------

ggplot2::ggplot(dados, aes(x = Weight,
                           fill = Gender)) +
  geom_density(alpha = 0.5, 
               color = NA) +
  labs(title = "", 
       x = "Peso",
       y = "Densidade") + 
  theme_gray()

# PROBLEMA: PARA COMPARAR VARIAVEIS TIVE QUE NORMALIZÁ-LAS POR ZSCORE VISTO QUE PESO E ALTURA ESTAVAM EM UNIDADE DE MEDIDAS DIFERENTES

Height_z <- scale(dados$Height)
Weight_z <- scale(dados$Weight)


p3 <- ggplot(dados) +
  # Altura padronizada (cima)
  geom_density(aes(x = Height_z, 
                   y = after_stat(density)/max(after_stat(density)), 
                   fill = Gender),
               alpha = 0.5, 
               color = NA) +
  viridis::scale_fill_viridis(discrete = TRUE, 
                              alpha=0.6) +
  annotate("label",
           x = 4.5,
           y = 0.25,
           label = "Altura",
           color = "black", 
           hjust = 1) +
  
  # Peso padronizado (baixo, espelhado)
  geom_density(aes(x = Weight_z, y = -after_stat(density)/max(after_stat(density)), fill = Gender),
               alpha = 0.5, 
               color = NA) + 
  viridis::scale_fill_viridis(discrete = TRUE, 
                              alpha=0.6) +
  annotate("label",
           x = 4.5,
           y = -0.25,
           label = "Peso",
           color = "black", 
           hjust = 1) +
  geom_hline(yintercept = 0) +
  labs(title = "", 
       x = "Valores padronizados (Zscore)",
       y = "Densidade normalizada") +
  theme_minimal()
print(p3)

#ggsave("C:/Users/Notebook/Downloads/densidade_peso_altura.png", plot = p3, width = 10, height = 6, dpi = 300)

p3_void <- ggplot(dados) +
  # Altura padronizada (cima)
  geom_density(aes(x = Height_z, 
                   y = after_stat(density)/max(after_stat(density)), 
                   fill = Gender),
               alpha = 0.5, 
               color = NA) +
  viridis::scale_fill_viridis(discrete = TRUE, 
                              alpha=0.6) +
  annotate("label",
           x = 4.5,
           y = 0.25,
           label = "Altura",
           color = "black", 
           hjust = 1) +
  
  # Peso padronizado (baixo, espelhado)
geom_density(aes(x = Weight_z, y = -after_stat(density)/max(after_stat(density)), fill = Gender),
               alpha = 0.5, 
               color = NA) + 
  viridis::scale_fill_viridis(discrete = TRUE, 
                              alpha=0.6) +
  annotate("label",
           x = 4.5,
           y = -0.25,
           label = "Peso",
           color = "black", 
           hjust = 1) +
  geom_hline(yintercept = 0) +
  theme_void()

print(p3_void)

# ggsave("C:/Users/Notebook/Downloads/densidade_peso_altura_void.png", plot = p3_void, width = 10, height = 6, dpi = 300)

# HISTÓRICO FAMILIAR DE SOBREPESO -----------------------------------------------------------------------
# VARIÁVEL CATEGÓRICA DICOTÔMICA

plot(as.factor(dados$family_history_with_overweight))

prop.table(table(dados$family_history_with_overweight))
#       no      yes 
# 0.182378 0.817622 

# AGRUPANDO POR HISTÓRICO FAMILIAR E FAIXA DE IDADE
tabela_freq2 <- table(dados$family_history_with_overweight, faixa_idade)
print(as.data.frame(prop.table(tabela_freq2)))

# AGRUPANDO POR HISTÓRICO FAMILIAR E GÊNERO
tabela_freq3 <- table(dados$family_history_with_overweight, dados$Gender)
print(as.data.frame(prop.table(tabela_freq3)))
#   Var1   Var2      Freq
# 1   no Female 0.1099005
# 2  yes Female 0.3841781
# 3   no   Male 0.0724775
# 4  yes   Male 0.4334439

tabela_freq4 <- table(dados$family_history_with_overweight, dados$NObeyesdad)
print(as.data.frame(prop.table(tabela_freq4)))

# PARA FUTURAS MODELAGENS E OUTROS TIPOS DE ANÁLISE PRECISA-SE CONVERTER OS CARACTERES EM NUMEROS, ENTÃO "YES" == 1 E "NO" == 0
dados$family_history_with_overweight <- as.numeric(ifelse(dados$family_history_with_overweight == "yes", 1, ifelse(dados$family_history_with_overweight == "no", 0, NA)))
head(dados$family_history_with_overweight)

# Frequent consumption of high caloric food (FAVC) -----------------------------------
# VARIAVEL CATEGORICA DICOTOMICA


unique(dados$FAVC)
# [1] "no"  "yes"

dados$FAVC <- as.numeric(
  ifelse(dados$FAVC == "yes", 1, 
         ifelse(dados$FAVC == "no", 0, NA)))
unique(dados$FAVC)
# YES == 1
#  NO == 0

plot(factor(dados$FAVC))
# MAJORITARIAMENTE A AMOSTRA TEM UM ALTO CONSUMO DE COMIDAS ALTAMENTE CALÓRICAS 

# DADOS PROPORCIONAMENTE FALANDO
prop.table(table(dados$FAVC))
#       0         1 
#0.1160587 0.8839413 


tabela_freq5 <- table(dados$FAVC, dados$NObeyesdad)
print(as.data.frame(prop.table(tabela_freq5)))

# FREQUENCY OF CONSUMPTION OF VEGETABLES (FCVC) ----------------------------------------

unique(dados$FCVC)

p4 <- dados %>%
  ggplot( aes(x= Gender, 
              y= FCVC, 
              fill= Gender)) +
  geom_violin(alpha = 0.2, 
              scale = "width") +
  geom_boxplot() +
  viridis::scale_fill_viridis(discrete = TRUE, 
                              alpha=0.6) +
  geom_jitter(color="black", 
              size=0.2, 
              alpha=0.7,
              width = 0.4,
              shape = 10) +
  labs(title = "",
       y = "Frequency of Comsumption of Vegetables") +
  theme_minimal()
  
print(p4)

# ggsave("C:/Users/Notebook/Downloads/boxplot_FCVC.png", plot = p4, width = 10, height = 6, dpi = 300)

hist(as.numeric(dados$FCVC))

# NUMBER OF MAIN MEALS (NCP) -----------------------------------------------------

p5 <- dados %>%
  ggplot( aes(x= Gender, 
              y= NCP, 
              fill= Gender)) +
  geom_violin(alpha = 0.2, 
              scale = "width") +
  geom_boxplot() +
  viridis::scale_fill_viridis(discrete = TRUE, 
                              alpha=0.6) +
  geom_jitter(color="black", 
              size=0.2, 
              alpha=0.7,
              width = 0.4,
              shape = 10) +
  labs(title = "",
       y = "Number of main of meals") +
  theme_minimal()

print(p5)

# ggsave("C:/Users/Notebook/Downloads/boxplot_NCp.png", plot = p5, width = 10, height = 6, dpi = 300)

hist(dados$NCP)

# CONSUPTION OF FOOD BETWEN MEALS (CAEC) ----------------------------------------
plot(as.factor(dados$CAEC))
unique(dados$CAEC)
# VARIAVEL CATEGORICA ORDINAL

p6 <- dados %>%
  ggplot( aes(x= Gender, 
              y= NCP, 
              fill= Gender)) +
  geom_violin(alpha = 0.2, 
              scale = "width") +
  geom_boxplot() +
  viridis::scale_fill_viridis(discrete = TRUE, 
                              alpha=0.6) +
  geom_jitter(color="black", 
              size=0.2, 
              alpha=0.7,
              width = 0.4,
              shape = 10) +
  labs(title = "",
       y = "Number of main of meals") +
  theme_minimal()

print(p5)

# ggsave("C:/Users/Notebook/Downloads/boxplot_NCp.png", plot = p5, width = 10, height = 6, dpi = 300)



# CONSUMPTION OF WATER (CH20) -----------------------------------------------------

plot(as.factor(dados$SMOKE))

# Calories consmption monitoring (SCC)
# O entrevistado monitora o tanto de caloria que consome?

plot(as.factor(dados$SCC))

# PHYSICAL ACTIVITY FREQUENCY (FAF) -----------------------------------------------------

hist(dados$FAF)

# TIME USING TECHNOLOGY (TUE) -----------------------------------------------------

hist(dados$TUE)

# CONSUMTION OF ALCOHOL (CALC) -----------------------------------------------------

dados$CALC <- as.factor(dados$CALC)
plot(as.factor(dados$CALC))

# TRANSPORTATION USED (MTRANS) -----------------------------------------------------

plot(as.factor(dados$MTRANS))

# OBSESITY LEVEL (NObeyesdad) ----------------------------------------------------
# VARIAVEL CATEGÓRICA ORDINAL

prop.table(table(dados$NObeyesdad))
#Insufficient_Weight       Normal_Weight      Obesity_Type_I     Obesity_Type_II    0.1288489           0.1359545           0.1662719           0.1406916 
#Obesity_Type_III  Overweight_Level_I Overweight_Level_II 
#  0.1534818           0.1373757           0.1373757 

plot(as.factor(dados$NObeyesdad))
levels(factor(dados$NObeyesdad))

# ---------------------------------------------------
# ----------------------------------------- g



