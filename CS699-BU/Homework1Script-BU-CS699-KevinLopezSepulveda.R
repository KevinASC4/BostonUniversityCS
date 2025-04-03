# Load necessary library
if (!require(proxy)) {
  install.packages("proxy")
}
library(proxy)
# Problem 1: Compute distances using symmetric and asymmetric attributes
O1_bin <- c("P", "N", "P", "P", "N", "P", "N")
O2_bin <- c("P", "N", "N", "P", "N", "N", "P")

# Hamming Distance (Symmetric attributes)
hamming_distance <- sum(O1_bin != O2_bin)

# Asymmetric Distance (only positive mismatches matter)
asymmetric_distance <- sum(O1_bin[O1_bin != O2_bin] == "P")

cat("1. Hamming Distance (Symmetric):", hamming_distance, "\n")
cat("2. Asymmetric Distance (P more important than N):", asymmetric_distance, "\n\n")

# Problem 2: Compute Euclidean distance with ordinal attributes

rank_map <- list(A1 = c(1, 5),    # Numeric: 1 to 5
                 A2 = c(1, 3),    # Ordinal: First (1) to Third (3)
                 A3 = c(1, 3),    # Ordinal: Bronze (1) to Gold (3)
                 A4 = c(1, 4))    # Ordinal: Small (1) to XLarge (4)

# Normalize function
normalize <- function(value, min_val, max_val) {
  return((value - min_val) / (max_val - min_val))
}

# Convert attributes to numeric ranks
O1_ord <- c(normalize(1, 1, 5),   # A1: 1
            normalize(2, 1, 3),   # A2: Second
            normalize(3, 1, 3),   # A3: Gold
            normalize(1, 1, 4))   # A4: Small

O2_ord <- c(normalize(4, 1, 5),   # A1: 4
            normalize(3, 1, 3),   # A2: Third
            normalize(2, 1, 3),   # A3: Silver
            normalize(3, 1, 4))   # A4: Large

# Compute Euclidean distance
euclidean_distance <- function(a, b) {
  return(sqrt(sum((a - b)^2)))
}

dist_O1_O2 <- euclidean_distance(O1_ord, O2_ord)

cat("Euclidean Distance between O1 and O2:", dist_O1_O2, "\n\n")

# Problem 3: Compute cosine similarity between objects

O1 <- c(1, 2, 4, 1, 3, 1, 3, 1, 2, 2)
O2 <- c(2, 2, 3, 5, 0, 4, 0, 3, 5, 2)
O3 <- c(2, 0, 4, 2, 2, 3, 2, 1, 3, 4)

# Cosine Similarity function
cosine_similarity <- function(a, b) {
  return(sum(a * b) / (sqrt(sum(a^2)) * sqrt(sum(b^2))))
}

# Compute similarities
cos_O1_O2 <- cosine_similarity(O1, O2)
cos_O1_O3 <- cosine_similarity(O1, O3)

cat("Cosine Similarity (O1, O2):", cos_O1_O2, "\n")
cat("Cosine Similarity (O1, O3):", cos_O1_O3, "\n")

if (cos_O1_O2 > cos_O1_O3) {
  cat("O1 is closer to O2\n\n")
} else {
  cat("O1 is closer to O3\n\n")
}

# Problem 4: Compute distance using mixed attributes

# Create the data frame with the given attributes
data <- data.frame(
  A1 = c(19, 42, 28, 35, 63, 27, 82, 36, 12),           # Numeric
  A2 = c(1, 1, 0, 0, 1, 0, 1, 1, 0),                    # Symmetric binary
  A3 = as.factor(c('No', 'Yes', 'No', 'Yes', 'No', 'Yes', 'No', 'No', 'Yes')), # Symmetric binary
  A4 = as.factor(c('No', 'No', 'Yes', 'No', 'No', 'No', 'Yes', 'No', 'No')), # Asymmetric binary
  A5 = as.factor(c('Yes', 'Yes', 'No', 'No', 'No', 'No', 'No', 'Yes', 'Yes')), # Asymmetric binary
  A6 = as.factor(c('Low', 'High', 'Low', 'Middle', 'High', 'High', 'Low', 'High', 'High')), # Categorical
  A7 = factor(c('mild', 'cold', 'hot', 'mild', 'hot', 'mild', 'cool', 'mild', 'hot'), 
              levels = c('cold', 'cool', 'mild', 'hot'), ordered = TRUE) # Ordinal
)


# Function to calculate Gower's distance
gower_distance <- function(data) {
  
  # Compute Gower's distance
  dist_matrix <- dist(data, method = "Gower")
  
  return(as.matrix(dist_matrix))
}

# Calculate Gower's distance
distance_matrix <- gower_distance(data)

# Extract distances between O1 and O2, and O1 and O3
d_O1_O2 <- distance_matrix[1, 2]
d_O1_O3 <- distance_matrix[1, 3]

# Print the distances
cat("Distance between O1 and O2: d(O1, O2) =", d_O1_O2, "\n")
cat("Distance between O1 and O3: d(O1, O3) =", d_O1_O3, "\n")

# Determine which object O1 is closer to
if (d_O1_O2 < d_O1_O3) {
  cat("O1 is closer to O2.\n")
} else if (d_O1_O2 > d_O1_O3) {
  cat("O1 is closer to O3.\n")
} else {
  cat("O1 is equidistant to O2 and O3.\n")
}

