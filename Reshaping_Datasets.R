                                              #Reshaping Datasets
#rows indicate records,and columns indicate variables, characteristics, or attributes
#Long layout
#the dataset is arranged in such a way that a single subject'sinformation is stored in multiple rows. We need a composite 
#identification variable to identify a unique row
#example
#sid exmterm math literature language
# 1    1      50      40       70
# 1    2      65      45       80
# 2    1      75      55       75
# 2    2      69      59       78
#if we consider both sid and exmterm ,each row can be identified uniquely. This layout is known as the long layout
# A demo dataset "students" with typical layout. This data
# contains two students' exam score of "math", "literature"
# and "language" in different term exam.
students<-data.frame(sid=c(1,1,2,2),exmterm=c(1,2,1,2),literature=c(50,65,75,69),language=c(70,80,75,78))
students

#Wide layout
#example
#sid math.1 literature.1 language.1 math.2 literature.2 language.2
# 1   50        40           70      65        45         80
# 2   75        55           75      69        59         78

#New layout of a dataset
library(reshape)
# Example of molten data
#The melt.data.frame function converts the wide data to a long (molten) form,and the new layout will contain only the
#identification variables, along with two other columns named variable and value
molten_student<-melt.data.frame(students,id.vars =c("sid","exmterm" ))
molten_student
#convert long data to a wide data form
library(reshape)
wide_student<-reshape(students,direction = "wide",idvar="sid",timevar = "exmterm")
wide_student
# Now again reshape to long format
long_student<-reshape(wide_student,direction = "long",idvar = "sid",timevar = "exmterm")
long_student

# melting data
students
# Melting by specifying both id and measured variables
library(reshape)
melt(students,id=c('sid','exmterm'),measured=c('math','literature','language'))
# Melting by specifying only id variables
melt(students,id=c('sid','exmterm'))
#whenever we use the melt function, all the measured variables should be of the same type: that is, 
#the measured variables should be either numeric , factor , character , or date .

#Missing values in molten data
library(reshape)
melt_data<-data.frame(subject=c("john smith","marry smith"),time=c(1,1,1,1,1,1),variable=c("age","age","weight","weight","height","height"),value=c(33,"",90,"",1.87,1.54))
melt_data
melt(smiths, na.rm = TRUE)
#To deal with the implicit missing value, it is good to use na.rm=TRUE with the melt function to remove the structural missing 
#value. If we do not specify na.rm=TRUE during melting, we have to specify this during data analysis.

#Casting molten data
#Once we have molten data, we can rearrange it in any layout using the cast function from the reshape package
#The basic casting formula is col_var_1+col_var_2 ~ row_var_1+ row_var_2,which describes the variables to appear in columns and rows
## Melting students data
molten_student<- melt(students,id.vars=c("sid","exmterm"))
molten_student
#Now use the cast function to return to the original data structure by specifying both row and column variables as follows:
cast(molten_student,sid+exmterm~variable)
#The following is the same operation, but specifying only row variables:
cast(molten_student,...~variable)
#We will now rearrange the data in such a way that sid is now a separate column for each student, as follows:
cast(molten_student,...~sid)
#We will rearrange the data again in such a way that exmterm is now a separate column for each term, as follows:
cast(molten_student,...~exmterm)
#Note that the column names of the last two examples are not valid column names because they contain numbers.
#This is a limitation of R.
#R cannot automatically label row or column names unambiguously, so we have to be careful about column names during analysis.

#The reshape2 package
#The melt function is pretty efficient at converting all data structures to molten data frames. The next step is to reshape themolten 
#data frame into either a data frame or array structure. In the reshape package, this task is done using only the cast function.
#The output of the cast function, whether a data frame or array, depends on how we put the formula.In the reshape2 package, we have the dcast
#function to produce the data frame as output and acast to produce an array from a molten data frame.
library(reshape2)
molten_student<-melt(students,id.vars = c("sid","exmterm"))
molten_student
#The basic casting formula is x_variable + x_2 ~ y_variable + y_2 ~ z_
#variable ~ . For the purpose of illustration, consider x_variable , x_2 as the first
#set of variables, y_variable , y_2 as the second set of variables, z_variable , z_2
#as the third set of variables, and so on. The first set of variables is used to make
#the row uniquely identifiable. For the molten dataset molten_students we are
#considering sid as first set of variable and variable as second set of variable in the following example:
dcast(molten_student,sid~variable)#right error-Aggregation function missing: defaulting to length
#To make the column uniquely identifiable using just the sid variable, we only need two rows:
dcast(molten_student,sid+exmterm~variable)
#This is also true for the acast function:
acast(molten_student,sid~variable)# right error-Aggregation function missing: defaulting to length
#Here, there is no sid variable in the data, because acast produces an array and the
#value of the sid variable is used as the row index for this data:
acast(molten_student,sid+exmterm~variable)
#The second set of variables is used to produce column name. The combination of the values of the second set of variables 
#is used as the column name of the output data frame in the dcast and acast functions:
dcast(molten_student,sid~variable+exmterm)
acast(molten_student,sid~variable+exmterm)
#The third set of variables is only applicable for the acast function since an array
#could go beyond two dimensions, but data frame is strictly restricted to two dimensions
acast(molten_student,sid~exmterm~variable)
