# Load necessary libraries
library(tidyverse)
library(factoextra)

# Step 1: Load and scale the dataset
task.df <- read_csv("csFiles-BU/BostonUniversityCS/CS699-BU/hw9_p5.csv")
scaled_df <- scale(task.df)

# Step 2: Run fviz_nbclust with WSS method
set.seed(31)
wss_plot <- fviz_nbclust(scaled_df, kmeans, method = "wss")

# Step 3: Show all 10 WSS values
wss_values <- wss_plot$data$y
print(wss_values)

# Step 4: Plot WSS-k graph
print(wss_plot)

# Step 5: Silhouette method
sil_plot <- fviz_nbclust(scaled_df, kmeans, method = "silhouette")
print(sil_plot)

# Step 6: Run k-means with 3 clusters
set.seed(31)
k3 <- kmeans(scaled_df, centers = 3, nstart = 25)

# Step 7: Add cluster labels to the original (unscaled) data
original_data <- read_csv("csFiles-BU/BostonUniversityCS/CS699-BU/hw9_p5.csv")
original_data$Cluster <- as.factor(k3$cluster)

# Step 8: Create the cluster profile using dplyr
profile <- original_data %>%
  group_by(Cluster) %>%
  summarise(
    Age_mean = mean(`Age in Years`),
    Age_max = max(`Age in Years`),
    Age_min = min(`Age in Years`),
    Years_Current_Employer_mean = mean(`Years at Current Employer`),
    Years_Current_Employer_max = max(`Years at Current Employer`),
    Years_Current_Employer_min = min(`Years at Current Employer`),
    Years_Current_Position_mean = mean(`Years in Current Position`),
    Years_Current_Position_max = max(`Years in Current Position`),
    Years_Current_Position_min = min(`Years in Current Position`),
    Salary_mean = mean(Salary),
    Salary_max = max(Salary),
    Salary_min = min(Salary)
  )

# Step 9: Restructure the profile table to match the desired format
formatted_profile <- tibble(
  Metric = c(
    "Age mean", "Age max", "Age min",
    "Years_Current_Employer mean", "Years_Current_Employer max", "Years_Current_Employer min",
    "Years_Current_Position mean", "Years_Current_Position max", "Years_Current_Position min",
    "Salary mean", "Salary max", "Salary min"
  ),
  Cluster1 = c(
    profile$Age_mean[1], profile$Age_max[1], profile$Age_min[1],
    profile$Years_Current_Employer_mean[1], profile$Years_Current_Employer_max[1], profile$Years_Current_Employer_min[1],
    profile$Years_Current_Position_mean[1], profile$Years_Current_Position_max[1], profile$Years_Current_Position_min[1],
    profile$Salary_mean[1], profile$Salary_max[1], profile$Salary_min[1]
  ),
  Cluster2 = c(
    profile$Age_mean[2], profile$Age_max[2], profile$Age_min[2],
    profile$Years_Current_Employer_mean[2], profile$Years_Current_Employer_max[2], profile$Years_Current_Employer_min[2],
    profile$Years_Current_Position_mean[2], profile$Years_Current_Position_max[2], profile$Years_Current_Position_min[2],
    profile$Salary_mean[2], profile$Salary_max[2], profile$Salary_min[2]
  ),
  Cluster3 = c(
    profile$Age_mean[3], profile$Age_max[3], profile$Age_min[3],
    profile$Years_Current_Employer_mean[3], profile$Years_Current_Employer_max[3], profile$Years_Current_Employer_min[3],
    profile$Years_Current_Position_mean[3], profile$Years_Current_Position_max[3], profile$Years_Current_Position_min[3],
    profile$Salary_mean[3], profile$Salary_max[3], profile$Salary_min[3]
  )
)

# Step 10: Print the formatted profile
print(formatted_profile, n = Inf)
