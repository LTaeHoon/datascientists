rankall <- function(outcome, num = "best") {
  ## Read outcome data
  ## Check that state and outcome are valid
  ## For each state, find the hospital of the given rank
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  #set wdrking directory
  setwd("E:\\th_R")
  #data 읽기
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  library(dplyr)
  
  data <- unique(select(data,State))
  data <- arrange(data,State)
  
  cnt <-1
  end <- nrow(data)
  resultdata <-data.frame("hospital"=character(0),"state"=character(0))
  
  while(cnt<=end){
    row <- rankhospital(data[cnt,],outcome,num)
      
    # if(row =0){
    #  row <- "NA"
    # }
    newdata <- data.frame("hospital"=row[1],"state"=data[cnt,])
    resultdata <- rbind(resultdata,newdata)
    cnt <- cnt+1
  }
  
  resultdata

}