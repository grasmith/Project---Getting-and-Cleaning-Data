library(dplyr)
# set up working directories
home_dir <- "D:/D_documents/MOOC/Coursera/Getting and Cleaning Data/project"
top_dir<- paste(home_dir,"UCI HAR Dataset",sep="/")
test_dir <- paste(top_dir,"test",sep="/")
train_dir <- paste(top_dir,"train",sep="/")
setwd(home_dir)
# load the lookup table that will be used to convert variable names
lkup <- read.table("lbls_lkup.txt",stringsAsFactors = FALSE,col.names=c("old","new"))
# load the 'feature' which are the raw variable names for the dataset, e.g. tBodyAcc-mean()-X
setwd(top_dir)
features <- read.table("features.txt",stringsAsFactors = FALSE,col.names=c("index","feature"))
act_labels <- read.table("activity_labels.txt",stringsAsFactors = FALSE,col.names=c("index","activity"))

setwd(test_dir)
subjects <- read.table("subject_test.txt",stringsAsFactors = FALSE,col.names="subject")
activities <- read.table("y_test.txt",stringsAsFactors = FALSE,col.names="activity")
tst_body <- tbl_df(read.table("X_test.txt",stringsAsFactors = FALSE,col.names = features$feature))
tst_body <- select(tst_body,contains(".mean."),contains(".std."))
names(tst_body) <- lkup$new
tst_body <- mutate(tst_body,activity=activities$activity)
tst_body <- mutate(tst_body,subject = subjects$subject)
tst_body <- tst_body[,c(67,68,1:66)]

setwd(train_dir)
subjects <- read.table("subject_train.txt",stringsAsFactors = FALSE,col.names="subject")
activities <- read.table("y_train.txt",stringsAsFactors = FALSE,col.names="activity")
trn_body <- tbl_df(read.table("X_train.txt",stringsAsFactors = FALSE,col.names = features$feature))
trn_body <- select(trn_body,contains(".mean."),contains(".std."))
names(trn_body) <- lkup$new
trn_body <- mutate(trn_body,activity=activities$activity)
trn_body <- mutate(trn_body,subject = subjects$subject)
trn_body <- trn_body[,c(67,68,1:66)]

two_body <- rbind(trn_body,tst_body,make.row.names = FALSE)
rm(trn_body,tst_body)

act_index <- two_body$activity
for(i in 1:10299){two_body$activity[i] <- act_labels$activity[act_index[i]]}

#From the data set in step 4,
#creates a second, independent tidy data set
#with the average of each variable for each activity and each subject.

tidy_ds <- group_by(two_body,activity,subject)

sum_tidy_ds <- summarise_each(tidy_ds, funs(mean))

setwd(home_dir)
write.table(sum_tidy_ds,file="final_ds.txt",row.names=FALSE)

