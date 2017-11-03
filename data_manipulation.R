                             ## Data Manipulation
#1 Acquiring data

getwd() # get the path of working directory
setwd("/home/anuja/Anuja/RScript/datasets") # location using setwd()
anscombe<-read.csv("/home/anuja/Anuja/RScript/datasets/anscombe.csv") #we will use read.csv()
#function to import the file, and store it in the anscombe object in R, which will be a data frame
anscombe
anscombe<-read.csv("anscombe.csv",stringsAsFactors = FALSE) #If a .csv file contains both numeric
#and character variables, and we use read.csv() ,the character variables get automatically 
#converted to the factor type.We can prevent character variables from this automatic conversion 
#to factor,by specifying stringsAsFactors=FALSE
anscombe
iris<-read.csv("iris.csv",stringsAsFactors = FALSE)
iris
iris_semicolon<-read.csv("iris.csv",stringsAsFactors = FALSE,sep=";")
iris_semicolon
iris_tab<-read.csv("iris.csv",sep="\t") #if the values are tab separated, we can use read.csv() with sep= "\t"
iris_tab
iris_tab1<-read.table("iris.csv",header = TRUE) #Alternatively, we can use read.table() also
iris_tab1 #when we used read.table() , we had to specify whether the
#variable name is present or not, using the argument header=TRUE .

# If the dataset is stored in the *.xls or *.xlsx format
# we have to use certain R packages to import those files; one of the packages is xlsx










## Vector and matrix operations
#R code to perform matrix operations:

# Creating random matrix with two 3x3 and one 4x3 dimension
matA<-matrix(rnorm(12),ncol=3)
matB<-matrix(rnorm(9),nrow=3)
matC<-matrix(rnorm(9),nrow=3)
matA+matB # it gives error becz in addition and sub dimensions of the matrices should be the same
matB+matC # both has dimension 3x3

 #matrix multiplication
matA %*% matB #number of columns of first matrix should be same as the number of rows in second one 
matB %*% matC 

#Element wise multiplication with default multiplication symbol *
matA * matB #For element wise multiplication, both matrices must be of the same dimension
matB * matC


##Factor manipulation
# creating an R object whose value is "datamanipulation"
char.obj<-"datamanipulaition"
factor.obj<-factor(substring(char.obj,1:nchar(char.obj),1:nchar(char.obj)),levels=letters)
factor.obj
table(factor.obj)
levels(factor.obj)

#there are only a few nonzero values in the table, because the original
#factor variable does not have the entire alphabet as its value
#we will drop then levels that do not appear in the original factor variable
#to do so re-creating factor variable from existing factor variable
factor.obj1<-factor(factor.obj)# creating a factor variable by extracting each single letter from
# the character string.To extract each single letter the substring() function has been used.
#nchar() function gives number of character count in a character type R object
factor.obj1
levels(factor.obj1)
table(factor.obj1)

##Date processing using lubridate
# creating date object using built in as.Date() function
as.Date("1970-1-1")
# looking at the internal value of date object
as.numeric(as.Date("1970-1-1"))
#Second January 1970 is showing number of elapsed day is 1
as.Date("1970-1-2")
as.numeric(as.Date("1970-1-2"))
#Using the as.Date() function, we can easily create the date object.
#the typical format of the date object in this function is year, month, and then day.
#But we can also create a date object with other formats within the as.Date() function
as.Date("1970-1-1",format="%d-%b-%y")

# loading lubridate package
help(install.packages)
install.packages("lubridate")
#features of the lubridate package is that it can process date variables in heterogeneous formats.
library(lubridate)
# creating date object using mdy() function
mdy("Jan-01-1970")
#the default time zone in the mdy , dmy , or ymd function is Coordinated Universal Time (UTC)

# creating heterogeneous date object
#From this heterogeneous date, we can extract the valid date object that can be processed 
#further within R using the lubridate package
hetero_date<-c("12-october-1989","12-oct-1989","12-10-1989")
hetero_date
# parsing the character date object and convert to valid date
dmy(hetero_date)
#in lubridate package the sequence of year, month, and day should be similar across all values within the same object
#otherwise it will not get converted into a valid date
hetero_date<-c("12-oct-1989","12-october-1989","12,oct,1989","12/oct/1989","12-10-1989","1989-10-12","12 10 1989")
hetero_date
dmy(hetero_date)# here it will gives warning msg that 1 failed to parse i.e 1989-10-12

#using the core R function and also using the lubridate package we can change the month,
#only within an existing R date object
# Creating date object using base R functionality
date<-as.POSIXct("12-10-1989",format="%d-%m-%y",tz="UTC")#"POSIXct" representing calendar dates and times.
date
as.numeric(format(date,"%m"))
# manipulating month by replacing month 10 to 11
date<-as.POSIXct(format(date,"%d-11-%y"),tz="UTC")
date

# The same operation is done using lubridate package
date<dmy("12-10-1989")
date
month(date)
month(date)<-12

#In a dataset, the variable might have both date and time information,and we need to round
#them to the nearest day or month.
# accessing system date and time
current_time<-now()
current_time

# changing time zone to "GMT"
current_time1<-with_tz(current_time,"GMT")
current_time1

# rounding the date to nearest day
round_date(current_time1,"day")

# rounding the date to nearest month
round_date(current_time1,"month")

# rounding date to nearest year
round_date(current_time1,"year")

#using the lubridate package
date<-ymd(20160926)
date
with_tz(date,"GMT")
year(date)
month(date)
day(date)
month(date,label = T)
week(date)
min(date)
minute(date)
second(date)
tz(date)


##Subscripting and subsetting
#If we need to extract a smaller part of any R object (vector, data frame, matrix, or list)
#that contains more than one element, we need to use subscripts.

# creating a 10 element vector
elem10<-c(2,3,4,5,1,7,8,9,6,5)
# accessing fifth element
elem10[5]
# checking whether there is any value of num10 object greater than 6
elem10>6
# keeping only values greater than 6
elem10[elem10>6]
# use of negative subscript removes first element "2"
elem10[-1]
# creating a data frame with 2 variables
data_frame<-data.frame(x1=c(4,5,6,7,8),x2=c(2,3,4,5,6))
data_frame
# accessing only first row
data_frame[1,]
# accessing only first column
data_frame[,1]
# accessing first row and first column
data_frame[1,1]

#The following example creates a list object and accesses its elements.
list_obj<-list(data=data_frame,vec=elem10)
list_obj
# accessing second element of the list_obj objects
list_obj[[2]]
#if we want to get access to the individual elements of list_obj[[2]]
list_obj[[2]][1]
list_obj[[2]][4]

