## Applying the split-apply-combine strategy

head(iris)
#we will use the split-apply-combine strategy to find the average width and length of sepal
#and petal for three different species of iris

#1.First we will split the dataset into three subsets according to the species of the flower.
iris_setosa<-subset(iris,Species=="setosa",select=c(Sepal.Length,Sepal.Width,Petal.Length,Petal.Width))
iris_setosa
iris_versicolor<-subset(iris,Species=="versicolor",select=c(Sepal.Length,Sepal.Width,Petal.Length,Petal.Width))
iris_versicolor
iris_virginica<-subset(iris,Species=="virginica",select=c(Sepal.Length,Sepal.Width,Petal.Length,Petal.Width))
iris_virginica

#2.Next, for each subset, we will compute the average width and length of the sepal and petal.
# Applying mean function to calculate mean
setosa<-colMeans(iris_setosa)
setosa
versicolor<-colMeans(iris_versicolor)
versicolor
virginica<-colMeans(iris_virginica)
virginica

#3.Finally, we will combine all the results to compare them with each other.
#Combining results
rbind(anuja=setosa,versicolor=versicolor,mahipal=virginica)

# Introducing the plyr and dplyr libraries
#we can implement the split-apply-combine approach on a data frame using three lines of code.
#The plyr package helps us to implement the approach in one line.

#  plyr's utilities
#the plyr package is that a single line of code can perform all the split, apply, and combine steps
library(plyr)
ddply(iris, .(Species), function(x) colMeans(x[-5]))
#ddply() is a function from the plyr package, which takes a data frame as input and produces 
# a data frame as output
#The first argument is the name of the data frame. We put iris , since the iris dataset is 
# in the data frame structure
#The second argument "Species" is for a variable or variables, according to which we want to 
# split our data frame
#The third argument is a function that defines what kind of task we want to perform on each subset

#explain the intuitive nature of the input and output
# class of iris3 dataset is array
class(iris3) #iris3 dataset is the same data, but it is stored in a three-dimensional array format.
# dimension of iris3 dataset
dim(iris3)
#calculates the column mean for each species, with the input as an array, and the output as a
#data frame
iris_mean<-adply(iris3,3,colMeans)
iris_mean
class(iris_mean)
#again we will calculate the mean but this time output will be an #array
iris_mean<-aaply(iris3,3,colMeans)
iris_mean
class(iris_mean)#since the output is a # two dimensional array which represents # matrix
#again we will calculate the mean but this time output will be an #list
iris_mean<-alply(iris3,3,colMeans)
iris_mean
class(iris_mean)
   
    #Inputs and arguments
#Depending on the input type, there are two or three main arguments for the common
#functions: a*ply() , d*ply() , and l*ply() . The following are the main arguments
#for these common functions:
#•	 a*ply(.data, .margins, .fun, ..., .progress = "none")
#•	 d*ply(.data, .variables, .fun, ..., .progress = "none")
#•	 l*ply(.data, .fun, ..., .progress = "none")

# converting 3 dimensional array to a 2 dimensional data frame
library(plyr)
iris_data<-adply(iris3,.margins = 1)#Slices up a row by specifying .margins = 1
iris_data<-adply(iris3,.margins = 2)#Slices up a column by specifying .margins = 2
iris_data<-adply(iris3,.margins = c(1,2))#Slices up the individual cells by specifying .margins = c(1,2)
iris_data
class(iris_data)
str(iris_data)

   #Multiargument functions
#we will generate random numbers using default R functions, such as the forloop, and also using the mlply() function from the plyr
#package.
#define parameter set
parameter_data<-data.frame(n=c(25,50,100,200,500),mean=c(0,2,3.5,2.5,0.1),sd=c(1,1.5,2,5,2))
parameter_data
#random normal variate generate using base R
# set seed to make the example reproducible
set.seed(12345)
# initialize blank list object to store the generated variable
data<-list()
for(i in 1:nrow(parameter_data))
{
  data[[i]]<-rnorm(n=parameter_data[i,1],mean=parameter_data[i,2],sd=parameter_data[i,3])
}
# estimating mean from the newly generated data
estmean<-lapply(data,mean)

estmean
# Performing same task as above but this time use plyr package
library(plyr)
data_plyr<-mlply(parameter_data,rnorm)
estmean_plyr<-llply(data_plyr,mean)
estmean_plyr

  

       #Comparing base R and plyr
# we are interested in producing five-number summary statistics for each variable group by species. The five numbers will be 
#minimum, mean, median, maximum, and standard deviation.The output will be a list of data frames.

# Function to calculate five number summary
fivenum.summary<-function(x)
{
  result<-data.frame(min=apply(x,2,min),mean=apply(x,2,mean),median=apply(x,2,median),max=apply(x,2,max))
return(result)
}
#Here, we can see how we calculate the summaries for the five numbers using a for loop, with default R:
# initialize the output list object
all_stats<-list()
for (i in 1:dim(iris3)[3])
{
  sub_data<-iris3[,,1]
all_stats_species<-fivenum.summary(sub_data)  
all_stats[[i]]<-all_stats_species

}
# class of the output object
class(all_stats)
all_stats

#Let's calculate the same statistics, but this time using the alply() function from the plyr package:
all_stats<-alply(iris3,3,fivenum.summary)
class(all_stats)
all_stats



             ##Powerful data manipulation with dplyr
#Filtering and slicing rows
install.packages(dplyr)
#command to install from rstudio repo
#install.packages('dplyr', dependencies=TRUE, repos='http://cran.rstudio.com/')
library(dplyr)
filter(iris,Species=="virginica") # we want to just see all the observations under the virginica species
                              #The filter() function allow us to perform this task
#We could also create a data frame with sepal length less than 6 cm and sepal width less than or equal to 2.7 cm
filter(iris,Species=="virginica" , Sepal.Length<6 , Sepal.Width<=2.5)
#it can also write by "&"
filter(iris,Species=="virginica" & Sepal.Length<6 & Sepal.Width<=2.5)
#We could also extract the subset of a data frame using the slice() function. If we want to subset the first 10 observations, 
#the last 10 observations, or even the 95 th to 105 th observation
slice(iris,1:10)
slice(iris,140:150)
slice(iris,95:105)

#Arranging rows
#To sort the whole data frame based on a single variable or multiple variables, we could use the arrange() function
#We could sort the dataset according to the lowest length of sepal to the highest length of sepal
arrange(iris,Sepal.Length)
#We could also sort the dataset by sorting the data frame for sepal length and then for sepal width
arrange(iris,Sepal.Length,Sepal.Width)
#If we want to sort the data frame in ascending order for sepal length, but descendingorder for sepal width, we can use the desc()
#function from this package
arrange(iris,Sepal.Length,desc(Sepal.Width))

#Selecting and renaming
#Selecting a few columns could make the analysis process less complicated. We could easily select a smaller number of columns from a data frame
select(iris,Species,Sepal.Length,Sepal.Width)
#We could also change the column name using the rename() function
rename(iris,SL=Sepal.Length,SW=Sepal.Width)

#Adding new columns
#we need to create new columns for the purpose of analysis
#we want to convert the width and length of sepal and petal from centimeter to meter, we could use the mutate() function
mutate(iris,SLm=Sepal.Length/100,SWm=Sepal.Width/100)
#Also, we could standardize these variables in the following way
mutate(iris, SLsd=(Sepal.Length-mean(Sepal.Length))/sd(Sepal.Length),
       SWsd= (Sepal.Width-mean(Sepal.Width))/sd(Sepal.Width),
       PLsd=(Petal.Length-mean(Petal.Length))/sd(Petal.Length),
       PWsd= (Petal.Width-mean(Petal.Width))/sd(Petal.Width))
#If we want to keep only the new variables and drop the old ones, we could easily use the transmute() function
transmute(iris, SLsd=(Sepal.Length-mean(Sepal.Length))/sd(Sepal.Length),
          SWsd= (Sepal.Width-mean(Sepal.Width))/sd(Sepal.Width),
          PLsd=(Petal.Length-mean(Petal.Length))/sd(Petal.Length),
          PWsd= (Petal.Width-mean(Petal.Width))/sd(Petal.Width) )

#Selecting distinct rows
#Sometimes, we might encounter duplicate observations in a data frame. The distinct() function helps eliminates these observations
distinct(iris,Species,Petal.Width)

#Column-wise descriptive statistics
#We could summarize different variables based on different summary statistics using the summarise() function
#we summarized the length and width of sepal and petal by calculating their average
library(dplyr)
summarise(iris,meanSL=mean(Sepal.Length),meanSW=mean(Sepal.Width),meanPL=mean(Petal.Length),meanPW=mean(Petal.Width))

#Group-wise operations
#If we want to use a group-wise operation on different columns,we need to use a combination of the group_by() function
iris.data<-group_by(iris,Species)
summarize(iris.data, count=n(),meanSL= mean(Sepal.Length),meanSW=mean(Sepal.Width),meanPL=mean(Petal.Length),meanPW=mean(Petal.Width))

#Chaining
iris
iris.data<-group_by(iris,Species)
iris.data.selected<-select(iris.data,Species,Sepal.Length,Sepal.Width)
iris.data.selected.summarize<-summarize(iris.data.selected,meanSL=mean(Sepal.Length),sdSL=sd(Sepal.Length),meanSW=mean(Sepal.Width),sdSW=sd(Sepal.Width))
filter(iris.data.selected.summarize,meanSL==max(meanSL)|meanSW==max(meanSW))
#The dplyr package has a nice operator that prevents us from saving anew data frame each time we perform an action on it.
#This operator is called the %>% chain operator
#When we have a script file with a huge number of lines, this feature comes in handy
#This also saves us the effort of writing an additional data frame name each time
iris %>%
  group_by( Species) %>%
  select(Sepal.Length, Sepal.Width)%>%
  summarise( meanSL=mean(Sepal.Length),sdSL=sd(Sepal.Length),meanSW= mean(Sepal.Width),sdSW= sd(Sepal.Width)) %>%  
  filter(meanSL==max(meanSL) | meanSW==max(meanSW))
