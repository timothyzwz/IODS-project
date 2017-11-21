## Wenzhong Zhang
## 20th November 2017
## Data wrangling exercise: Logistic Regression

# access the dplyr, tidyr and ggplot2 library
library(dplyr)
library(tidyr)
library(ggplot2)

# read the dataset
mat <- read.table("data/student-mat.csv", sep=";", header = T)
por <- read.table("data/student-por.csv", sep=";", header = T)


# explore the structure and dimensions of the data
str(mat)
str(por)
dim(mat)
dim(por)

# common columns to use as identifiers
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")

# join the two datasets by the selected identifiers
mat_por <- inner_join(mat, por, by = join_by, suffix = c(".math", ".por"))

# explore the structure and dimensions of the data
str(mat_por)
dim(mat_por)
glimpse(mat_por)

# create a new data frame with only the joined columns
alc <- select(mat_por, one_of(join_by))

# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(mat)[!colnames(mat) %in% join_by]

# print out the columns not used for joining
notjoined_columns

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'mat_por' with the same original name
  two_columns <- select(mat_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# glimpse at the new combined data
glimpse(alc)

# define a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# define a new logical column 'high_use'
alc <- mutate(alc, high_use = alc_use > 2)

# glimpse at the new combined data
glimpse(alc)

# Saving the analysis daatset, name it as alc.txt, under the data folder
write.table(alc, file = "data/alc.txt")


