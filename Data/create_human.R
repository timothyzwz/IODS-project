## Wenzhong Zhang
## 28th November 2017
## Data wrangling exercise for next week's data

# access the dplyr, tidyr and ggplot2 library
library(dplyr)
library(tidyr)
library(ggplot2)

# read the dataset
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# explore the structure and dimensions of the data
str(hd)
str(gii)
dim(hd)
dim(gii)

# create summary
summary(hd)
summary(gii)

# change the column names
colnames(hd) <- c("hdir", "cty", "hdi", "lifebirth", "edutime", "meanedu", "gni", "gnirhdir")
colnames(gii) <- c("giir", "cty", "gii", "mortalityM", "teenbirth", "ParM", "edu2F", "edu2M", "labF", "labM")

# check the change
summary(hd)
summary(gii)

# define two new columns
gii <- mutate(gii, eduRatio = edu2F / edu2M)
gii <- mutate(gii, labRatio = labF / labM)

# glimpse at the new data
glimpse(gii)


# common columns to use as identifiers
join_by <- c("cty")

# join the two datasets by the selected identifiers
human <- inner_join(hd, gii, by = join_by)

# explore the structure and dimensions of the data
str(human)
dim(human)
glimpse(human)

# Saving the analysis daatset, name it as human.txt, under the data folder
write.table(human, file = "data/human.txt")


