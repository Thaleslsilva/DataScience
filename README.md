# 📊 Data Science Portfolio

> A curated collection of Data Science projects covering Machine Learning, Natural Language Processing, Social Network Analysis, and Data Visualization.

[![Python](https://img.shields.io/badge/Python-3776AB?style=flat-square&logo=python&logoColor=white)](https://python.org)
[![R](https://img.shields.io/badge/R-276DC3?style=flat-square&logo=r&logoColor=white)](https://r-project.org)
[![Jupyter](https://img.shields.io/badge/Jupyter-F37626?style=flat-square&logo=jupyter&logoColor=white)](https://jupyter.org)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=flat-square)](LICENSE)

---

## 📁 Repository Structure

```
DataScience/
│
├── MachineLearning/
│   ├── Clustering/             # K-Means consumer segmentation (R)
│   ├── PLN/                    # NLP: Collocations, BOW, TF-IDF, Word2Vec, GloVe, CBOW (Python)
│   ├── SVM/                    # Support Vector Machines: multiclass & e-commerce (R & Python)
│   └── Sistemas_Recomendacao/  # Recommendation systems (Python)
│
├── SocialNetworkAnalytics/
│   └── Twitter/                # Twitter social network analysis (R)
│
└── VisualizacaoDados/
    ├── DashboardDesign/        # Interactive dashboard design (R Shiny)
    ├── Metodos_Visualizacao/   # Visualization methods and techniques (R)
    └── Visualizacao_D3.js/     # Data visualization with D3.js (JavaScript)
```

---

## 🤖 Machine Learning

### 📌 Clustering — Consumer Segmentation with K-Means
> **Language:** R | **Algorithm:** K-Means

Identify consumer segments for personalized marketing campaigns using clustering techniques.

**Pipeline:**
- Exploratory Data Analysis (missing values, visual analysis)
- Preprocessing: variable standardization and Hopkins statistic for cluster tendency
- Modeling: NbClust for optimal cluster number selection + K-Means cluster analysis

---

### 📌 NLP (Natural Language Processing)
> **Language:** Python | **Libraries:** NLTK, PyTorch, SciPy

A series of NLP projects covering modern text analysis techniques:

| Project | Description | Technique |
|---------|-------------|-----------|
| Hotel Reviews Collocations | Find relevant bigrams/trigrams explaining hotel ratings | PMI, t-test, Chi-square |
| Language Classifier | Classify sentence language from trained model | Bag of Words + PyTorch |
| Keyword Identifier | Identify most relevant words in a book | TF-IDF |
| Sentence Predictor | AI for legal text sentence prediction | CBOW |
| Word Similarity Search | Find similar words using word vectors | GloVe |
| Word Context Predictor | Word prediction with PCA visualization | Word2Vec |

---

### 📌 SVM — Support Vector Machines
> **Language:** R & Python | **Libraries:** e1071, scikit-learn

**Project 1 — Multiclass Credit Card Spending Classification (R)**
- Missing value imputation with PMM (mice)
- Class balancing with SMOTE (DMwR)
- Comparison of Radial, Linear, and Polynomial kernels with GridSearch

**Project 2 — E-Commerce Purchase Intent Prediction (Python)**
- Label encoding and SMOTE oversampling
- Training time optimization: from 4,003s → 7s
- Hyperparameter tuning with GridSearch (RBF and Polynomial kernels)

---

### 📌 Recommendation Systems
> **Language:** Python | **Notebook:** Jupyter

Building recommendation engines to suggest items based on user behavior and preferences.

---

## 🌐 Social Network Analytics

### 📌 Twitter Network Analysis
> **Language:** R

Social network analysis of Twitter data to explore connections, influence, and community structure.

---

## 📈 Data Visualization

### 📌 Dashboard Design
> **Language:** R (Shiny)

Interactive dashboards built with R Shiny for exploratory data analysis and reporting.

### 📌 Visualization Methods
> **Language:** R (ggplot2, plotly)

A collection of visualization techniques including statistical plots, heatmaps, and interactive charts.

### 📌 D3.js Visualizations
> **Language:** JavaScript (D3.js)

Dynamic and interactive data visualizations built with D3.js, including bar charts and force-directed graphs.

---

## 🛠️ Tech Stack

| Area | Tools |
|------|-------|
| Languages | Python, R, JavaScript |
| ML & DL | scikit-learn, PyTorch, e1071, DMwR |
| NLP | NLTK, SciPy |
| Visualization | ggplot2, plotly, D3.js, R Shiny |
| Notebooks | Jupyter Notebook, R Markdown |
| Data Handling | pandas, dplyr, mice |

---

## 🚀 Getting Started

### Prerequisites

- Python 3.7+ or R 4.0+
- Jupyter Notebook

### Running a Project

```bash
# Clone the repository
git clone https://github.com/Thaleslsilva/DataScience.git
cd DataScience

# Navigate to a project folder, e.g.:
cd MachineLearning/SVM

# Open the notebook
jupyter notebook
```

---

## 📬 Contact

**Thales de Lima Silva**

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=flat-square&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/thales-lima-silva-77a99378/)
[![Gmail](https://img.shields.io/badge/Gmail-D14836?style=flat-square&logo=gmail&logoColor=white)](mailto:medvet21@gmail.com)
[![GitHub](https://img.shields.io/badge/GitHub-181717?style=flat-square&logo=github&logoColor=white)](https://github.com/Thaleslsilva)

---

*Suggestions and contributions are welcome! Feel free to open an issue or submit a pull request.*
