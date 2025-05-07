# Load the necessary libraries
# You may need to install these libraries if you haven't done so
# install.packages("dplyr") # Uncomment if you need to install dplyr
library(dplyr)

# Load the data from the specified path
data <- read.csv("csFiles-BU/BostonUniversityCS/CS699-BU/hw8_p5.csv")

# Check the data structure to ensure it loads correctly
print(head(data))  # Print the first few rows of data to inspect it

# Remove spaces from the Items column and split items by comma
data$Items <- gsub(" ", "", data$Items)  # Remove any spaces
data$Items <- strsplit(as.character(data$Items), ",")  # Split items by comma

# Set minimum support threshold
min_support_count <- ceiling(nrow(data) * 0.4)
cat("Minimum support count required:", min_support_count, "\n")  # Debug: print minimum support count

# Function to count occurrences of sequences of a given length
count_sequences <- function(data, sequence_length) {
  sequence_counts <- list()  # List to hold counts
  
  # Iterate over each row in the data
  for (i in 1:nrow(data)) {
    items <- data$Items[[i]]  # Get items for the current transaction
    
    # Debug: Print the items being processed
    cat("Processing transaction:", i, "Items:", items, "\n")
    
    # Check if there are enough items for the desired sequence length
    if (length(items) >= sequence_length) {
      # Generate combinations of the desired sequence length
      combinations <- combn(items, sequence_length, simplify = FALSE)
      
      # Count occurrences
      for (comb in combinations) {
        seq_key <- paste(sort(comb), collapse = ",")  # Create a unique key for the sequence
        if (!is.null(sequence_counts[[seq_key]])) {
          sequence_counts[[seq_key]] <- sequence_counts[[seq_key]] + 1
        } else {
          sequence_counts[[seq_key]] <- 1
        }
      }
    }
  }
  
  # Debug: Print the counts collected
  cat("Counts for sequence length", sequence_length, ":\n")
  print(sequence_counts)  # Print the entire list of counts
  
  # Filter based on minimum support
  frequent_sequences <- Filter(function(x) x >= min_support_count, sequence_counts)
  return(frequent_sequences)
}

# Count frequent sequences of different lengths
frequent_1seq <- count_sequences(data, 1)
frequent_2seq <- count_sequences(data, 2)
frequent_3seq <- count_sequences(data, 3)
frequent_4seq <- count_sequences(data, 4)

# Print results for frequent sequences
cat("Frequent 1-sequences (count):", length(frequent_1seq), "\n")
cat("Frequent 2-sequences (count):", length(frequent_2seq), "\n")
cat("Frequent 3-sequences (count):", length(frequent_3seq), "\n")
cat("Frequent 4-sequences (count):", length(frequent_4seq), "\n")

# Function to generate rules from frequent sequences
generate_rules <- function(frequent_sequences) {
  rules <- list()
  
  for (seq in names(frequent_sequences)) {
    items <- unlist(strsplit(seq, ","))
    if (length(items) > 1) {
      for (i in 1:(length(items) - 1)) {
        for (j in (i + 1):length(items)) {
          rule_key <- paste(items[i], "=>", items[j])
          rules[[rule_key]] <- frequent_sequences[seq]  # Assign the count to the rule
        }
      }
    }
  }
  
  return(rules)
}

# Generate rules based on frequent sequences
rules1 <- generate_rules(frequent_1seq)
rules2 <- generate_rules(frequent_2seq)
rules3 <- generate_rules(frequent_3seq)
rules4 <- generate_rules(frequent_4seq)

# Combine all rules into one list
all_rules <- c(rules1, rules2, rules3, rules4)

# Total number of rules generated
total_rules <- length(all_rules)
cat("Total number of induced rules:", total_rules, "\n")

# Print top 5 rules based on count (as a proxy for confidence)
if (total_rules > 0) {
  rules_confidence <- data.frame(Rule = names(all_rules), Count = unlist(all_rules))
  rules_confidence <- rules_confidence[order(-rules_confidence$Count), ]  # Sort by count
  top_confidence_rules <- head(rules_confidence, 5)
  cat("Top 5 rules based on count:\n")
  print(top_confidence_rules)
} else {
  cat("No rules generated from frequent sequences.\n")
}
