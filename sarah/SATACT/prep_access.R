prep_access = function (data_path = here::here("data"), access_path = here::here("data", 
                                                                   "metadata", "access.csv")) 
{
  if (!file.exists(data_path)) {
    stop("invalid path to data folder")
  }
  if (!file.exists(access_path)) {
    stop("access file does not exist. Check path or run create_spice?")
  }
  access <- readr::read_csv(access_path)
  fileNames <- tools::list_files_with_exts(data_path, exts = c("csv", 
                                                               "tsv"), full.names = TRUE)
  fileTypes <- vapply(fileNames, tools::file_ext, "")
  if (all(basename(fileNames) %in% unique(access$fileName))) {
    stop("Entries already exist in access.csv for fileNames: ", 
         paste(basename(fileNames), collapse = ", "))
  }
  access <- tibble::add_row(access, fileName = basename(fileNames), 
                            name = basename(fileNames), contentUrl = NA, fileFormat = fileTypes)
  readr::write_csv(access, path = access_path)
  message("The following fileNames have been added to the access file: ", 
          paste(basename(fileNames), collapse = ", "))
}
