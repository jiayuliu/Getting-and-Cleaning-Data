6#Getting and Cleaning Data Project

#Merges the training and the test sets to create one data set.

##Test Data
XTest<- read.table("test/X_test.txt")
YTest<- read.table("test/Y_test.txt")
SubjectTest <-read.table("test/subject_test.txt")

##Train data
XTrain<- read.table("train/X_train.txt")
YTrain<- read.table("train/Y_train.txt")
SubjectTrain <-read.table("train/subject_train.txt")

##Features & Activity
features<-read.table("features.txt")
activity<-read.table("activity_labels.txt")

##Merge Data
X<-rbind(XTest, XTrain)
Y<-rbind(YTest, YTrain)
Subject<-rbind(SubjectTest, SubjectTrain)

#Extracts only the measurements on the mean and standard deviation for each measurement.
index<-grep("mean\\(\\)|std\\(\\)", features[,2])
length(index)
X<-X[,index]

#Uses descriptive activity names to name the activities in the data set
Y[,1]<-activity[Y[,1],2]
head(Y)

#Appropriately labels the data set with descriptive variable names.
names<-features[index,2] 
names(X)<-names 
names(Subject)<-"SubjectID"
names(Y)<-"Activity"

CleanedData<-cbind(Subject, Y, X)
head(CleanedData[,c(1:4)]) 


#From the data set in step 4, creates a second, independent tidy data set with 
#the average of each variable for each activity and each subject.

CleanedData2<-aggregate(CleanedData, 
                         by=list(CleanedData$Activity,
                                 CleanedData$Subject              
                                 ), FUN=mean)

CleanedData2<-CleanedData2[,!(colnames(CleanedData2)%in%c("Activity", "Subject"))]

head(CleanedData2)

write.table(CleanedData2, file = "tidydata.txt",row.name=FALSE)




