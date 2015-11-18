# gettingCleaningDataProj
Course project for Getting and Cleaning Data Coursera course

__run_analysis.R__
* required library - data.table.  Will stop and throw error if it can not be installed
* argument - the base directory of the extracted data.  Could be absolute or relative.
* return - the data.table containing the subject and activities and all variables required in the project sorted by activity
* example - 
	* result <- run_analysis('.') # where the script is in the base dir of "UCI HAR Dataset"
	* result <- run_analysis('C:/Users/someUser/coursera/UCIHARDataset') # where the argument dir is the base data files dir that contains the test and train sub dirs
	
__result.txt__
* output - the file result of the output by running the command on the returned result variable mentioned above: 
	* write.table(result,'result.txt', row.names = FALSE)	
	* this output deliberately includes all column names with the words that include mean or std cahracters
	* sorted by activity id in ascending order, but activity id column has been deleted so only activity names are visible
	
__UCIHARDataset__
* data dir - extracted [project data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

__Script implementation description__
* description comments are made in the script.  Please open script to view them.
