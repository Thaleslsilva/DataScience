# Clustering

## K-Means — Consumer Segmentation

Identify consumer segments for personalized marketing campaigns using K-Means clustering.

### Description

This project applies K-Means clustering to segment customers based on demographic and behavioral data, enabling targeted marketing strategies.

### Workflow

**Exploratory Data Analysis**
- Check for missing values
- Visual analysis (charts and plots)

**Preprocessing**
- Standardize variables to the same scale
- Evaluate cluster tendency using the Hopkins statistic

**Predictive Modeling**
- Use the `NbClust` package to determine the optimal number of clusters
- Build the K-Means model and perform cluster analysis

### Technologies

- **Language:** R
- **Packages:** `factoextra`, `cluster`, `NbClust`, `clValid`, `clustertend`

### Dataset

`customer_data.csv` — Contains customer demographic and spending score data.

### How to Run

1. Open `consumer_segmentation.R` in RStudio.
2. Set your working directory to this folder.
3. Install required packages if needed.
4. Run the script sequentially.
