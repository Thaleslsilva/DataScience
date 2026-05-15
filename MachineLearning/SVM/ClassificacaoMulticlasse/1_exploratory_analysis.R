# Multiclass Classification with SVM - Predicting Credit Card Spending in 3 Categories
# Step 1: Exploratory Data Analysis

# Set the working directory
getwd()
setwd("path/to/your/MachineLearning/SVM/multiclass_classification")

# --- Install and load required packages ---
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

# --- Load the dataset ---
credit_card_data <- read.csv("data/credit_cards.csv")
View(credit_card_data)

#### EXPLORATORY DATA ANALYSIS ####
summary(credit_card_data)
summary(credit_card_data$card2spent)

# Identify numeric columns
numeric_cols <- sapply(credit_card_data, is.numeric)
numeric_data <- credit_card_data[, numeric_cols]

# Statistical summary of numeric columns
summary(numeric_data)

# Check for missing values
na_count <- sapply(credit_card_data, function(x) sum(is.na(x)))
cat("Missing values per column:\n")
print(na_count)

# Proportion of missing values
na_proportion <- sapply(credit_card_data, function(x) mean(is.na(x)))
cat("\nProportion of missing values per column:\n")
print(round(na_proportion, 4))

# Distribution of the target variable (card2spent)
table(credit_card_data$card2spent)

# Histogram of key variables
hist(credit_card_data$card2spent,
     main = "Target Variable Distribution: Card Spending",
     xlab = "Card 2 Spending",
     col  = "steelblue",
     border = "white")
