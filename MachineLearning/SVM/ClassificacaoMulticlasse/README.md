# Multiclass Classification with SVM — Credit Card Spending Prediction

Predict customer credit card spending in 3 categories using Support Vector Machine (SVM) with multi-class strategies in R.

## Business Problem

Identifying and classifying customers based on their spending behavior is a key area in customer relationship management and credit card marketing. This project uses SVM to segment customers into 3 spending categories based on demographic and financial data.

## Dataset

`data/credit_cards.csv` — Contains customer information including demographic and spending features.

## Project Structure

```
multiclass_classification/
├── data/
│   ├── credit_cards.csv          # Original dataset
│   ├── test_data.csv             # Test set
│   ├── balanced_train_data.csv   # Balanced training set
│   ├── new_customers.csv         # New customers for prediction
│   └── final_results.csv        # Model predictions
├── 1_exploratory_analysis.R      # Exploratory Data Analysis
├── 2_preprocessing.R             # Data preprocessing
├── 3_predictive_modeling.R       # SVM model training and evaluation
└── README.md
```

## Workflow

### 1. Exploratory Data Analysis (`1_exploratory_analysis.R`)
- Check for missing values
- Analyze target variable balance
- Visual analysis (charts and plots)

### 2. Preprocessing (`2_preprocessing.R`)
- Transform categorical features to numeric
- Apply PMM (Predictive Mean Matching) for missing value imputation
- Transform the target variable into 3 categories
- Balance the dataset

### 3. Predictive Modeling (`3_predictive_modeling.R`)
- Train SVM model with linear and radial kernels
- Hyperparameter tuning (cost, gamma)
- Model evaluation: confusion matrix, accuracy, classification report
- Generate predictions for new customers

## Technologies

- **Language:** R
- **Packages:** `e1071`, `caret`, `mice`, `ROSE`, `ggplot2`
- **Tools:** RStudio

## How to Run

1. Place the dataset in the `data/` folder.
2. Open RStudio and set the working directory to this folder.
3. Run the scripts in order: `1_exploratory_analysis.R` → `2_preprocessing.R` → `3_predictive_modeling.R`.
