# ~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~
#      /\_/\
#     ( o.o )
#      > ^ <
#
# Author: Johan Hanekom
# Date: July 2024
#
# This defines two functions that will save and load files from and to
# the processed data folder
#
# ~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~

# -----------------// SAVE TO PROCESSED //-----------------

save_to_processed <- function(object, file_name){
  if (!exists("DATA_PROCESSED_DIR")) {
    stop("DATA_PROCESSED_DIR is not defined")
  }

  message("Saving to ", file.path(DATA_PROCESSED_DIR, file_name))
  saveRDS(object, file.path(DATA_PROCESSED_DIR, file_name))
}

# -----------------// LOAD FROM PROCESSED //-----------------

load_from_processed <- function(file_name){
  if (!exists("DATA_PROCESSED_DIR")) {
    stop("DATA_PROCESSED_DIR is not defined")
  }

  message("Loading from ", file.path(DATA_PROCESSED_DIR, file_name))
  readRDS(file.path(DATA_PROCESSED_DIR, file_name))
}
