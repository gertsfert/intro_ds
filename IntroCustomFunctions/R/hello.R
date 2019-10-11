# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Cmd + Shift + B'
#   Check Package:             'Cmd + Shift + E'
#   Test Package:              'Cmd + Shift + T'

EnsurePackage <- function(x) {
  x <- as.character(x)

  if (!require(x, character.only = TRUE)) {
    install.packages(pkgs=x, repos="http://cran.r-project.org")
    require(x, character.only = TRUE)
  }
}

Numberize <- function(v) {
  # gets rid of commas and spaces and returns vector as numeric
  # assumes that 'v' is a list of data that can be treated as character strings
  v <- gsub(",", "", v) # get rid of commas
  v <- gsub(" ", "", v) # get rid of spaces

  return(as.numeric(v))
}


readCensus <- function(local) {
  if (local) {
    df <- read.csv("/Users/gertsfert/Documents/git/intro_ds/ch6/data/nst-est2011-01.csv")
  } else {
    urlToRead <-
      "http://www2.census.gov/programs-surveys/popest/tables/2010-2011/state/totals/nst-est2011-01.csv"
    df <- read.csv(url(urlToRead))
  }



  # remove junk columns and rows
  df <- df[9:59,1:5]

  # renaming columns
  colnames(df) <- c("stateName", "april10census", "april10base", "july10pop", "july11pop")

  # remove '.' (period) from each state observation
  df$stateName <- gsub("\\.", "", df$stateName)

  # convert columns to numeric
  df[2:5] <- lapply(df[,2:5], Numberize) # think this works?

  # remove old row names
  rownames(df) <- NULL

  return(df)
}
