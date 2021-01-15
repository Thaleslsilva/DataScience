# Classificação Multiclasse com SVM - Prevendo Gastos com Cartão de Crédito em 3 Categorias

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Definindo o diretório de trabalho
getwd()
setwd("~/Dropbox/MachineLearning2.0/Cap11/R")

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
