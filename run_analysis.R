run_analysis <- function(dir) {
	# the below code needs the data.table package to run
	if (!require('data.table')) {
		stop('The package data.table was not installed')
	}
	
	# merge all X files
	trainX <- read.csv(paste(dir, "train/X_train.txt", sep = "/" ), header=F, sep="")
	testX <- read.csv(paste(dir, "test/X_test.txt", sep = "/" ), header=F, sep="")
	mergedX <- rbind(trainX,testX)

	bigData <- mergedX

	# merge all Y files
	trainY <- read.csv(paste(dir, "train/y_train.txt", sep = "/" ), header=F, sep="")
	testY <- read.csv(paste(dir, "test/y_test.txt", sep = "/" ), header=F, sep="")
	mergedY <- rbind(trainY,testY)

	bigData$Y <- mergedY[[1]]
	
	# merge all subject files
	trainSubject <- read.csv(paste(dir, "train/subject_train.txt", sep = "/" ), header=F, sep="")
	testSubject <- read.csv(paste(dir, "test/subject_test.txt", sep = "/" ), header=F, sep="")
	mergedSubject <- rbind(trainSubject,testSubject)

	bigData$subject <- mergedSubject[[1]]

	# load features
	features <- read.csv(paste(dir, "features.txt", sep = "/" ), header=F, sep="")
	meanStdFeatures <- features[grep("mean|std",features$V2),1]
	# extract only columns that contain the word mean or std.  
	# this purposely includes columns such as meanFreq and is not limited to mean() columns
	meanStdData <- bigData[,meanStdFeatures]
	# set column names with meaningful names from meanStdFeatures
	colnames(meanStdData) <- features[meanStdFeatures,2] 
	# don't lose these 2 columns
	meanStdData$Y <- bigData$Y
	meanStdData$subject <- bigData$subject

	# add activity column to dataset
	# load activity_labels
	activities <- read.csv(paste(dir, "activity_labels.txt", sep = "/" ), header=F, sep="")
	colnames(activities) <- c('id','activity')
	# replace activity id in data set with label.  
	# merge function will sort the resultant data.frame on column Y per documentation!
	meanStdData <- merge(meanStdData, activities, by.x = 'Y', by.y = 'id')
	meanStdData$Y <- NULL
	
#	write.table(meanStdData, file = "result.txt",row.names = FALSE)
	
	# group by subject and activity then find mean of each column
	DT<-data.table(meanStdData)
	DT[,lapply(.SD,mean), by=list(subject=DT$subject,activity=DT$activity)]
	
	DT
}
