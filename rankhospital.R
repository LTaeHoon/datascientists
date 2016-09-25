rankhospital<-function(state,outcome,num="best"){
  ## Read outcome data
  ## Check that state and outcome are valid
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  
  #set wdrking directory
  setwd("E:\\th_R")
  #data 읽기
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  library(dplyr)
  state.levels <- levels(factor(data$State))
  
  state_flag <- FALSE
  
  #check state
  for(i in 1:length(state.levels)){
    if(state==state.levels[i]){
      state_flag <- TRUE    
    }
  }
  
  if(!state_flag){
    stop("invaild state")
  }
  
  #check that outcome is vaild
  if(!((outcome=="heart attack")|(outcome=="heart failure")|(outcome=="pneumonia"))){
    stop("invaild outcome")
  }
  #입력된 state,outcome 값 기준으로 state, outcome 값 추출
  if(outcome=="heart attack"){
    #col = 11
    selected<-select(filter(data, State==state,Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack!='Not Available'),Hospital.Name,Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)
    selected$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack<-as.numeric(selected$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)
    # ordered <- arrange(selected,Hosital.Name,Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)
    ordered <- selected[order(selected$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack,selected$Hospital.Name),]
  }else if(outcome=="heart failure"){
    selected<-select(filter(data, State==state,Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure!='Not Available'),Hospital.Name,Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)
    selected$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure<-as.numeric(selected$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)
    # ordered <- arrange(selected,Hosital.Name,Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)
    ordered <- selected[order(selected$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure,selected$Hospital.Name),]  
  }else if(outcome=="pneumonia"){
    selected<-select(filter(data, State==state,Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia!='Not Available'),Hospital.Name,Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)
    selected$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia<-as.numeric(selected$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)
    # ordered <- arrange(selected,Hosital.Name,Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)
    ordered <- selected[order(selected$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia,selected$Hospital.Name),]  
  }  
  
  #result
    
  if(num=='best'){
    ordered[1,1]
  }else if(num=='worst'){
    ordered[nrow(ordered),1]
  }else{
    ordered[num,1]
  }
  
  
}