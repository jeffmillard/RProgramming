pollutantmean <- function(directory, pollutant, id = 1:332) {
  ##
  ## -----------------------------------------------------------
  ## Argument Description
  ## -----------------------------------------------------------
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## -----------------------------------------------------------
  ## Function Output
  ## -----------------------------------------------------------
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  
  ## -----------------------------------------------------------
  ## Function Flow
  ##
  ##  1. Build Data Set
  ##      (Make sure you are in the right directory !!!)
  ##      A. Build list of csv files using list.files()
  ##      B. Read csv files using sapply (x, read.csv)
  ##      C. Subset data using ID
  ##
  ##  2. Use do.call(rbind, ...) to make data frame
  ##
  ##  3. call the mean function
  
  ## ===========================================================
  ## make sure we are in the base directory
  datapath <- paste0("../", directory, "/") 
  ##
  
  ## get the list of ALL csv files from 'directory'
  specList <- list.files(path = datapath, pattern = "csv")
 
  ## now open all csv files using lapply (files, read.csv)
  ## results in a matrix
  subdataset <- lapply(specList[id], read.csv)
  
  ## put results in a dataframe
  specDF <- do.call(rbind,subdataset)
  
  ## take mean of selected pollutant, rounded to 3 decimal places
  round(mean(specDF[,pollutant], na.rm=TRUE),3)
}