# Autenticação

library(twitteR)

# Definindo as chaves de acesso
api_key <- "xxx"
api_secret <- "xxx"
access_token <- "xxx"
access_token_secret <- "xxx"

# Autenticando no Twitter
setup_twitter_oauth(api_key, api_secret, access_token, access_token_secret)
