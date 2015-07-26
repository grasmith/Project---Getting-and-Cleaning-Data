# Project---Getting-and-Cleaning-Data
The Project consists of a transformed dataset produced by the Human Activity Recognition Using Smartphones project
and combining them into a tidy data set for later analysis. The data are measurements collected from a wearable computing
device (Samsung Galaxy S smartphone) and are captured by accelerometers and a gyroscope during various physical activities.

To run the data tidying script,  
1.	ensure that the UCI HAR Dataset is in your local working directory  
2.	copy the R script 'run_analysis.R' and lbls_lkup.txt to the same directory  
3.	run the R script. The results file 'tidy_data.txt' will be created in the working directory. See the accompanying
code book for detail on the data in the results file.  

The UCI HAR Dataset has the following structure of files  
UCI HAR Dataset  
	README.txt  
	features_info.txt  
	features.txt  
	activity_labels.txt  
	test  
		X_test.txt  
		y_test.txt  
subject_test.txt  
Inertial Signals  
	(inertial data files)  
train  
X_test.txt  
y_test.txt  
subject_test.txt  
Inertial Signals  
(inertial data files)  

The following describes the purpose of each file:  
'README.txt':		overview of the complete dataset  
'features_info.txt':	Shows information about the variables used on the feature vector  
'features.txt':		List of all features  
'activity_labels.txt':	Links the class labels with their activity name  
'train/X_train.txt':	Training set  
'train/y_train.txt':	Training labels  
'test/X_test.txt':	Test set   
'test/y_test.txt':	Test labels  
'train/subject_train.txt':	Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30  
'test/subject_test.txt':	as for subject_train above  

