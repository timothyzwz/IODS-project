# Wenzhong Zhang
# 11th Nov 2017
# Data wrangling of learning2014 dataset

# read the dataset
learning2014 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header = T)

# explore the structure of the data
str(learning2014)

# explore the dimension of the data
dim(learning2014)

# The dimension of the data is 183 * 60, with 60 variables and 183 responses
# Most of the data are interger values, only the gender variable is two levels factor

# access the dplyr library
library(dplyr)

# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30", "D06", "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning and create column 'deep' by averaging
deep_columns <- select(learning2014, one_of(deep_questions))
learning2014$deep <- rowMeans(deep_columns)

# select the columns related to surface learning and create column 'surf' by averaging
surface_columns <- select(learning2014, one_of(surface_questions))
learning2014$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning and create column 'stra' by averaging
strategic_columns <- select(learning2014, one_of(strategic_questions))
learning2014$stra <- rowMeans(strategic_columns)

# scaling the Attitude back to the original scale and save it as a new column named "attitude"
learning2014$attitude <- learning2014$Attitude / 10

# choose the columns
selected_columns <- c("gender", "Age", "attitude", "deep", "stra", "surf", "Points")

# select the 'selected_columns' to create a new dataset
learning2014_selected <- select(learning2014, one_of(selected_columns))

# explore the structure of the new selected dataset
str(learning2014_selected)

# exclude observations where the exam points variable is zero
learning2014_selected <- filter(learning2014_selected, Points > 0)

# explore the structure of the updated selected dataset
str(learning2014_selected)
#166 obs. of 7 variables, correct

# set the working directory to IODS folder
# Session -> set working directory

# Saving the analysis daatset, name it as learning2014_selected.txt, under the data folder
write.table(learning2014_selected, file = "data/learning2014_selected.txt")

# read the data and check for the validity
learning2014_selected_check <- read.table("data/learning2014_selected.txt")

# check the dataset
str(learning2014_selected_check)
head(learning2014_selected_check)
