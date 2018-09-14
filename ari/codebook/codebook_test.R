#set working directory to current folder
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library(codebook)

#create codebook for data set (mtcars) - this takes a moment
#prints markdown into console (some seems to be missing... too long?) 
#adds figure folder with histogram for each variable
codebook(mtcars)

#next figure out how to save what prints to the console
#(aside from copying and pasting)
