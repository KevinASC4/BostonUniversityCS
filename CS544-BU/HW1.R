#Part 2
#1a
scores <- c(68, 25, 87, 89, 91, 79, 99, 80, 62, 74)

#1b
n <- length(scores)
#1c
first_and_second <- scores[1:2]
#1d
first_and_last <- c(scores[1],scores[length(scores)])
#1e
middle_two <- scores[((length(scores) + 1) / 2 - 0.5):((length(scores) + 1) / 2 + 0.5)]
#2a
median_score <- median(scores)
#2b
below_median <- scores <= median(scores)
#2c
above_median <- scores > median(scores)
#2d
count_below_median <- sum(scores[scores <= median(scores)])
#2e
count_above_median <- sum(scores[scores > median(scores)])
#3a 
below_median <- scores[scores <= median(scores)]
#3b
above_median <- scores[scores > median(scores)]
#3c 
odd_indexed_values <- scores[seq(1, length(scores), by = 2)]
#3d
even_indexed_values <- scores[seq(2, length(scores), by = 2)]
#4a
format_scores_version1 <- paste(LETTERS[1:length(scores)], scores, sep = "=")
#4b
format_scores_version2 <- paste(rev(LETTERS[1:length(scores)]), rev(scores), sep = "=")
#Extracredit 1
scores_matrix <- matrix(scores, nrow = 2, byrow = TRUE)
#extracredit 2
first_and_last_version1 <- scores_matrix[, c(1, ncol(scores_matrix))]
#extraCredit 3
named_matrix <- `rownames<-`(`colnames<-`(scores_matrix, paste("Student", 1:ncol(scores_matrix), sep = "_")), paste("Quiz", 1:nrow(scores_matrix), sep = "_"))
