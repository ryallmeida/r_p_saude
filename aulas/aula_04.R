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
# AULA 04: INFERÊNCIA ESTATÍSTICA
# ==============================================================================

pacman::p_load(tidyverse, ggplot2, here)


# INTRODUÇÃO A ANÁLISE DE REGRESSÃO ---------------------------------------

bd <- read_csv(here("database/synthetic_health_data.csv"))
#link para dowload: https://www.kaggle.com/datasets/pratikyuvrajchougule/health-and-lifestyle-data-for-regression?resource=download

# OU

# Plot inicial, sem linha de regressão
plot(bd$Diet_Quality, bd$Health_Score, ylab = "Health score", xlab = "Indice qualidade da dieta")


modelo <- lm(Health_Score ~ Diet_Quality, data = bd) 
# Acessando resultados
summary(modelo)


# Plota linha de regressão
abline(modelo, col = "red", lwd = 3.5)

# Adiciona principais resultados diretamente ao gráfico
intercepto <- round(coef(modelo)[1], 2)
coeficiente <- round(coef(modelo)[2], 2)
r2 <- round(summary(modelo)$r.squared, 3)
p_valor <- round(summary(modelo)$coefficients[2, 4], 4)

legend("topleft",
       legend = c(paste("Intercepto =", intercepto),
                  paste("Coeficiente =", coeficiente),
                  paste("R² =", r2),
                  paste("p-valor =", p_valor)),
       bty = "n",    # sem borda
       text.col = "blue",
       cex = 0.8)

# Acessando resultados
summary(modelo)



# GRÁFICOS  ---------------------------------------------------------------

# 5 GRÁFICOS PRINCIPAIS 
#install.packages("NHANES")
library(NHANES)
data(NHANES)

# Gráfico de dispersão 
bd %>% 
  ggplot(aes(x = Diet_Quality, y = Health_Score)) +
  geom_point(alpha = 0.4) +
  geom_smooth(method = "lm", se = TRUE, color = "red") + # plota linha de regressão
  labs(
    title = "Gráfico de Dispersão",
    x = "Eixo X",
    y = "Eixo Y"
  ) +
  theme_light()


# Gráfico de linha
NHANES %>% 
  ggplot(aes(x = Age, y = BMI)) +
  geom_line(linewidth = 1) +
    labs(
      title = "Gráfico de Linha",
      x = "Idade",
      y = "BMI"
  ) +
  theme_minimal()

# Gráfico de barras 
NHANES %>% 
  filter(!is.na(Education)) %>% 
  ggplot(aes(x = Education, fill = Gender)) + 
  geom_bar(position = "dodge") + # calcula as proporções, diferente de geom_col
  labs(
    title = "Gráfico de Barras",
    x = "Categoria",
    y = "Contagem"
  ) +
  theme_minimal()

# Boxplot
NHANES %>% 
  filter(!is.na(Race1)) %>% 
  ggplot(aes(x = Race1, y =SmokeAge)) +
  geom_boxplot() +
  labs(
    title = "Boxplot",
    x = "Raça",
    y = "SmokeAge"
  ) +
  theme_minimal()

# Histograma
NHANES %>% 
ggplot(aes(x = UrineVol1)) +
  geom_histogram(alpha = 0.6, position = "identity") +
  labs(
    title = "Histograma",
    x = "Volume de urina (mL/min)",
    y = "Frequência"
  ) +
  theme_minimal()


# EXEMPLO THEME -----------------------------------------------------------


dados <- bd %>% 
  filter(!is.na(Age), !is.na(BMI), !is.na(Exercise_Frequency), !is.na(Health_Score)) %>% 
  mutate(Exercise_Frequency = factor(Exercise_Frequency, 
                                     levels = c("0", "1", "2", "3", "4", "5", "6")))

ggplot(dados, aes(x = Age, y = Health_Score, color = Exercise_Frequency)) +
  geom_point(alpha = 0.6, size = 1.8) +                             # Pontos sutis
  geom_smooth(method = "lm", se = FALSE, linewidth = 0.9, linetype = "solid") +  # Linha mais fina
  scale_color_brewer(palette = "Dark2") +                           # Paleta discreta e científica
  labs(
    title = "Associação entre idade e escore de saúde",
    subtitle = "Diferenças conforme a frequência de prática de exercícios físicos",
    x = "Idade (anos)",
    y = "Escore de saúde (0–100)",
    color = "Frequência de exercício",
    caption = "Fonte: Kanggle Dataset"
  ) +
  theme_classic(base_size = 13) +                                   # Tema clássico, sem grades
  theme(
    plot.title = element_text(face = "bold", size = 14, hjust = 0),
    plot.subtitle = element_text(size = 12, hjust = 0),
    axis.title = element_text(face = "bold"),
    axis.text = element_text(color = "black"),
    legend.position = "bottom",
    legend.title = element_text(face = "bold"),
    legend.key.height = unit(0.5, "cm"),
    panel.border = element_rect(color = "black", fill = NA, linewidth = 0.6),
    plot.caption = element_text(size = 9, hjust = 1, face = "italic")
  )
