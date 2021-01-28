# Machine Learning
Repositório de projetos em Machine Learning com diferentes algoritmos

## Clustering
### K-Means - Segmentação de Consumidores
Encontrar segmentos de consumidores para campanhas personalizadas de Marketing pelo método de clusterização
        
        Análise Exploratória
            Verifica a existência de valores missing
            Análise visual (gráficos)
        Pré-processamento
            Padroniza as variáveis na mesma escala
            Avalia a tendência de cluster com a estatística Hopkins para o conjunto de dados
        Modelagem Preditiva
            Usa o pacote NbClust para determinar o número de clusters no conjunto de dados
            Cria modelo K-Means e faz análise de clusters

## SVM
### Classificação Multiclasse
Prever gastos com cartão de crédito em 3 categorias  
Falta fazer redução de dimensionalidade e seleção de variáveis para tentar melhorar as métricas de avaliação do modelo
    
        Análise Exploratória
            Verifica valores missing
            Verifica o balanceamento da variável target
            Análise visual (gráficos)
        Pré-processamento
            Transforma variáveis categóricas para o tipo fator
            Aplica imputação em valores missing pelo método PMM (Predictive Mean Matching) (mice::mice())
            Transforma a variável target para o tipo fator
            Divide o dataset em dados de treino e teste (80/20)
            Faz o balanceamento de classe da variável target (DMwR::SMOTE)
        Modelagem Preditiva
            Transforma a variável target em valor numérico
            1ª versão do modelo SVM - Versão Padrão com Kernel Radial (RBF)
            2ª versão do modelo SVM - Versão com Kernel Linear e GridSearch
            3ª versão do modelo SVM - Versão com Kernel RBF e Otimização no Parâmetro Gamma
            4ª versão do modelo SVM - Versão com Kernel Polinomial
            Salva e carrega o modelo escolhido (saveRDS()/readRDS())
            Faz previsões com novos dados

### Mini-Projeto - Prevendo a intenção de compra de usuários de E-Comerce
Avaliar quais atributos influenciam um usuário na compra de produtos online e construir um modelo preditivo para realizar previsões de compras futuras

        Análise Exploratória
            Verifica e remove valores missing
            Verifica valores únicos (nunique())
            Divide os dados em variáveis contínuas e categóricas. Trata todas as variáveis com menos de 30 entradas únicas como categóricas
            Boxplot das variáveis contínuas: parecem extremamente distorcidas. Aplica-se transformação de log para melhor visualização
            Matriz de correlação entre variáveis contínuas
            Visualização de gráficos (seaborn::countplot) das variáveis categóricas para analisar como a variável de destino é influenciada por elas
        Pré-processamento
            Label encoding (sklearn.preprocessing::LabelEncoder.fit_transform())
            Balanceamento de classe - Oversampling (imblearn::SMOTE)
            Divisão em dados de treino e teste (train_test_split())
        Modelagem Preditiva 
            Modelo base com Kernel Linear
            Modelo com Kernel Linear e dados padronizados (Scaled) 
                Redução do tempo de treinamento de 4003 para 7 segundos
            Otimização de hiperparâmetros com Grid Search e Kernel RBF
            Otimização de hiperparâmetros com Grid Search e Kernel Polinomial
            Faz previsões com novos registros padronizados usando o melhor modelo treinado

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
            













