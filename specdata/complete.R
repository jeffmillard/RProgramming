complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
## ===========================================================
## make sure we are in the base directory
datapath <- paste0("../", directory, "/") 
##

## get the list of ALL csv files from 'directory'
specList <- list.files(path = datapath, pattern = "csv")

## now open all csv files using lapply (files, read.csv)
## results in a matrix
## do not subset !!
subdataset <- lapply(specList[id], read.csv)

## put results in a dataframe
specDF <- do.call(rbind,subdataset)

## generate a data.table of only complete cases
goodrecords <- data.table(specDF[complete.cases(specDF),])

## use .N to count number of complete cases per sensor
sumgood <- as.data.frame(goodrecords[, .N, by=ID])
names(sumgood) <- c("id", "nobs")

## make a new vector or dataframe
includevacuous <- data.frame(id, 0:0)
names(includevacuous) <- c("id", "nobs")

for(i in seq_along(sumgood$id)) {
  includevacuous$nobs[which(includevacuous$id %in% sumgood$id[i])] <- sumgood$nobs[i]
}

## ## setnames(sumgood, c("ID", "N"), c("id", "nobs"))
## sumgood
includevacuous

}