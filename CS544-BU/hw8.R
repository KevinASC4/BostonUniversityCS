# Load the Titanic dataset
data("Titanic")

# Check the dimensions and names of the Titanic dataset
dim(Titanic)
dimnames(Titanic)

# Summing over Sex and Age to get the survival counts by Class and Survived
survival_data <- margin.table(Titanic, c(1, 2))  # Summing over the 3rd and 4th dimensions

# View the summarized survival data
print(survival_data)


