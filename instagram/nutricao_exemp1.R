# UNIVERSIDADE FEDERAL DE PERNAMBUCO
# PROGRAMA DE PÓS-GRADUAÇÃO EM NUTRIÇÃO
# DEPARTAMENTO DE CIÊNCIA POLÍTICA
# CURSO: R PARA SAÚDE
# -------------------------------------

# DOCENTE PROF.ª DR.ª MARIA DO CARMO E DALSON BRITTO (DCP/UFPE)
# MONITORES RYAN ALMEIDA E CARLA CAVALCANTE (DCP/UFPE)

# -------------------------------------
# CODADO ORIGINALMENTE EM R, V. 4.4.1 EM 12 DE OUTUBRO DE 2025

# Figura para estudos de nutrição - exemplo em R
# Requer: tidyverse (dplyr, ggplot2), ggpubr (opcional), patchwork
# install.packages(c("tidyverse", "ggpubr", "patchwork"))

if(!require("pacman")) {
  install.packages("pacman")
}

pacman::p_load(tidyverse, ggpubr, patchwork)

# library(ggpubr)    # para stat_summary/summary_fun (opcional)
# library(patchwork) # para combinar plots

set.seed(123)

# --- 1. Simular dados de exemplo ---
n <- 180
dados <- tibble(
  id = 1:n,
  grupo = sample(c("Controle", 
                   "Intervenção A", 
                   "Intervenção B"), 
                 n, 
                 replace = TRUE),
  sexo = sample(c("Feminino",
                  "Masculino"), 
                n, 
                replace = TRUE),
  idade = round(rnorm(n, 
                      mean = 45, 
                      sd = 12)),
  energia_kcal = round(rnorm(n, 
                             mean = 2200, 
                             sd = 450)),
  protein_g = round(rnorm(n,
                          mean = 80, 
                          sd = 20)),
  fat_g = round(rnorm(n, 
                      mean = 80, 
                      sd = 25)),
  carb_g = round(rnorm(n, 
                       mean = 300, 
                       sd = 70))
)

# Ajustes para criar diferenças entre grupos (apenas para a demo)
dados <- dados %>%
  mutate(
    protein_g = case_when(
      grupo == "Controle" ~ protein_g - 3,
      grupo == "Intervenção A" ~ protein_g + 5,
      grupo == "Intervenção B" ~ protein_g + 1
    ),
    energia_kcal = case_when(
      grupo == "Controle" ~ energia_kcal,
      grupo == "Intervenção A" ~ energia_kcal - 120,
      grupo == "Intervenção B" ~ energia_kcal + 80
    )
  )

# --- 2. Sumário para média e erro padrão (para plot A) ---
resumo_protein <- dados %>%
  group_by(grupo) %>%
  summarise(
    mean_protein = mean(protein_g),
    sd_protein = sd(protein_g),
    n = n(),
    se_protein = sd_protein / sqrt(n)
  )

# --- 3. Plot A: Boxplot de proteína por grupo + pontos individuais + média ± SE ---
p1 <- ggplot(dados, aes(x = grupo, y = protein_g, fill = grupo)) +
  geom_boxplot(outlier.shape = NA, alpha = 0.4, width = 0.6) +
  geom_jitter(width = 0.15, alpha = 0.6, size = 1.4) +
  geom_point(data = resumo_protein, aes(x = grupo, y = mean_protein), color = "black", size = 3) +
  geom_errorbar(data = resumo_protein,
                aes(x = grupo, y = mean_protein, ymin = mean_protein - se_protein, ymax = mean_protein + se_protein),
                width = 0.15, color = "black", size = 0.8) +
  stat_summary(fun = median, geom = "point", shape = 95, size = 6, color = "white") +
  labs(title = "",
       x = "", y = "Proteína (g/dia)") +
  theme_minimal(base_size = 14) +
  theme(legend.position = "none") +
  scale_fill_brewer(palette = "Set2")

# p1 == A: Proteína ingerida por grupo dietético
print(p1)

# ggsave("C:/Users/Notebook/Downloads/exemp1_nutri.png", plot = p1, width = 10, height = 6, dpi = 300)

# --- 4. Plot B: Energia vs Proteína com ajuste linear por grupo ---
p2 <- ggplot(dados, aes(x = energia_kcal, 
                        y = protein_g, 
                        color = grupo)) + 
  geom_point(alpha = 0.7, 
             size = 1.8) +
  geom_smooth(method = "lm", 
              se = TRUE, 
              fullrange = FALSE) +
  labs(title = "",
       x = "Energia (kcal/dia)", 
       y = "Proteína (g/dia)", 
       color = "Grupo") +
  theme_minimal(base_size = 14) +
  viridis::scale_fill_viridis(discrete = TRUE, alpha=0.6)

print(p2)

# ggsave("C:/Users/Notebook/Downloads/exemp2_nutri.png", plot = p2, width = 10, height = 6, dpi = 300)

# --- 5. Combinar (patchwork) e adicionar anotações simples ---
figura <- (p1 + p2) + plot_layout(ncol = 2, widths = c(1,1)) &
  theme(plot.title = element_text(face = "bold"))

# Exibir
print(figura)

# --- 6. Salvar em arquivos ---
ggsave("figura_nutricao_exemplo.png", figura, width = 14, height = 6, dpi = 300)
ggsave("figura_nutricao_exemplo.pdf", figura, width = 14, height = 6)

# --- 7. Sugestões de uso ---
# - Substitua 'dados' pelo seu data.frame real, com colunas equivalentes.
# - Para análises ajustadas (ex.: ANCOVA por idade/sexo), rode modelos lineares e plote os valores ajustados.
# - Se preferir uma única figura para artigos, ajuste width/height e use theme_classic().

# ============================================================================
# EXEMPLO PARA O INSTAGRAM

p2_instagram <- ggplot(dados, aes(x = energia_kcal, y = protein_g, color = grupo)) +
  geom_point(alpha = 0.7, size = 1.8) +
  geom_smooth(method = "lm", se = TRUE, fullrange = FALSE) +
  labs(
    title = "",
    x = "Energia (kcal/dia)",
    y = "Proteína (g/dia)",
    color = "Grupo"
  ) +
  theme_minimal(base_size = 14) +
  scale_color_manual(values = c("#d85102", "#575b21", "#985612"))

print(p2_instagram)

# ggsave("C:/Users/Notebook/Downloads/cor_instagram.png", plot = p2_instagram, width = 10, height = 6, dpi = 300)

p1_instagram <- ggplot(dados, aes(x = grupo, y = protein_g, fill = grupo)) +
  geom_boxplot(outlier.shape = NA, alpha = 0.4, width = 0.6) +
  geom_jitter(width = 0.15, alpha = 0.6, size = 1.4) +
  geom_point(data = resumo_protein, aes(x = grupo, y = mean_protein), color = "black", size = 3) +
  geom_errorbar(data = resumo_protein,
                aes(x = grupo, y = mean_protein, ymin = mean_protein - se_protein, ymax = mean_protein + se_protein),
                width = 0.15, color = "black", size = 0.8) +
  stat_summary(fun = median, geom = "point", shape = 95, size = 6, color = "white") +
  labs(title = "",
       x = "", y = "Proteína (g/dia)") +
  theme_minimal(base_size = 14) +
  theme(legend.position = "none") +
  scale_fill_manual(values = c("#d85102", "#575b21", "#985612"))

print(p1_instagram)

# ggsave("C:/Users/Notebook/Downloads/boxplot2_instagram.png", plot = p1_instagram, width = 10, height = 6, dpi = 300)

                    