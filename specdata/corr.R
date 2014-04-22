corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
## ===========================================================

        ## get the number of complete cases
        cx <- complete("specdata", 1:332)

        ## apply threshold criterion
        cx <- cc[,"nobs"] >threshold

        ## now try to read just those files
        ## make sure we are in the base directory
        datapath <- paste0("../", directory, "/") 

        ## get the list of ALL csv files from 'directory'
        specList <- list.files(path = datapath, pattern = "csv")

        ## subset this list according to threshold
        specList <- specList[cx]
        corvalue <- vector("numeric", length=0)

        ##try read and correlate one at a time
        if (length(specList) > 0) {
                corvalue <- c(1:length(specList))
                for(i in 1:length(specList)) {
                        subdataset <- lapply(specList[i], read.csv)
                        subDF <- specDF <- do.call(rbind,subdataset)
                        goodsub <- subDF[complete.cases(subDF),]
                        corvalue[i] <- cor(x=goodsub$nitrate,y=goodsub$sulfate)
                }
        }
corvalue
}