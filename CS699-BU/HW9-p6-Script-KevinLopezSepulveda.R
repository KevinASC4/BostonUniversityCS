# Load required libraries
library(cluster)
library(dplyr)
library(tibble)
library(ggplot2)
library(readr)

# Step 1: Load the dataset
data_p6 <- read_csv("csFiles-BU/BostonUniversityCS/CS699-BU/hw9_p6.csv")

# Step 2: Convert all character columns to factors (required for Gower distance)
data_p6 <- data_p6 %>%
  mutate(across(where(is.character), as.factor))

# Step 3: Compute the Gower distance
gower_dist <- daisy(data_p6, metric = "gower")

# Step 4: Run AGNES with different linkage methods
agnes_avg <- agnes(gower_dist, method = "average")
agnes_single <- agnes(gower_dist, method = "single")
agnes_complete <- agnes(gower_dist, method = "complete")
agnes_ward <- agnes(gower_dist, method = "ward")

# Step 5: Collect agglomerative coefficients
coefficients <- tibble(
  Method = c("Average", "Single", "Complete", "Ward"),
  Coefficient = c(
    agnes_avg$ac,
    agnes_single$ac,
    agnes_complete$ac,
    agnes_ward$ac
  )
)

# Step 6: Plot bar graph of coefficients
ggplot(coefficients, aes(x = Method, y = Coefficient, fill = Method)) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  ggtitle("Agglomerative Coefficients by Method") +
  ylab("Agglomerative Coefficient") +
  xlab("Method")

# Step 7: Re-run AGNES using the best method (let's assume Ward)
agnes_best <- agnes(gower_dist, method = "ward")

# Step 8: Cut the dendrogram into 3 clusters
cluster_assignments <- cutree(as.hclust(agnes_best), k = 3)

# Step 9: Attach clusters to the data (optional)
data_with_clusters <- data_p6 %>%
  mutate(Cluster = cluster_assignments)

# View a few rows of the data with clusters
head(data_with_clusters)
