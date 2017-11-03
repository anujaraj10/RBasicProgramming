abc <- c(1,2,3,TRUE,FALSE)
abc
mode(abc)
abc<-c(1,2,TRUE,'a',FALSE,'A')
mode(abc)
is.numeric(abc)
is.character(abc)
mode(mean)
is.function(mean)
class(abc)
abc<-c(1,2,3,4,5)
set.seed(1234)
abc
character.obj<-c('a','c','d')
character.obj
is.factor(character.obj)
# Converting character object into factor object using as.factor()
factor.obj<-as.factor(character.obj)
factor.obj
is.factor(factor.obj)
is.character(factor.obj)
is.factor(character.obj)
class(factor.obj)
mode(factor.obj)
mode(character.obj)

# creating vector of numeric element with "c" function
num.obj<-c(1,2,3,4,5)
num.obj
num.vector<-c(1,2,3,4,5)
num.vector
mode(num.vector)
class(num.vector)
is.vector(num.vector)

# Vector with mixed elements,the resulting
#vector will be a character vector
num.vector<-c(1,2,3,'four',5)
num.vector
mode(num.vector)
class(num.vector)
is.vector(num.vector)

# combining multiple vectors
#vector with the name of
#each element
num.character<-c('a','b','d')
num.character
comb.vector<-c(num.vector,num.character)
mode(comb.vector)
class(comb.vector)
# creating named vector
xyz.vector<-c(x1=2,x2=4,x3=8,x4=16)
xyz.vector

# creating a vector of numbers and then converting it to logical
# and character
number.vector<-c(1,0,2,3,0,4,-1,5)
number.vector
number.logical<-as.logical(number.vector)
number.logical
number.character<-as.character(number.vector)
number.character
number.character<-as.logical(number.vector)
number.character
number.logical<-as.character(number.logical)
number.logical
number.logical<-as.logical(num.character) #R does not convert a character object into a
#logical object but, if we try to do this, all the resulting elements will be NA .
number.logical
number.numeric<-as.numeric(number.character)
number.numeric


#example of a vector
age<-c(10,20,30,40)
age
age[1]
age[2]
age[4]
logical<-c(TRUE,FALSE,TRUE,FALSE)
logical
age[logical] #logical vector will select only the elements of the age vector for which the logical
#vector is TRUE

#add another value inside an existing vector.
  height<-175
  height
  height[2]<-180 
  height
  height[3]<-160
  height[4]<-188
  height[5]<-190
  height
  
##Factor and its types
  #creating factor variable with only one argument with factor()
  factor1<-factor(c(1,2,3,4,5,6,7,8))
  factor1
  labels(factor1)
  labels(factor)
  #creating factor with user given levels to display
  factor2<-factor(c(1,2,3,4,5,6,7,8),labels=letters[1:8])
factor2
labels(factor2)
levels(factor2) #The input can be numeric or character, but the levels of factor will always be a characte


# creating numeric factor and trying to find out mean
#A factor could be numeric with numeric levels, but direct mathematical operations
#are not possible with this numeric factor
num.factor<-factor(c(1,2,3,4,5))
num.factor
mean(num.factor)


#To perform any mathematical operation, we need to convert the factor to its numeric counterpart
#if we use the as.numeric() function, it will only convert the internal values of the factors, not the desired values.
#we can first convert the factor into a character using as.character() and then use as.numeric()
factors<-factor(c(1,2,3,4,5,6))
factors
levels(factors)
#as.numeric() function only returns internal values of the factor > as.numeric(num.factor)
#so first convert factors into character
character<-as.character(factors)
character
#now convert factors into numeric 
numeric<-as.numeric(as.character(factors))
numeric
mean(numeric)
#other method
mean(as.numeric(as.character(factors)))


#Da#taframe
 #In an R data frame, we can store different types of variables, such as numeric, logical, factor, and character
 #Each column represents only one type of data: numeric, character, or logical. Each row represents case 
 #information across all columns.

#creating vector of different variables and then creating data frame
name<-c('guriya','chicku','bholu','golu','chhotu','lalu')
gender<-factor(c('female','female','male','male','male','male'))
degree<-c(10,9,8,7,6,5)
age<-c(26,24,24,23,22,20)
group<-data.frame(name,gender,degree,age)
group

class(name)
class(gender)
class(degree)
class(age)

class(group$name)
class(group$gender)# when we create data frames and any one of the column's classes is character, it automatically gets converted to factor
class(group$degree)
class(group$age)

#there is one argument,stringsAsFactors=FALSE,that allows us to prevent the automatic conversion of character to factor
group2<-data.frame(name,gender,degree,age,stringsAsFactors=FALSE)
group2
class(group2$name)# To access individual columns (variables) from a data frame, we can use a dollar ($) sign,along with the data frame name


##Matrix
 #To perform any mathematical operations, all columns of a matrix should be numeric
 #We can convert the data frame that we created earlier as diab.dat to a matrix using as.matrix()
 #but it is not suitable for mathematical operation
group3<- as.matrix(group)
group3
class(group3)
mode(group3)
#creating a matrix with numeric elements only
#To produce the same matrix over time we set a seed value
num.mat<-matrix(rnorm(9),ncol=3,nrow=3)
num.mat
class(num.mat)
mode(num.mat)
# matrix multiplication
t(num.mat) %*% num.mat


 ##Arrays
#example to store three matrices of order 2 x 2 in a single array object
mat.array=array(dim=c(2,2,3))
mat.array

# To produce the same results over time we set a seed value
mat.array[,,1]<-rnorm(4)
mat.array[,,2]<-rnorm(4)
mat.array[,,3]<-rnorm(4)
mat.array


 ##Lists
#Recalling the var1 , var2 , var3 , and var4 vectors, the data frame created using these
#vectors, and also recalling the array created in the Arrays section, we will create a list
name<-c('guriya','chicku','bholu','golu','chhotu','lalu')
gender<-factor(c('female','female','male','male','male','male'))
degree<-c(10,9,8,7,6,5)
age<-c(26,24,24,23,22,20)
group<-data.frame(name,gender,degree,age)#creating dataframe

mat.array[,,1]<-rnorm(4)
mat.array[,,2]<-rnorm(4)
mat.array[,,3]<-rnorm(4)
mat.array #creating array 

anuja.list<-list(ser1=name,ser2=gender,ser3=degree,ser4=age,ser5=group,ser6=mat.array)
anuja.list

#To access individual elements from a list object, we can use the name of that
#element or use double square brackets with the index of those elements.
anuja.list[[1]]
anuja.list[[5]]


 ##Missing values in R
#create a data frame with missing value
var1<-c(1,2,3,NA,4)#a numeric missing value is represented by NA
name<-c('guriya',NA,'bholu','golu','chhotu')#character missing values are represented by <NA>
var3<-data.frame(var1,name)
var3

is.na(var3$var1)#To test if there is any missing value present in a dataset (data frame), we can use is.na()
                #for each column
is.na(var3$name)
any(is.na(var3))
