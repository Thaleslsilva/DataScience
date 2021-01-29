## Processamento de Linguagem Natural (PLN)
### Collocations e Processamento de Comentários de Avaliações de Hotéis 
Buscar as Collocations mais relevantes que ajudam a explicar as avaliações, dado um conjunto de textos de avaliações (comentários) de hotéis

        Preparação e Limpeza dos Dados
            Remove caracteres non-ascii (ex.: emojis)
            Cria dicionário com as stopwords em todos os idiomas
            Cria função para detectar o idioma predominante com base nas stopwords
            Cria função para limpar (pontuação) e lematizar os comentários
            Aplica tokenização 
        Estratégia 1 - Buscando Bigramas e Trigramas mais Relevantes nos Comentários por Frequência
            Cria métricas de associação de bigramas e trigramas
            Cria buscador de bigramas e trigramas nos tokens
            Calcula frequências e cria tabela
            Filtra bigramas e trigramas contendo adjetivos/substantivos e remove stopwords
        Estratégia 2 - Buscando Bigramas e Trigramas mais Relevantes nos Comentários por Pointwise Mutual Information (PMI)
            Filtra bigramas e trigramas com 20 ou mais ocorrências
            O score PMI mede a probabilidade com que as palavras co-ocorrem mais do que se fossem independentes. Muito sensível à combinação rara de palavras
        Estratégia 3 - Buscando Bigramas e Trigramas mais Relevantes nos Comentários por Teste t
            Ao aplicar o Teste t rejeitamos ou não a H0 através do cálculo de um score e assim representamos os Collocations mais relevantes no texto
            Filtra bigramas e trigramas contendo adjetivos/substantivos e remove stopwords
        Estratégia 4 - Buscando Bigramas e Trigramas mais Relevantes nos Comentários por Teste do Qui-quadrado
            O teste do qui-quadrado é uma alternativa ao teste t. Este assume na hipótese nula que as palavras são independentes
        Comparação e Resultado Final
            Extrai os 10 Collocations bigramas e trigramas mais relevantes de acordo com cada um dos 4 métodos usados
            Cria dataframe com todos os resultados
            Visualiza a tabela - Padrão CSS
            
### Bag of Words e PyTorch - Classificação de Idiomas de Sentenças
Classifica o idioma de uma sentença com base em um modelo treinado

        Preparação dos Dados
            Carrega dados de treino e teste
            Prepara o dicionário do vocabulário
        Construção do Modelo
            Classe para o modelo BOW de classificação
            Função para criar o vetor BOW necessário para o treinamento
            Função para criar a variável target
            Cria o modelo, função de perda e otimizador
        Treinamento do Modelo
        Previsões e Avaliação do Modelo
            Função para previsões
        Previsões com Novos Dados
        
### TF-IDF - Identificação de Palavras
Identifica as palavras mais relevantes em um livro

        Preparação dos Dados
            Carrega dados e cria listas para receber as frases e as palavras do texto
            Aplica tokenização 
            Converte a lista de palavras em um conjunto (set)
        Frequência do Termo
            Cria e aplica função para calcular a TF
            Cria um corpus BOW 
            Cria e filtra dicionário
        Frequência Inversa
            Cria e aplica função para calcular a IDF
        TF-IDF (Gera Indicador)
        
### CBOW - Continuous Bag of Words Model
Inteligência artificial para previsão de sentenças em embargos de declaração

        Preparação dos Dados
            Carrega e limpa texto
            Cria corpus e dicionários para TF-IDF
            Loop pelo texto par extrair sentenças e palavras
        Construção do Modelo CBoW
            Define o comprimento de cada embedding
            Cria classe para o modelo
            Cria modelo, função de custo e backpropagation
            Cria função para griar o vetor de sentenças, necessário para treinar o modelo
            Converte o dicionário de palavras em um vetor de sentenças
        Treinamento do Modelo
            Loop por 150 passadas (epochs) de treinamento
                Inicializa os gradientes com zero
                Cria o vetor de sentença com os dados de entrada
                Usa o vetor para fazer previsões com o modelo e retorna as probabilidades
                Calcula o erro do modelo
                Chama o método de backpropagation para calcular o gradiente da derivada
                Otimiza os pesos do modelo e segue para a próxima passada
                Atualiza o erro da época
            Cria funções para obter previsão e prever sentenças
        Previsões com o Modelo

### GloVe - Global Vectors
Buscador de palavras em texto por similaridade

        Carregando e Processando os Dados
            Carrega texto
            Aplica tokenização
        Criando Vocabulário
            Cria dicionários para mapear as palavras aos índices e os índices às palavras
            Contexto de dez palavras à esquerda e dez palavras à direita
            Cria matriz de co-ocorrência e preenche com dicionários de mapeamento criados anteriormente
            Transposta da matriz de co-ocorrências                    
        Criando Modelo
            Define tamanho da embedding e hiperparâmetros
            Cria classe com funções para o modelo
            Cria função para gerar um bacth de palavras
        Treinamento do Modelo
            Cria e executa a função de treinamento e retorna o modelo e os erros
            Cria função para o plotar o erro durante o treinamento
        Testando o Modelo: Similaridade de Palavras, analogias de palavras
            Cria funções para retornar a embedding de uma palavra e buscar a palavra mais próxima
            Gera o vetor (embedding) de uma palavra 
            Busca as palavras similares à palavra
        Analogia
            Cria função para busca de palavra por analogia
            Busca por analogia
            
### Word2Vec - Word to Vector
Previsão de palavras com base no contexto e visualização com PCA

        Preparação dos Dados
            Cria corpus e constrói vocabulário com tokenização
            Cria mapeamento das palavras aos índices e dos índices às palavras
            Contexto de dez palavras à esquerda e dez palavras à direita                   
        Construção do Modelo
            Cria função para gerar os embeddings
            Cria função para gerar os vetores, da palavra central e do contexto
            Definição dos hiperparâmetros e dos pesos da rede neural
            Treinamento
        Teste do Modelo e Redução de Dimensionalidade com PCA
            Cria o objeto para redução de dimensionalidade
            Treina o modelo PCA
            Cria funções para obter vetores de palavras nos pesos W1 e W2 (contexto e palavra central)
            Usa a função cosine() do SciPy para calcular as distâncias das outras palavras para a palavra "secreta"
            Visualiza as distâncias
