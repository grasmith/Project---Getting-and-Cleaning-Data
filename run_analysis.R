library(dplyr)
# set up working directories
home_dir <- "D:/D_documents/MOOC/Coursera/Getting and Cleaning Data/project"
top_dir<- paste(home_dir,"UCI HAR Dataset",sep="/")
test_dir <- paste(top_dir,"test",sep="/")
train_dir <- paste(top_dir,"train",sep="/")
setwd(home_dir)
# load the lookup table that will be used to convert variable names
lkup <- read.table("lbls_lkup.txt",stringsAsFactors = FALSE,col.names=c("old","new"))
setwd(top_dir)
# load the 'features' which are the raw variable names for the dataset, e.g. tBodyAcc-mean()-X
features <- read.table("features.txt",stringsAsFactors = FALSE,col.names=c("index","feature"))
# load the names of the activities
act_labels <- read.table("activity_labels.txt",stringsAsFactors = FALSE,col.names=c("index","activity"))

#start with the test data: first load the subjects (people that were doing the activities)
#and activities (what they did)
setwd(test_dir)
subjects <- read.table("subject_test.txt",stringsAsFactors = FALSE,col.names="subject")
activities <- read.table("y_test.txt",stringsAsFactors = FALSE,col.names="activity")
#now load the observations
tst_body <- tbl_df(read.table("X_test.txt",stringsAsFactors = FALSE,col.names = features$feature))
#only interested in means and std deviations
tst_body <- select(tst_body,contains(".mean."),contains(".std."))
#give the variables more meaningful names from the lookup file loaded earlier
names(tst_body) <- lkup$new
#add columns for the activities and subjects
tst_body <- mutate(tst_body,activity=activities$activity)
tst_body <- mutate(tst_body,subject = subjects$subject)
#reorder
tst_body <- tst_body[,c(67,68,1:66)]

#exact same steps as above for train dataset
setwd(train_dir)
subjects <- read.table("subject_train.txt",stringsAsFactors = FALSE,col.names="subject")
activities <- read.table("y_train.txt",stringsAsFactors = FALSE,col.names="activity")
trn_body <- tbl_df(read.table("X_train.txt",stringsAsFactors = FALSE,col.names = features$feature))
trn_body <- select(trn_body,contains(".mean."),contains(".std."))
names(trn_body) <- lkup$new
trn_body <- mutate(trn_body,activity=activities$activity)
trn_body <- mutate(trn_body,subject = subjects$subject)
trn_body <- trn_body[,c(67,68,1:66)]

#merge the two datasets
two_body <- rbind(trn_body,tst_body,make.row.names = FALSE)
rm(trn_body,tst_body)

#replace the activity numbers by the activity names
act_index <- two_body$activity
for(i in 1:10299){two_body$activity[i] <- act_labels$activity[act_index[i]]}

#From the mergeed data set
#create a second, independent tidy data set
#with the average of each variable for each activity and each subject.

tidy_ds <- group_by(two_body,activity,subject)
sum_tidy_ds <- summarise_each(tidy_ds, funs(mean))

#now write the tidy dataset to a text file for upload
setwd(home_dir)
write.table(sum_tidy_ds,file="final_ds.txt",row.names=FALSE)

