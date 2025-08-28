# Newsgroups Classification with tm
library(tm)
library(class)

# 1) Select Newsgroup to analyze: 
news_group1 <-"sci.med"
news_group2 <- "rec.motorcycles"

train_path <- "20news-bydate-train"
test_path <- "20news-bydate-test"
# Specify Data Paths 
Doc1.TrainPath <- paste0("C:/Users/kevMi/OneDrive/Documents/METCS688-WebMiningGraphAnalysis/Lab 2 Code/Data/20news-bydate-train/sci.med")

Doc1.TestPath <- paste0("C:/Users/kevMi/OneDrive/Documents/METCS688-WebMiningGraphAnalysis/Lab 2 Code/Data/20news-bydate-test/sci.med")

Doc2.TrainPath <- paste0("C:/Users/kevMi/OneDrive/Documents/METCS688-WebMiningGraphAnalysis/Lab 2 Code/Data/20news-bydate-train/rec.motorcycles")

Doc2.TestPath <- paste0("C:/Users/kevMi/OneDrive/Documents/METCS688-WebMiningGraphAnalysis/Lab 2 Code/Data20news-bydate-test/rec.motorcycles")

print(Doc2.TrainPath)
# 2) Load All Data using tm's DirSource 
Temp1 <- DirSource(Doc1.TrainPath)
Temp2 <- DirSource(Doc2.TrainPath)
Temp3 <- DirSource(Doc1.TestPath)
Temp4 <- DirSource(Doc1.TestPath)
print(length(Temp1))

Doc1.Train <- VCorpus(URISource(Temp1$filelist[1:doc_count]),readerControl=list(reader=readPlain)) # Load newsgroup1 as Corpus
Doc2.Train <- VCorpus(URISource(Temp2$filelist[1:doc_count]),readerControl=list(reader=readPlain)) # Load newsgroup2 as Corpus
Doc1.Test <- VCorpus(URISource(Temp3$filelist[1:doc_count]),readerControl=list(reader=readPlain)) # Load newsgroup1 as Corpus
Doc2.Test <- VCorpus(URISource(Temp4$filelist[1:doc_count]),readerControl=list(reader=readPlain)) # Load newsgroup1 as Corpus

# 3) Create Corpus of only the first 100 documents
doc_count <- 100
Doc.Corpus <- c(Doc1.Train,Doc1.Test,Doc2.Train,Doc2.Test) # Merge all
inspect(Doc.Corpus[[3]])

# 4) Create Document-Term Matrix (dtm) of word lengths of at least 2 and word frequency of at least 5 
dtm <- DocumentTermMatrix(Doc.Corpus, control=list(wordLengths=c(2,Inf), bounds=list(global=c(5,Inf))) )
print(length(dtm))
set.seed(1234)

# 5) Split the Document-Term Matrix into Train & Test Data sets
# and Create Classification Labels (Tags)
# Then perform text classification using "KNN" classifier from the package "class".
True.Tags <- c(rep("Sci",100), rep("Sci",100), rep("Rec",100), rep("Rec",100))

Positive <- "Rec"; Negative <- "Sci"; CM.Names <- c(Positive,Negative)

train.Range <- c(201:300,1:100); test.Range <- c(301:400,101:200)

train.doc <- dtm[train.Range,] # Data set for which classification is already known

test.doc <- dtm[test.Range,] # Data set you are trying to classify
Tags <- factor(c(rep("Sci",100), rep("Rec",100)),levels=c("Sci","Rec"))

Train.Tags <- factor(c(rep("Positive",100), rep("Negative",100)),levels=c("Positive","Negative")) # Train Tags as Factors

Test.Tags <- factor(c(rep("Positive",100), rep("Negative",100)),levels=c("Positive","Negative")) # Test Tags as Factors

Tags <- factor(c(rep("Positive",100), rep("Negative",100)),levels=c("Positive","Negative")) # TAGS Correct answers f
table(Tags)
prob.test <- knn(train.doc, test.doc, Train.Tags, k = 3, prob=TRUE) # k-number of neighbors considered
class(prob.test)     
typeof(prob.test)    
# 6) Analysis -- Data Frame: Train Data 
a <- train.Range  # Train Data Indices

b <- True.Tags[train.Range] # True Tags from Data

c <- Train.Tags # Train Tags created by hand from the data range as Factor

TD <- data.frame('Train Doc'=a, 'True Tags'=b, 'Train Tags'=c)

a <- test.Range # Test Data Indices

b <- True.Tags[test.Range] # True Tags from Data

c <- Test.Tags # Test Tags

d <- levels(prob.test)[prob.test] # Predicted Tags by the KNN model

e <- attributes(prob.test)$prob # Probability of Predictions

f = prob.test==Test.Tags # Compare Predictions with Test Tags

Predictions <- data.frame("Test.Doc"=a, 'True.Tags'=b, 'Test.Tags'=c, 'Pred.Tags'=d, 'Prob'=e, 'T_F'=f)
result <- cbind(TD, '.'=rep(c('-'), dim(TD)[1]), Predictions)

knitr::kable(result) # Display result

# 7 & 8) Create the Confusion Matrix 

PositiveClassified <- (prob.test==Train.Tags)[1:100] # Classified as Positive

TP <- sum(PositiveClassified=="TRUE") # Actual Positive classified as Positive

FN <- sum(PositiveClassified=="FALSE") # Actual Positive classified as Negative



NegativeClassified <- (prob.test==Train.Tags)[101:200] # Classified as Negative

FP <- sum(NegativeClassified=="FALSE") # Actual Negative classified as Positive

TN <- sum(NegativeClassified=="TRUE") # Actual Negative classified as Negative
confusion_matrix <- table(Predicted = knn_pred, Actual = test_labels)
CM <- as.data.frame.matrix(confusion_matrix)
sum(CM[1, ])
table(prob.test, Train.Tags) 
# 9) Calculate Precision, Recall & F-score.
# Calculate Precision, Recall for Positive class
precision <- TP / (TP + FP)
recall <- TP / (TP + FN)

# Calculate F1-score
f1_score <- 2 * (precision * recall) / (precision + recall)

# Print rounded F1-score
cat("F1-score (Positive class):", round(f1_score, 3), "\n")

# 10) Re-Run your code for another pair of subjects. 

