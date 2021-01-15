# Classificação Multiclasse com SVM - Prevendo Gastos com Cartão de Crédito em 3 Categorias

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Definindo o diretório de trabalho
getwd()
setwd("~/Dropbox/MachineLearning2.0/Cap11/R")

####  Definido o Problema de Negócio #### 

# A identificação e a capacidade de classificar os clientes com base nos gastos sempre foram uma área de 
# interesse para instituições bancárias e empresas de cartão de crédito. É um aspecto importante no 
# gerenciamento de relacionamento com o cliente e ajuda a aumentar a receita com clientes existentes. Várias 
# tentativas foram feitas a esse respeito. Os emissores de cartões de crédito tradicionalmente têm como alvo 
# os consumidores usando informações sobre seus comportamentos e dados demográficos. 

# Nosso trabalho é classificar os clientes de cartão de crédito de acordo com seu comportamento de gastos. 
# A segmentação é um aspecto importante na compreensão do cliente e na execução de campanhas de marketing 
# eficazes e rentáveis. Usaremos o SVM como nosso modelo.

# Os dados demográficos, os detalhes sobre emprego e o estilo de vida dos clientes desempenham um papel vital na 
# maneira como eles gastam. Existem fatores ocultos, bem como semelhança com as compras. A máquina de vetores 
# de suporte pode ser usada para problemas de regressão e classificação. 

# Usaremos SVM com Kernel Linear Multiclasse como nosso modelo proposto para classificar a variável target. 
# No entanto, também avaliaremos outros Kernels, como RBF e Polinomial, para uma variedade de hiperparâmetros. 
# Também levamos em consideração o viés no dados.

# Fonte dos dados: https://sorry.vse.cz/~berka/ (dados anônimos)

# Pacotes
install.packages("gains")
install.packages("pROC")
install.packages("ROSE")
install.packages("mice")
library(dplyr)
library(caret)
library(gains)
library(pROC)
library(ROCR)
library(ROSE)
library(e1071)
library(mice)

# Carregando os dados
dataset_clientes <- read.csv("dados/cartoes_clientes.csv")
View(dataset_clientes)


#### Análise Exploratória dos Dados #### 
str(dataset_clientes)
summary(dataset_clientes)
summary(dataset_clientes$card2spent)

# Removemos a variável com ID do cliente pois não é necessário
dataset_clientes <- dataset_clientes[-1]
View(dataset_clientes)

# Checando valores missing
sapply(dataset_clientes, function(x)sum(is.na(x)))

# Checando se a variável alvo está balanceada
table(dataset_clientes$Customer_cat)
prop.table(table(dataset_clientes$Customer_cat)) * 100

# Outra alternativa
as.data.frame(table(dataset_clientes$Customer_cat))

# Análise Visual

# BoxPlot e Histograma
boxplot(dataset_clientes$card2spent)
summary(dataset_clientes$card2spent)
hist(dataset_clientes$card2spent)

boxplot(dataset_clientes$hourstv)
summary(dataset_clientes$hourstv)
hist(dataset_clientes$hourstv)

# Scatter Plot
plot(dataset_clientes$card2spent, dataset_clientes$hourstv, xlab = "Gasto Cartão", ylab = "Horas TV")
