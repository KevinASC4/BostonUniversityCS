library(tm)
dataset <- system.file("texts", "crude", package = "tm") #

dataset.corpus <- VCorpus(DirSource(dataset), readerControl = list(reader = readReut21578XMLasPlain))

dataset.corpus

# Get the content of the 5th document
fifth_doc_content <- content(dataset.corpus[[5]])

# Count number of characters
nchar(fifth_doc_content)

v1=c(0.6, 0.3, 0.1)
v2=c(0.2, 0.7, -0.3)
v3=c(-0.9, -0.6, 0.8)

cossim <- function(A,B) { (sum(A*B))/sqrt((sum(A^2))*(sum(B^2))) } 

# Compute cosine similarities
cossim(v1, v2)  # A
cossim(v2, v3)  # B
cossim(v1, v3)  # D

# F1 Score = 2 * (Precision * Recall) / (Precision + Recall)
# Given confusion matrix values for first classification
TP1 <- 25
FP1 <- 14
FN1 <- 51

# Given confusion matrix values for second classification
TP2 <- 23
FP2 <- 22
FN2 <- 21

# Function to calculate Precision, Recall, and F1 score
calculate_f1 <- function(TP, FP, FN) {
  precision <- TP / (TP + FP)
  recall <- TP / (TP + FN)
  f1 <- 2 * (precision * recall) / (precision + recall)
  
  # Round all values to 4 decimal places
  precision <- round(precision, 4)
  recall <- round(recall, 4)
  f1 <- round(f1, 4)
  
  return(list(precision=precision, recall=recall, f1=f1))
}

# Calculate for first classification
result1 <- calculate_f1(TP1, FP1, FN1)

# Calculate for second classification
result2 <- calculate_f1(TP2, FP2, FN2)

# Print results
cat("First Classification:\n")
cat("Precision:", result1$precision, "\n")
cat("Recall:", result1$recall, "\n")
cat("F1 Score:", result1$f1, "\n\n")

cat("Second Classification:\n")
cat("Precision:", result2$precision, "\n")
cat("Recall:", result2$recall, "\n")
cat("F1 Score:", result2$f1, "\n")

dataset <- system.file("texts", "crude", package = "tm") # Crude Dataset

dataset.corpus <- VCorpus(DirSource(dataset), readerControl = list(reader = readReut21578XMLasPlain))
Fourth_doc_content_2 <- dataset.corpus[[4]]

# Extract the "heading" metadata field from the 4th document
heading_text <- meta(Fourth_doc_content_2, "heading")

# Print the heading text
cat("Heading:", heading_text, "\n")

# Given data
total_reviews <- 100
real_customers <- 57      # Negative class
bots <- total_reviews - real_customers  # Positive class = 43

classified_real <- 37      # Number classified as real customers
actual_real_in_classified_real <- 36  # True negatives (TN)

# Calculate FP: bots misclassified as real
FP <- classified_real - actual_real_in_classified_real

# Calculate FN: real customers misclassified as bots
FN <- real_customers - actual_real_in_classified_real

# Calculate TP: bots correctly classified as bots
TP <- bots - FP

# TN is given as actual_real_in_classified_real
TN <- actual_real_in_classified_real

# Print results
cat("Confusion matrix elements:\n")
cat("TP =", TP, "\n")
cat("FP =", FP, "\n")
cat("FN =", FN, "\n")
cat("TN =", TN, "\n")

answers <- c("Yes", "No", "Yes", "Yes", "No", "Maybe")

answers.as.factors1 <- as.factor(answers)

answers.as.factors2 <- factor(answers, levels = c("Maybe", "Yes", "No"))
# Check the levels of each factor
cat("Levels of answers.as.factors1:\n")
print(levels(answers.as.factors1))  # Default alphabetical order

cat("Levels of answers.as.factors2:\n")
print(levels(answers.as.factors2))  # Explicit order

# Check if the two factor objects are identical
cat("Are the two factors identical?\n")
print(identical(answers.as.factors1, answers.as.factors2))

# Summary to show counts of each level
cat("\nSummary of answers.as.factors1:\n")
print(summary(answers.as.factors1))

cat("\nSummary of answers.as.factors2:\n")
print(summary(answers.as.factors2))

# Demonstrate that factors can be created from numeric values
numeric_data <- c(1, 2, 1, 3, 2)
numeric_factor <- factor(numeric_data)
cat("\nNumeric factor levels:\n")
print(levels(numeric_factor))

cat("\nNumeric factor values:\n")
print(numeric_factor)
# Given values
fetch_rate <- 80000          # pages per second
total_pages <- 7e9           # 7 * 10^9 pages
seconds_in_month <- 60*60*24*30  # seconds in 30 days = 2,592,000

# Calculate total time in seconds
time_seconds <- total_pages / fetch_rate

# Convert to months
time_months <- time_seconds / seconds_in_month

# Convert months to days (approximate, 30 days per month)
time_days <- time_months * 30

# Print results
cat("Time to fetch pages:\n")
cat("Seconds:", time_seconds, "\n")
cat("Months:", round(time_months, 5), "\n")
cat("Days:", round(time_days, 2), "\n")

set.seed(123)

Run.Time.Complexity <- data.frame('Input Size'=numeric(), 'Run Time'=numeric())

input.sizes <- c(1e3, 1e4, 1e5)

for (N in input.sizes) {
  
  print("")
  
  print(paste("Run for input size N = ", N))
  
  start.time <- Sys.time() # Start Measuring Execution Time
  
  pb <- txtProgressBar(min = 1, max = N, style = 3)
  
  for (n in 1:N) {
    
    # if ((n %% 100) == 0) { print(paste(round(n/N*100, 3), "%")) } # Print progress
    
    row <- floor(runif(10, min = 1, max = 100)) # Generate random vector
    
    a <- row[1]; b <- row[2]; c <- row[3]
    
    sa = a * a
    
    sb = b * b
    
    sc = c * c
    
    sum = sqrt(sa + sb + sc)
    
    for (m in 1:1e1) {
      
      sc = sc + 5
      
      Sys.sleep(0.00002)
      
    }
    
    setTxtProgressBar(pb, n)
    
  }
  
  close(pb)
  
  end.time <- Sys.time() # Stop Measuring Execution Time
  
  Run.time <- round(end.time - start.time, 3)
  
  print(Run.time)
  
}
  
  # Time Complexity of an algorithm for different input sizes N.
  
  N <- input.sizes

NN <- N/N[1]



Logarithmic <- log10(NN)

Linear <- NN

Log.Linear <- NN*log10(NN)

Polynomial <- NN**2

Exponential <- 2**NN



print(Logarithmic)

print(Linear)

print(Log.Linear)

print(Polynomial)

print(Exponential)

dataset <- system.file("texts", "crude", package = "tm") # Crude Dataset

dataset.corpus <- VCorpus(DirSource(dataset), readerControl = list(reader = readReut21578XMLasPlain))

dataset.corpus

# Subset the documents
subset.corpus <- dataset.corpus[c(5, 16, 20)]

# Create Document Term Matrix
dtm <- DocumentTermMatrix(subset.corpus)

# Inspect the DTM
inspect(dtm)

term.freq <- colSums(as.matrix(dtm))
term.freq <- sort(term.freq, decreasing = TRUE)

# View the top terms
head(term.freq, 10)

names(term.freq)[5:7]


