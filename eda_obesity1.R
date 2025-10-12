# UNIVERSIDADE FEDERAL DE PERNAMBUCO
# PROGRAMA DE PÓS-GRADUAÇÃO EM NUTRIÇÃO
# DEPARTAMENTO DE CIÊNCIA POLÍTICA
# CURSO: R PARA SAÚDE
# -------------------------------------

# DOCENTE PROF.ª DR.ª MARIA DO CARMO E DALSON BRITTO (DCP/UFPE)
# MONITORES RYAN ALMEIDA E CARLA CAVALCANTE (DCP/UFPE)

# -------------------------------------
# CODADO ORIGINALMENTE EM R, V. 4.4.1 EM 11 DE OUTUBRO DE 2025

# HIPOTESE: COMO DESCREVER ESSA AMOSTRA EM TERMOS DE CENTRALIDADE, DISPERSÃO, FORMA E FREQUÊNICA?

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
               RColorBrewer)

# =====================================
# IMPORTANDO DADOS

arquivos <- unzip("C:/Users/Notebook/Downloads/DOC-20250921-WA0022.zip", 
                  list = TRUE)
print(arquivos)

dados <- read.csv(unz("C:/Users/Notebook/Downloads/DOC-20250921-WA0022.zip", "ObesityDataSet_raw_and_data_sinthetic.csv"))

# =============================================================================
# ANÁLISE EXPLORATÓRIA DE DADOS
# =============================================================================
view(dados)
dplyr::glimpse(dados)

# TRANSFORMAÇÕES BÁSICAS
dados$Gender <- as.factor(dados$Gender)
dados$Age <- as.integer(dados$Age)

# dados$Gender ---------------------------------------------------------------

plot(dados$Gender)

table(dados$Gender)
# Female   Male 
#   1043   1068 

prop.table(table(dados$Gender))
#    Female      Male 
# 0.4940786 0.5059214 

# dados$Age -------------------------------------------------------------------

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

# ALTURA ----------------------------------------------------------------------

summary(dados$Height)
#  Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 1.450   1.630   1.700   1.702   1.768   1.980 

psych::describe(dados$Height)
hist(dados$Height, probability = TRUE, main = "")
lines(density(dados$Height))
rug(dados$Height)


boxplot(dados$Height)

# PESO -----------------------------------------------------------------------

summary(dados$Weight)
#  Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 39.00   65.47   83.00   86.59  107.43  173.00 

psych::describe(dados$Weight)

hist(dados$Weight, probability = TRUE, main = "") 
lines(density(dados$Weight)) 
rug(dados$Weight)

boxplot(dados$Weight)

# HISTÓRICO FAMILIAR DE SOBREPESO -----------------------------------------------------------------------

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

# Frequent consumption of high caloric food (FAVC) -----------------------------------
hist(as.numeric(dados$FAVC))

# Frequency of consumption of vegetables (FCVC) ----------------------------------------

dados$FCVC <- as.double(dados$FCVC)
hist(as.numeric(dados$FCVC))


# Number  of main meals (NCP) ----------------------------------------
hist(dados$NCP)

# Consuption of food between meals (CAEC) ----------------------------------------
plot(as.factor(dados$CAEC))

#  Consumption of water (CH20)

plot(as.factor(dados$SMOKE))

# Calories consmption monitoring (SCC)
# O entrevistado monitora o tanto de caloria que consome?

plot(as.factor(dados$SCC))

# Physical activity frequency (FAF)

hist(dados$FAF)

# Time using technology (TUE)

hist(dados$TUE)

# Consumption of alcohol (CALC)

dados$CALC <- as.factor(dados$CALC)
plot(as.factor(dados$CALC))

# Transportation used (MTRANS)

plot(as.factor(dados$MTRANS))

# Obesity leval (NObeyesdad) ----------------------------------------------------
# VARIAVEL CATEGÓRICA ORDINAL

prop.table(table(dados$NObeyesdad))
#Insufficient_Weight       Normal_Weight      Obesity_Type_I     Obesity_Type_II    0.1288489           0.1359545           0.1662719           0.1406916 
#Obesity_Type_III  Overweight_Level_I Overweight_Level_II 
#  0.1534818           0.1373757           0.1373757 

plot(as.factor(dados$NObeyesdad))

levels(factor(dados$NObeyesdad))

table1::table1(~ ., data = dados)
