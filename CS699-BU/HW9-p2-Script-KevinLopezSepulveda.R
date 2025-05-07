# Load the dataset
data <- read.csv("csFiles-BU/BostonUniversityCS/CS699-BU/hw9_p2.csv")

# Check if there are any rows where the Items column is empty or has NA values
data <- data[!is.na(data$Items) & data$Items != "", ]

# Split the Items column into individual items (this will create a list of items per row)
item_list <- strsplit(as.character(data$Items), ", ")

# Function to calculate support of a sequence
calculate_support <- function(sequence, item_list, total_transactions) {
  count <- 0
  for (i in 1:total_transactions) {
    if (all(sequence %in% item_list[[i]])) {
      count <- count + 1
    }
  }
  support <- count / total_transactions
  return(support)
}

# Function to mine sequences of a given length
mine_sequences <- function(length, item_list, min_support) {
  # Generate all possible sequences of the given length
  all_sequences <- list()
  
  for (i in 1:length(item_list)) {
    items <- item_list[[i]]
    
    # Ensure that we don't try to create sequences longer than the available items
    if (length(items) >= length) {
      for (j in 1:(length(items) - length + 1)) {
        sequence <- items[j:(j + length - 1)]
        all_sequences <- append(all_sequences, list(sequence))
      }
    }
  }
  
  # Calculate support for each sequence
  total_transactions <- length(item_list)
  frequent_sequences <- list()
  
  for (seq in all_sequences) {
    support <- calculate_support(seq, item_list, total_transactions)
    if (support >= min_support) {
      frequent_sequences <- append(frequent_sequences, list(seq))
    }
  }
  
  return(frequent_sequences)
}

# Set minimum support threshold (40% = 0.4)
min_support <- 0.4

# Mine frequent sequences for length 1 to 4
frequent_1_sequences <- mine_sequences(1, item_list, min_support)
frequent_2_sequences <- mine_sequences(2, item_list, min_support)
frequent_3_sequences <- mine_sequences(3, item_list, min_support)
frequent_4_sequences <- mine_sequences(4, item_list, min_support)

# Print the number of frequent sequences
cat("Number of frequent 1-sequences:", length(frequent_1_sequences), "\n")
cat("Number of frequent 2-sequences:", length(frequent_2_sequences), "\n")
cat("Number of frequent 3-sequences:", length(frequent_3_sequences), "\n")
cat("Number of frequent 4-sequences:", length(frequent_4_sequences), "\n")

# Print some of the frequent 1-sequences for debugging
cat("Frequent 1-sequences:\n")
print(frequent_1_sequences)

# Function to generate induced temporal rules
generate_temporal_rules <- function(frequent_sequences) {
  # For simplicity, we'll assume each frequent sequence generates a rule for each pair of items
  rules <- list()
  
  for (seq in frequent_sequences) {
    for (i in 1:(length(seq) - 1)) {
      rule <- list(lhs = seq[i], rhs = seq[i + 1])
      rules <- append(rules, list(rule))
    }
  }
  
  return(rules)
}

# Generate induced temporal rules from frequent sequences
all_frequent_sequences <- c(frequent_1_sequences, frequent_2_sequences, frequent_3_sequences, frequent_4_sequences)
temporal_rules <- generate_temporal_rules(all_frequent_sequences)

# Print the number of temporal rules
cat("Number of induced temporal rules:", length(temporal_rules), "\n")

# Function to calculate confidence of a rule
calculate_confidence <- function(rule, item_list) {
  lhs <- rule$lhs
  rhs <- rule$rhs
  lhs_count <- sum(sapply(item_list, function(x) all(lhs %in% x)))
  rhs_count <- sum(sapply(item_list, function(x) all(rhs %in% x)))
  both_count <- sum(sapply(item_list, function(x) all(c(lhs, rhs) %in% x)))
  
  confidence <- both_count / lhs_count
  return(confidence)
}

# Function to calculate lift of a rule
calculate_lift <- function(rule, item_list) {
  lhs <- rule$lhs
  rhs <- rule$rhs
  lhs_count <- sum(sapply(item_list, function(x) all(lhs %in% x)))
  rhs_count <- sum(sapply(item_list, function(x) all(rhs %in% x)))
  total_count <- length(item_list)
  
  lift <- (lhs_count * rhs_count) / (total_count^2)
  return(lift)
}

# Calculate top 5 rules based on confidence
confidences <- sapply(temporal_rules, calculate_confidence, item_list = item_list)
top_5_confidence <- temporal_rules[order(confidences, decreasing = TRUE)[1:5]]

# Calculate top 5 rules based on lift
lifts <- sapply(temporal_rules, calculate_lift, item_list = item_list)
top_5_lift <- temporal_rules[order(lifts, decreasing = TRUE)[1:5]]

# Print top 5 rules based on confidence
cat("Top 5 rules based on confidence:\n")
for (rule in top_5_confidence) {
  cat("Rule: ", paste(rule$lhs, "=>", rule$rhs), "\n")
}

# Print top 5 rules based on lift
cat("Top 5 rules based on lift:\n")
for (rule in top_5_lift) {
  cat("Rule: ", paste(rule$lhs, "=>", rule$rhs), "\n")
}
