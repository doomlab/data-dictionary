#write out because you need a csv in the folder
write.csv(mtcars, "mtcars.csv", row.names = F)

#set working directory
setwd("~/OneDrive - Missouri State University/RESEARCH/2 projects/data-dictionary/erin")
###change this to the thing that's fancy

#load the library
library(dataspice)

#start with create_spice
create_spice()

#create a list of files to read
data_files <- list.files(path = getwd(), #where the files are stored 
                         pattern = ".csv",
                         full.names = TRUE) #what type of files they are


# Attributes --------------------------------------------------------------

#prep and fill in attributes from base files
prep_attributes(data_path = data_files,
                attributes_path = paste(getwd(), "/data/metadata/attributes.csv",
                                        sep = ""))

#update the attributes with shiny app
edit_attributes(filepath = "data/metadata/attributes.csv",
                outdir = paste(getwd(), "/data/metadata/", sep = ""))


# Access ------------------------------------------------------------------

#prep the access file
prep_access(data_path = getwd(), #maybe real?
            access_path = paste(getwd(), "/data/metadata/access.csv",
                                sep = ""))

edit_access(filepath = "data/metadata/access.csv",
            outdir = paste(getwd(), "/data/metadata/", sep = ""))



prep_biblio()
prep_coverage()

write_spice() 
build_site()