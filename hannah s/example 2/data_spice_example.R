#set working directory
#save this file in a folder you want to use
#this code sets up the working directory as the place this file is saved
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

#load the library
library(dataspice)

#start with create_spice
#this creates the folders necessary for what you are doing
create_spice()

#move your files into the data folder that was just created

#create a list of files to read
#path is where the files are stored, should be data folder
#pattern is the type of file, csv/sav/etc.
#full.names allows you to keep the full path you are using
data_files <- list.files(path = paste(getwd(), "/data", sep = ""),  
                         pattern = ".csv",
                         full.names = TRUE) 

# Attributes --------------------------------------------------------------

#prep and fill in attributes from base files
#data_path is where the files are stored
#attributes path should be data/metadata/attributes.csv because of create_spice
prep_attributes(data_path = data_files,
                attributes_path = paste(getwd(), "/data/metadata/attributes.csv",
                                        sep = ""))

#update the attributes with shiny app
edit_attributes(filepath = "data/metadata/attributes.csv",
                outdir = paste(getwd(), "/data/metadata/", sep = ""))

# Access ------------------------------------------------------------------

#prep the access file
#the current version does not work in dataspice
#use this source file to update it to something that works
source("prep_access.R")
prep_access(data_path = paste(getwd(), "/data", sep = ""), 
            access_path = paste(getwd(), "/data/metadata/access.csv",
                                sep = ""))

#Shiny app to edit the names of the files 
edit_access(filepath = "data/metadata/access.csv",
            outdir = paste(getwd(), "/data/metadata/", sep = ""))


# Bibliography ------------------------------------------------------------

#install maps package for maps
edit_biblio(filepath = paste(getwd(), "/data/metadata/biblio.csv", sep = ""),
            outdir = paste(getwd(), "/data/metadata/", sep = ""), 
            outfilename = "biblio")


# Creators ----------------------------------------------------------------

#edit creator information
edit_creators(filepath = paste(getwd(), "/data/metadata/creators.csv", sep = ""),
              outdir = paste(getwd(), "/data/metadata/", sep = ""), 
              outfilename = "creators", 
              numCreators = 1)

creators_fix = read.csv(paste(getwd(), "/data/metadata/creators.csv", sep = ""))
colnames(creators_fix)[4] = "affiliation"
write.csv(creators_fix, 
          paste(getwd(), "/data/metadata/creators.csv", sep = ""), 
          row.names = F)

# Finish Spice ------------------------------------------------------------

#this creates overall file
write_spice() 

#creates website for data
build_site()
