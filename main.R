# ~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~
#      /\_/\
#     ( o.o )
#      > ^ <
#
# Author: Johan Hanekom
# Date: July 2024
#
# This is the main pipeline file of the project and orchestrates the
# the order of file execution
#
# ~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~


# -----------------// PIPELINE EXCECUTION //-----------------

SCRIPT_DIR = "src"
run_r <- function(filename, path = SCRIPT_DIR){
  source(file.path(path, filename))
}

# Setup
run_r("00_renv.R")
run_r("01_library-import.R")
run_r("02_config.R")

# Data cleaning steps
run_r("10_data-cleaning.R")

# Data visualization steps
run_r("20_data-visualization.R")

# ~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~