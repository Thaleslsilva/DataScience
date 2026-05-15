##############################################################################
#
# CONSUMER SEGMENTATION FOR CUSTOMIZED MARKETING CAMPAIGNS
#
# Objective: Identify consumer segments for personalized marketing campaigns
#            using K-Means clustering.
#
# Reference: https://cran.r-project.org/web/views/Cluster.html
#
##############################################################################

# Set the working directory
getwd()
setwd("path/to/your/MachineLearning/Clustering")

# --- Install and load required packages ---
install.packages("factoextra")
install.packages("cluster")
install.packages("fpc")
install.packages("NbClust")
install.packages("clValid")
install.packages("clustertend")

library(factoextra)
library(cluster)
library(fpc)
library(NbClust)
library(clValid)
library(magrittr)
library(clustertend)

# --- Load the dataset ---
customer_data_v1 <- read.csv("customer_data.csv")
str(customer_data_v1)
names(customer_data_v1)
View(customer_data_v1)
summary(customer_data_v1)

# EXPLORATORY DATA ANALYSIS ###################################################

# Proportion table by gender
gender_table <- table(customer_data_v1$Gender)
gender_table
table(customer_data_v1$Gender, useNA = "ifany")

# Check for missing values in the Age column
summary(customer_data_v1$Age)

# Calculate mean age
mean(customer_data_v1$Age)

# Bar chart: proportion of customers by gender
barplot(gender_table,
        main = "Customer Gender Distribution",
        ylab  = "Count",
        xlab  = "Gender",
        col   = rainbow(2),
        legend = rownames(gender_table))

# Histogram: age frequency distribution
hist(customer_data_v1$Age,
     col    = "blue",
     main   = "Age Distribution",
     xlab   = "Age",
     ylab   = "Frequency",
     labels = TRUE)

# Boxplot: descriptive analysis of age
boxplot(customer_data_v1$Age,
        col  = 3,
        main = "Boxplot: Age Descriptive Analysis")

# Histogram: monthly salary frequency distribution
names(customer_data_v1)
summary(customer_data_v1$Monthly_Salary_K)
hist(customer_data_v1$Monthly_Salary_K,
     col    = "#660033",
     main   = "Monthly Salary Histogram",
     xlab   = "Monthly Salary (thousands)",
     ylab   = "Frequency",
     labels = TRUE)

# Spending score analysis
summary(customer_data_v1$Spending_Score)

boxplot(customer_data_v1$Spending_Score,
        horizontal = TRUE,
        col  = "#990000",
        main = "Boxplot: Customer Spending Score")

hist(customer_data_v1$Spending_Score,
     main   = "Spending Score Histogram",
     xlab   = "Spending Score",
     ylab   = "Frequency",
     col    = "#6600cc",
     labels = TRUE)

# DATA PREPROCESSING ##########################################################

# Remove non-numeric columns (ID, Gender)
customer_data_v2 <- customer_data_v1[, -c(1, 2)]
head(customer_data_v2)

# Standardize variables to the same scale
customer_data_scaled <- scale(customer_data_v2)
head(customer_data_scaled)

# Evaluate cluster tendency using the Hopkins statistic
# Values > 0.5 indicate the dataset is NOT clusterable
# Values < 0.5 indicate the dataset IS clusterable
# The closer to 0, the better
hopkins_stat <- hopkins(customer_data_scaled, n = nrow(customer_data_scaled) - 1)
cat("Hopkins statistic:", hopkins_stat$H, "\n")

# PREDICTIVE MODELING #########################################################

# Determine the optimal number of clusters using NbClust
nb_result <- NbClust(customer_data_scaled,
                     distance = "euclidean",
                     min.nc   = 2,
                     max.nc   = 10,
                     method   = "complete",
                     index    = "all")
fviz_nbclust(nb_result)

# Fit K-Means model with the optimal number of clusters (e.g., k = 3)
set.seed(42)
kmeans_model <- kmeans(customer_data_scaled,
                       centers = 3,
                       nstart  = 25)
print(kmeans_model)

# Cluster visualization
fviz_cluster(kmeans_model, data = customer_data_scaled,
             palette      = "Set2",
             geom         = "point",
             ellipse.type = "convex",
             ggtheme      = theme_bw(),
             main         = "K-Means Cluster Plot")

# Append cluster labels to the original data
customer_data_v1$Cluster <- kmeans_model$cluster
head(customer_data_v1)

# Cluster summary statistics
aggregate(customer_data_v2, by = list(Cluster = kmeans_model$cluster), FUN = mean)
