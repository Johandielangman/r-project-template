# ~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~
#      /\_/\
#     ( o.o )
#      > ^ <
#
# Author: Johan Hanekom
# Date: July 2024
#
# ~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~

message("Configuring project...")

# -----------------// FOLDER DIRECTORIES //-----------------

DATA_DIR <- "data"
DATA_PROCESSED_DIR <- file.path(DATA_DIR, "processed")
DATA_RAW_DIR <- file.path(DATA_DIR, "raw")

OUTPUT_DIR <- "output"
OUTPUT_DATA_DIR <- file.path(OUTPUT_DIR, "data")
OUTPUT_PLOTS_DIR <- file.path(OUTPUT_DIR, "plots")

ALL_DIRS <- c(DATA_PROCESSED_DIR, DATA_RAW_DIR, OUTPUT_DATA_DIR, OUTPUT_PLOTS_DIR)
for (dir in ALL_DIRS){
  if (!dir.exists(dir)){
    message("Creating directory: ", dir)
    dir.create(dir, recursive = TRUE)
  }
}

UTILS_DIR <- file.path(SCRIPT_DIR, "utils")

# -----------------// ADDITIONAL SETUP (E.G. THEMING) //-----------------

run_r("01_theme.R", path = UTILS_DIR)
run_r("02_save-and-load.R", path = UTILS_DIR)

# ~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~