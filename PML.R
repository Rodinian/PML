#download the data set
fileUrl <- "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv"
download.file(fileUrl,destfile="./pmlTraining.csv",method="curl")
list.files("~/")
dateDownloaded <- date()
dateDownloaded

fileUrl <- "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv"
download.file(fileUrl,destfile="./pmlTesting.csv",method="curl")
list.files("./")
dateDownloaded <- date()
dateDownloaded

trainData<-read.csv("./pmlTraining.csv", stringsAsFactors=F,na.strings=c("","NA","#DIV/0!"))
trainData<-trainData[,!is.na(trainData[1,])]
trainData$user_name<-as.factor(trainData$user_name)
trainData$classe<- as.factor(trainData$classe)
trainData<-trainData[,8:60]
#clean the traindata first

#clean the testdata
testData<-read.csv("./pmlTesting.csv", stringsAsFactors=F,na.strings=c("","NA","#DIV/0!"))
testData<-testData[,!is.na(testData[1,])]
testData$user_name<-as.factor(testData$user_name)
testData<-testData[,8:59]

library(randomForest)
fit<-randomForest(classe~.,data=trainData,ntree = 500)
pred <- predict(fit,testData)

#The out-of-bag (oob) error estimate
#In random forests, there is no need for cross-validation or a separate test set to get an unbiased estimate of the test set error. It is estimated internally, during the run, as follows:
#Each tree is constructed using a different bootstrap sample from the original data. About one-third of the cases are left out of the bootstrap sample and not used in the construction of the kth tree.
#Put each case left out in the construction of the kth tree down the kth tree to get a classification. In this way, a test set classification is obtained for each case in about one-third of the trees. At the end of the run, take j to be the class that got most of the votes every time case n was oob. The proportion of times that j is not equal to the true class of n averaged over all cases is the oob error estimate. This has proven to be unbiased in many tests.