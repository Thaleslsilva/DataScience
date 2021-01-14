# Machine Learning
Repositório de projetos em Machine Learning com diferentes algoritmos

## SVM
    Classificação Multiclasse
Prever gastos com cartão de crédito em 3 categorias 
Falta fazer redução de dimensionalidade e seleção de variáveis para tentar melhorar as métricas de avaliação do modelo
    
    Mini-Projeto 2 - Prevendo a intenção de compra de usuários de E-Comerce
Avaliar quais atributos influenciam um usuário na compra de produtos online e construir um modelo preditivo para realizar previsões de compras futuras

        Análise Exploratória
            Verifica e remove valores missing;
            Verifica valores únicos (nunique());
            Divide os dados em variáveis contínuas e categóricas. Trata todas as variáveis com menos de 30 entradas únicas como categóricas;
            Boxplot das variáveis contínuas: parecem extremamente distorcidas. Aplica-se transformação de log para melhor visualização;
            Matriz de correlação entre variáveis contínuas;
            Visualização de gráficos (seaborn::countplot) das variáveis categóricas para analisar como a variável de destino é influenciada por elas;
        Pré-processamento
            Label encoding (sklearn.preprocessing::LabelEncoder.fit_transform())
            Balanceamento de classe - Oversampling (imblearn::SMOTE)
            Divisão em dados de treino e teste (train_test_split())
        Modelagem Preditiva 
