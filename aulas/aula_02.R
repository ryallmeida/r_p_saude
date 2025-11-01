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
# AULA 02: PACKAGES, VECTORS AND FUNCTIONS: THE ENGINEERING OF R THINKING
# ==============================================================================

# HIPOTESE: QUAIS SÃO OS MELHORES GRÁFICOS APRA VISUALISAÇÃO DE DADOS QUALITATIVOS?

example(barplot)
barplot(sample(10:100,10))

pie(c(1,5,7,10))
example(pie)

sex<-c("macho","fêmea")

# por que deu erro?
sexo<-c("Ma","Ma","Ma","Ma","Ma","Fe","Fe","Fe","Fe",
        + "Fe")

sexo<-c("Ma","Ma","Ma","Ma","Ma","Fe","Fe","Fe","Fe","Fe")

peso <-c(110,120,90,70,50,80,40,40,50,30)
plot(sexo,peso)

factor(sexo)
plot(factor(sexo),peso)

stripchart(peso~sexo) # faz o gráfico, mas na horizontal
stripchart(peso~sexo,vertical=TRUE) # agora o gráfico está na vertical, porém os pontos aparecem nas extremidades. TRUE pode ser abreviado para apenas T.

stripchart(peso~sexo,
           vertical=T,
           at=c(1.3,1.7)) 

# agora os pontos estão centralizados, pois com o argumento at, nós especificamos a localização dos pontos no eixo X.

# Note que agora só há um problema. Eram cinco fêmeas e no gráfico aparecem apenas 4. Isso ocorreu porque duas fêmeas tinham o mesmo peso. Para melhorar o gráfico é necessário usar o argumento method="stack", para que os pontos não fiquem sobrepostos.

stripchart(peso~sexo,
           vertical=T,
           at=c(1.5,1.7),
           method="stack") 

# os pontos não estão mais totalmente sobrepostos, mas um símbolo ainda está sobre o outro. Usando o argumento offset conseguimos separá-los.


# ==============================================================================
# COMO CRIAR FUNÇÕES NO R? 
# ==============================================================================


