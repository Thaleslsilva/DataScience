# Social Network Analytics - Twitter
# Comparando dados de diferentes temas

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome
setwd("Z:/Dropbox/DSA/Business-Analytics/R/Cap08/Twitter")
getwd()

# Carrega biblioteca com functions auxiliares e autenticação
source('utils.R')
source('autentication.R')

# Instalando os pacotes
#install.packages(c("devtools", "httr"))
#install.packages(c("tm", "wordcloud", "RColorBrewer"))
#install.packages(c("twitteR", "ROAuth"))

# Carregando os pacotes
library(devtools)
library(twitteR)
library(ROAuth)
library(tm)
library(wordcloud)
library(RColorBrewer)
library(stringr)

# Coletando os tweets
?searchTwitter
bigdata_tweets = searchTwitter("BigData", n = 100, lang = "pt")
datascience_tweets = searchTwitter("DataScience", n = 100, lang = "pt")
#dsa_Tweets = userTimeline(getUser('dsacademybr'), n = 100)

# Print
head(bigdata_tweets)
class(bigdata_tweets)
head(datascience_tweets)
class(datascience_tweets)

# Convertendo os tweets para texto
textos_bigdata = sapply(bigdata_tweets, function(x) x$getText())
head(bigdata_tweets)
textos_datascience = sapply(datascience_tweets, function(x) x$getText())
textos_bigdata[1:10]
class(textos_bigdata)

# Limpeza dos tweets
textos_bigdata_limpo = textos_bigdata
textos_bigdata_limpo <- limpaTweets(textos_bigdata_limpo)
head(textos_bigdata_limpo)
names(textos_bigdata_limpo) = NULL
textos_bigdata_limpo = textos_bigdata_limpo[textos_bigdata_limpo != ""]
textos_bigdata_limpo[1:10]
class(textos_bigdata_limpo)

textos_datascience_limpo = textos_datascience
textos_datascience_limpo <- limpaTweets(textos_datascience_limpo)
names(textos_datascience_limpo) = NULL
textos_datascience_limpo = textos_datascience_limpo[textos_datascience_limpo != ""]
textos_datascience_limpo[1:10]

# Converte para Corpus
tweetcorpus_bigdata <- Corpus(VectorSource(textos_bigdata_limpo))
tweetcorpus_bigdata <- limpaCorpus(tweetcorpus_bigdata)
tweetcorpus_datascience <- Corpus(VectorSource(textos_datascience_limpo))
tweetcorpus_datascience <- limpaCorpus(tweetcorpus_datascience)

# Converte o texto para a matriz de termos
termo_por_documento_bigdata     = as.matrix(TermDocumentMatrix(tweetcorpus_bigdata), control = list(stopwords = c(stopwords("portuguese"))))
termo_por_documento_datascience = as.matrix(TermDocumentMatrix(tweetcorpus_datascience), control = list(stopwords = c(stopwords("portuguese"))))

# Verifica os primeiros 10 termos (linhas) com os primeiros 10 documentos (colunas)
termo_por_documento_bigdata[1:10,1:10]
termo_por_documento_datascience[1:10,1:10]

# Calcula a frequência de cada termo ao somar cada linha e coloca em ordem decrescente
frequencia_dos_termos_bigdata = sort(rowSums(termo_por_documento_bigdata), decreasing = TRUE) 
head(frequencia_dos_termos_bigdata)
frequencia_dos_termos_datascience = sort(rowSums(termo_por_documento_datascience), decreasing = TRUE) 
head(frequencia_dos_termos_datascience)

# Cria um dataframe com o termo (palavra) e sua respectiva frequência 
df_bigdata = data.frame(termo = names(frequencia_dos_termos_bigdata), frequencia = frequencia_dos_termos_bigdata) 
df_datascience = data.frame(termo = names(frequencia_dos_termos_datascience), frequencia = frequencia_dos_termos_datascience) 

# Remove o termo mais frequente
df_bigdata = df_bigdata[-1,]
class(df_bigdata)
df_datascience = df_datascience[-1,]
class(df_datascience)

# Desenha a nuvem de palavras
wordcloud(df_bigdata$termo, 
          df_bigdata$frequencia, 
          max.words = 100,
          min.freq = 2,
          scale = c(3,.5),
          random.order = FALSE, 
          colors = brewer.pal(8, "Dark2"))

wordcloud(df_datascience$termo, 
          df_datascience$frequencia, 
          max.words = 100,
          min.freq = 3,
          scale = c(3,.5),
          random.order = FALSE, 
          colors = brewer.pal(8, "Dark2"))

# Merge dos dataframes
df_merge <- merge(df_bigdata, df_datascience, by = "termo")
head(df_merge)
df_merge$freq_total <- df_merge$frequencia.x + df_merge$frequencia.y 
head(df_merge)

# Wordcloud do novo dataframe
wordcloud(df_merge$termo, 
          df_merge$freq_total, 
          max.words = 100,
          min.freq = 2,
          scale = c(3,.5),
          random.order = FALSE, 
          colors = brewer.pal(8, "Dark2"))











