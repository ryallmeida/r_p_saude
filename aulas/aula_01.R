# UNIVERSIDADE FEDERAL DE PERNAMBUCO 
# PROGRAMA DE PÓS-GRADUAÇÃO EM NUTRIÇÃO & DEPARTAMENTO DE CIÊNCIA POLÍTICA
# CURSO: R PARA SAÚDE, 3 A 7 DE NOVEMBRO DE 2025
# AULA 01 
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

# demonstrações 

demo(graphics) 
demo(persp)
demo(image)

# como criar objetos/vetores no R?

# Criando um vetor numérico com o número de casos de dengue registrados em 10 municípios
# (valores fictícios, apenas para fins didáticos)
dengue <- c(45, 62, 33, 80, 25, 47, 90, 15, 72, 64)

# Verificando o tamanho do vetor (quantos municípios estão representados)
length(dengue)

# Criando um vetor com nomes de doenças (variável categórica)
doencas <- c("Dengue", "Zika", "Chikungunya", "Covid-19", "Influenza")
doencas

# Criando um vetor com nomes de cidades onde os dados foram coletados
cidades <- c("Recife", "Caruaru", "Petrolina", "Garanhuns")
cidades

# ==============================================================================
# OPERAÇÕES COM VETORES
# ==============================================================================

max(dengue)   # valor máximo (maior número de casos)
min(dengue)   # valor mínimo (menor número de casos)
sum(dengue)   # soma total dos casos registrados
dengue^2      # quadrado do número de casos (exemplo de operação aritmética)
dengue / 10   # divisão dos valores por 10 (por exemplo, para padronizar por 10 mil habitantes)

# calculo "manual de media"
n.dengue <- length(dengue)         # número de observações (n = 10)
media.dengue <- sum(dengue) / n.dengue   # média de casos

# como acessar informações dos vetores no R

#retomando esse exemplo
dengue <- c(45, 62, 33, 80, 25, 47, 90, 15, 72, 64)
dengue[5]   # Qual é o quinto valor (5º município)?
dengue[c(5, 8, 10)]   # acessa o 5º, 8º e 10º valores


cidades <- c("Recife", "Caruaru", "Petrolina", "Garanhuns", "Olinda",
             "Serra Talhada", "Arcoverde", "Salgueiro", "Goiana", "Paulista")

cidades[3]  # Qual é a terceira cidade?
dengue[-1]  # remove o primeiro valor (45 casos)
dengue[1] <- 50   # substitui o 1º valor por 50
dengue

# transformação de vetores

sqrt(dengue) #A transformação por raiz quadrada é útil quando os dados são contagens, como número de casos, pois ela reduz a variabilidade relativa sem distorcer a estrutura dos dados.
log10(dengue)   # logaritmo na base 10
log(dengue)     # logaritmo natural (base e)

# O logaritmo é uma das transformações mais usadas em epidemiologia e bioestatística.Por exemplo, quando analisamos taxas de mortalidade ou incidência que variam muito entre regiões, o log ajuda a reduzir o impacto de valores extremos.

# ==============================================================================
# LISTAGEM E REMOÇÃO DE OBJETOS
# ==============================================================================
ls()

dengue.log <- log10(dengue)   # cria um novo objeto com valores transformados
rm(dengue.log)
dengue.log

# ==============================================================================
# GERADOR DE SEQUENCIA NO R
# ==============================================================================

1:10     # sequência de 1 a 10 (ex: anos de acompanhamento)
5:16     # sequência de 5 a 16 (ex: idades de 5 a 16 anos)

# veja o default da função seq
?seq
seq(1, 10, 2)   # sequência de 1 a 10, pulando de 2 em 2
seq(0, 100, 20)


#exemplos 

# intervalo de tempos por semana
seq(from = 1, to = 52, by = 1)  # 52 semanas do ano

# doses crescentes de um medicamento 
seq(from = 0.5, to = 5, by = 0.5)
# doses de 0.5 a 5 mg em intervalos de 0.5 mg

#gerador de repetições
rep(x, times = y)
#sintaxe/default da função 

rep(5, 10)      # repete o valor 5 dez vezes
rep(2, 5)       # repete o valor 2 cinco veze

rep(1:4, 2)
# exemplo: esse padrão pode representar, códigos de grupos de tratamento ou rodadas de coleta de dados.

rep(1:4, each = 2)
# exemplo acima: dada número pode representar um grupo de risco (1 = baixo, 2 = médio, 3 = alto, 4 = muito alto), e each = 2 simula duas observações por grupo.

rep(c("Controle", "Tratamento"), each = 5)
rep(c("Dengue", "Zika", "Covid-19", "Influenza"), c(3, 2, 7, 4))

# ==============================================================================
# GERAÇÃO/SIMULAÇÃO DE COMPORTAMENTO DE DADOS
# ==============================================================================

# Na área da saúde, é comum simular dados para: testar análises antes de ter dados reais,criar exercícios didáticos, simular medições laboratoriais ou casos de doenças.

# Sintaxe/default geral
runif(n, min = 0, max = 1)

# Exemplo: gerar 200 pacientes com pressão arterial entre 80 e 100 mmHg
pressao <- runif(200, 80, 100)

# Visualizar a distribuição
hist(pressao, main = "Histograma da pressão arterial (mmHg)", 
     xlab = "Pressão", col = "lightblue")


# Sintaxe/default geral
rnorm(n, mean = 0, sd = 1)

# Exemplo: 200 pacientes com nível de glicemia (mg/dL), média = 100, sd = 15
glicemia <- rnorm(200, mean = 100, sd = 15)

# Histograma
hist(glicemia, main = "Histograma de glicemia (mg/dL)",
     xlab = "Glicemia", col = "lightgreen")


?Distributions

#rbinom() → distribuição binomial (ex.: sucesso/falha, presença/ausência de doença);
#rpois() → distribuição de Poisson (ex.: número de casos de doença rara em uma população);
#rexp() → distribuição exponencial (ex.: tempo até um evento clínico).

# ==============================================================================
# FAZER A SELEÇÃO/CRIAÇÃO DE AMOSTRAS ALEATÓRIAS
# ==============================================================================

sample(x, size=1, replace = FALSE)# onde x é o conjunto de dados do qual asamostras serão retiradas, size é o número de amostras e replace é onde você indica se a amostra deve ser feita com reposição (TRUE) ou sem reposição (FALSE). 

# ==============================================================================
# ORDENAR DADOS E ATRIBUIÇÃO DE POSTOS
# ==============================================================================

exemplo<-sample(1:100,10)
exemplo

sort(exemplo) # para colocar em ordem crescente
sort(exemplo, decreasing=TRUE) # para colocar em ordem decrescente
order(exemplo) #r retorna a posição original de cada valor do objeto "exemplo" caso os valores do objeto "exemplo" sejam colocados em ordem

rank(exemplo) # Para atribuir postos (ranks) aos valores do exemplo


