library(dplyr)
library(plyr)
#Creating train and test datasets

X_test <- read.table(".../UCI HAR Dataset/test/X_test.txt", header = FALSE)
X_test
Y_test <- read.table(".../UCI HAR Dataset/test/Y_test.txt", header = FALSE)
Y_test
Subject_test <- read.table(".../UCI HAR Dataset/test/subject_test.txt", header = FALSE)
Subject_test


X_train <- read.table(".../UCI HAR Dataset/train/X_train.txt", header = FALSE)
X_train
Y_train <- read.table(".../UCI HAR Dataset/train/Y_train.txt", header = FALSE)
Y_train
Subject_train <- read.table(".../UCI HAR Dataset/train/subject_train.txt", header = FALSE)
Subject_train



#1 

X_Compiled <- rbind(X_test, X_train)
X_Compiled
Y_Compiled <- rbind(Y_test, Y_train)
Y_Compiled
Subject_Compiled <- rbind(Subject_test, Subject_train)
Subject_Compiled

features <- read.table(".../UCI HAR Dataset/features.txt", header = FALSE)
features_v2 <- features[,2]
names(X_Compiled) <- features_v2

data.all <- data.frame(X_Compiled, Y_Compiled, Subject_Compiled)


#2

MeanStd <- data.all[,grepl('mean|std', names(data.all))]

#3

Activity_Label <- read.table(".../UCI HAR Dataset/activity_labels.txt", header = FALSE)
Activity_list <- Activity_Label[,2]
MeanStd$V1 <- Activity_list[data.all$V1]
MeanStd$V1.1 <- data.all$V1.1
data.all$V1

#4

names(MeanStd)
MeanStd <- rename(MeanStd, c("V1"="Activity", "V1.1"="Subject"))
names(MeanStd) <- gsub("\\.\\.\\.","_",names(MeanStd))
names(MeanStd) <- gsub("\\.\\.","_",names(MeanStd))
names(MeanStd) <- gsub("\\.","_",names(MeanStd))
names(MeanStd) <- gsub('std', "Standard_Deviation", names(MeanStd))
names(MeanStd) <- gsub('Acc', "Acceleration", names(MeanStd))

#5
New_Tidy_Data <- aggregate(MeanStd[,1:79], list(MeanStd$Activity, MeanStd$Subject), mean)
New_Tidy_Data <- rename(New_Tidy_Data, c("Group.1"="Activity", "Group.2"="Subject"))
New_Tidy_Data

write.table(New_Tidy_Data, ".../New_Tidy_Data_v1.txt", row.name=FALSE)


