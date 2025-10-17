# R startup file

####************************************************************************************************
                                     ####*options*####
####************************************************************************************************
options(repos = c(CRAN = 'https://packagemanager.posit.co/cran/2023-12-21'))

# turn warnings into errors to be cautious
# options(warn=2)
options(debug=TRUE) # self-defined debug mode for jerry's functions
options(width=10000) # for cat()
# https://stackoverflow.com/a/41905951/2292993
options(tibble.print_max = Inf)

####************************************************************************************************
                                     ####*stats*####
####************************************************************************************************
library(lme4)
library(MASS)
library(boot)
# library(nlme)
library(lattice)

####************************************************************************************************
                                     ####*tidyverse*####
####************************************************************************************************
library(magrittr)
library(dplyr)
library(tidyr)
library(purrr)
library(tibble)
library(stringr)
library(ggplot2)

####************************************************************************************************
                                     ####*fonts*####
####************************************************************************************************
library(extrafont)
# font_import() # run only once when installing extrafont
# loadfonts() # said to run every R session, but seems library(extrafont) takes care of it
# run loadfonts() if one encounters "polygon edge not found" during ggploting 
# or maybe loadfonts() does not fix the occasional polygon error; simply re-run ggploting does
# see more at https://github.com/wch/extrafont/

####************************************************************************************************
                                     ####*jerry's own packages*####
####************************************************************************************************
# library(sjmisc) # not to deal with attr. As of Sat, Jan 13 2018 removed dependence, I do not need it anymore
library(ezR)

## exit without prompt to save workspace image
# exit <- function() { q("no") }

# for ez.selfupdate
if (file.exists('~/Downloads/tmp.rda')) {
    load('~/Downloads/tmp.rda'); 
    try({
        setwd(pththismoment); 
        rm(list=c('pththismoment'), envir = .GlobalEnv);
    })
    unlink('~/Downloads/tmp.rda')
}

####*************************************************************************************************
                                      ####*finance*####
####*************************************************************************************************
# library(fzR)

####************************************************************************************************
                                     ####*first last*####
####************************************************************************************************
# cat(rep("\n",50)) # "visually" clear
.First <- function() {
    # cat(sprintf("\nWelcome to R! Successfully imported .Rprofile at %s!\n", date()))
    cat(R.version.string)
    cat(sprintf("\nCurrent Repository (ez.repo): %s",toString(getOption("repos"))))
    cat(sprintf("\nInstalled Packages (ez.ver): %d",nrow(utils::installed.packages())))
    cat(sprintf("\nUsing Library (ez.env): %s\n",paste0(.libPaths(),collapse = '; ')))
    cat("source('xxx.R')--preferred, still within R after completion or Rscript xxx.R\n")
    cat(sprintf("Working Directory: %s\n", getwd()))
    #cat("\nTo finish without saving workspace, type 'exit()'\n\n")
}
# .Last <- function()  cat("\n   Goodbye from Jerry!\n\n")
