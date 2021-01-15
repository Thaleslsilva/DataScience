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


#### Pré-Processamento dos Dados #### 

# Removemos a variável com ID do cliente pois não é necessário
dataset_clientes <- dataset_clientes[-1]
View(dataset_clientes)

# Função para Fatorização de variáveis categóricas
to.factors <- function(df, variables){
  for (variable in variables){
    df[[variable]] <- as.factor(paste(df[[variable]]))
  }
  return(df)
}

# Lista de varáveis categóricas
categorical.vars <- c('townsize', 'jobcat', 'retire', 'hometype', 'addresscat', 
                      'cartype', 'carvalue', 'carbought', 'card2', 'gender', 'card2type', 
                      'card2benefit', 'card2benefit', 'bfast', 'internet', 'Customer_cat')

# Fatorizando as variáveis categóricas (alterando as variáveis categóricas para fatores)
str(dataset_clientes)
dataset_clientes <- to.factors(df = dataset_clientes, variables = categorical.vars)
str(dataset_clientes)
View(dataset_clientes)
str(dataset_clientes$gender)


# Aplicando Imputação em Valores Missing Usando Método PMM (Predictive Mean Matching)

# Checando valores missing
sapply(dataset_clientes, function(x)sum(is.na(x)))
sum(is.na(dataset_clientes))

# A correspondência média preditiva (PMM) é uma maneira atraente de fazer imputação múltipla para dados 
# ausentes, especialmente para imputar variáveis quantitativas que não são normalmente distribuídas. 

# Variável dummy
# Variável sexo = 0 ou 1
# sexo_M = 1
# sexo_F = 0

# Comparado com métodos padrão baseados em regressão linear e distribuição normal, o PMM produz valores 
# imputados que são muito mais parecidos com valores reais. Se a variável original estiver inclinada, os 
# valores imputados também serão inclinados. Se a variável original estiver delimitada por 0 e 100, os 
# valores imputados também serão delimitados por 0 e 100. E se os valores reais forem discretos 
# (como número de filhos), os valores imputados também serão discretos. 

# Descobrindo os números das colunas das variáveis fatores, para excluí-las da imputação
fac_col <- as.integer(0)
facnames <- names(Filter(is.factor, dataset_clientes))
k = 1

for(i in facnames){
  while (k <= 16){
    grep(i, colnames(dataset_clientes))
    fac_col[k] <- grep(i, colnames(dataset_clientes))
    k = k + 1
    break
  }
}

# Colunas que são do tipo fator
fac_col

# Imputação

# Fatiamento do dataset
View(dataset_clientes)
View(dataset_clientes[,-c(fac_col)])

# Definindo a regra de imputação
?mice
regra_imputacao <- mice((dataset_clientes[,-c(fac_col)]), 
                        m = 1, 
                        maxit = 50, 
                        meth = 'pmm', 
                        seed = 500)

# Aplicando a regra de imputação
?mice::complete
total_data <- complete(regra_imputacao, 1)
View(total_data)

# Junta novamente as variáveis categóricas
dataset_clientes_final <- cbind(total_data, dataset_clientes[,c(fac_col)])
View(dataset_clientes_final)

# Dimensões
dim(dataset_clientes_final)

# Tipos de dados
str(dataset_clientes_final)
str(dataset_clientes_final$gender)

# Checando valores missing
sapply(dataset_clientes_final, function(x)sum(is.na(x)))
sum(is.na(dataset_clientes_final))
sum(is.na(dataset_clientes))

# Variável target como fator
dataset_clientes_final$Customer_cat <- as.factor(dataset_clientes_final$Customer_cat)
str(dataset_clientes_final$Customer_cat)

# Dividindo randomicamente o dataset em 80% para dados de treino e 20% para dados de teste

# Seed para reproduzir os mesmos resultados
set.seed(100)

# Índice de divisão dos dados
indice_divide_dados <- sample(x = nrow(dataset_clientes_final),
                              size = 0.8 * nrow(dataset_clientes_final),
                              replace = FALSE)
View(indice_divide_dados)

# Aplicando o índice
dados_treino <- dataset_clientes_final[indice_divide_dados,]
dados_teste <- dataset_clientes_final[-indice_divide_dados,]

View(dados_treino)
View(dados_teste)

# Checando o balanceamento de classe da variável target
prop.table(table(dados_treino$Customer_cat)) * 100

# Podemos ver que os dados apresentam um desequilíbrio alto com:
# 2% high_spend_cust, 30% low_spend_cust enquanto a maioria de 68% é medium_spent_cust
# Vamos balancear a classe usando Oversampling com SMOTE.

# Balanceamento de Classe com SMOTE
# Oversampling x Undersampling

# Seed
set.seed(301)

# Pacote
install.packages("DMwR")
library(DMwR)

# SMOTE - Synthetic Minority Oversampling Technique
?SMOTE
dados_treino_balanceados <- SMOTE(Customer_cat ~ ., dados_treino, perc.over = 3000, perc.under = 200)

# Checando o balanceamento de classe da variável target
prop.table(table(dados_treino_balanceados$Customer_cat)) * 100

# Salvando os datasets após o pré-processamento
class(dados_treino_balanceados)
class(dados_teste)

write.csv(dados_treino_balanceados, "dados/dados_treino_balanceados.csv")
write.csv(dados_teste, "dados/dados_teste.csv")

dim(dados_treino_balanceados)
dim(dados_teste)

View(dados_treino_balanceados)
View(dados_teste)

sum(is.na(dados_treino_balanceados))
sum(is.na(dados_teste))
sapply(dados_teste, function(x)sum(is.na(x)))
