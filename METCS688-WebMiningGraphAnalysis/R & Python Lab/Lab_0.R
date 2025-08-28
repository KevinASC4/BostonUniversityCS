# 
rm(list=ls()); cat("\014") # clear all
pth <- ""
source(pth)

Age<-c(53,32,57,23,25,38)
Weight<-c(74,62,66,47,59,99)
Height<-c(175, 166,187,197,186,197)
DF<-data.frame(Age,Weight,Height) 


# Using lapply() 
Names <- c("Ed","Moe","Joe","Ned","Bo","Jake") 
# rownames(DF) <- Names
Student.List <- lapply(seq_along(Names), function(x1, x2, x3, x4,i) { 
  list( Name=x1[[i]], Age=x2[[i]], Weight=x3[[i]], Height=x4[[i]]) 
}, x1=Names, x2=Age, x3=Weight, x4=Height)
names(Student.List) <- Names

result <- do.call("rbind",lapply(Student.List, function(x) Kg2Lb(x$Weight) ))


dim(DF) # Q3
print(result[2])  # Q4
DF[7,] = c(61, 75, 179) # Q5 - a) Correct
Age<-c(Age,61); Weight<-c(Weight,75); Height<-c(Height,179); DF<-data.frame(Age,Weight,Height) # Q5 - b) Correct
DF = rbind(DF, data.frame(Height=179, Age=61, Weight=75)) # Q5 - c) Correct
my_data <- c(61, 75, 179 ); names(my_data) <- c("Age", "Weight", "Height"); DF = rbind(DF, as.data.frame(t(my_data))) # Q5 - d) Correct

# Define a simple Kg to Lb conversion function (if not already defined)
Kg2Lb <- function(kg) {
  lb <- kg * 2.20462
  return(lb)
}

# Find Moe's index (second person)
moe_index <- 2

# Convert Moe's weight to pounds
moe_weight_lb <- Kg2Lb(Weight[moe_index])

# Print Moe's weight in pounds
print(moe_weight_lb)




