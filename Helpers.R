#+++++++++++++++++++++++++++
# xlsx.writeMultipleData
#+++++++++++++++++++++++++++++
# file : the path to the output file
# ... : a list of data to write to the workbook

xlsx.writeMultipleData <- function (file, ...)
{
  require(xlsx, quietly = TRUE)
  objects <- list(...)
  fargs <- as.list(match.call(expand.dots = TRUE))
  objnames <- as.character(fargs)[-c(1, 2)]
  nobjects <- length(objects)
  for (i in 1:nobjects) {
    if (i == 1)
      write.xlsx(objects[[i]], file, sheetName = objnames[i])
    else write.xlsx(objects[[i]], file, sheetName = objnames[i],
                    append = TRUE)
  }
}

### This function removes anythin within a parentheses in the club name 
removeParen <- function(x){
  as.factor(gsub("\\s*\\([^\\)]+\\)","",as.character(x)))
}

#.__                         
#|  |   _____ _____    ____  
#|  |  /     \\__  \  /  _ \ 
#|  |_|  Y Y  \/ __ \(  <_> )
#|____/__|_|  (____  /\____/ 
#           \/     \/        


