# ~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~
#      /\_/\
#     ( o.o )
#      > ^ <
#
# Author: Johan Hanekom
# Date: July 2024
#
# ~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~

message("Reading in environment variables")

# -----------------// NEW USERS //-----------------

# The renv package is used as a dependency manager!
# It is highly recommended to have it since some collaborators might
# have different versions of packages on their locals. 
# This ensures complete reproducibility across all devices.
# The installation is much slower, but the payoff is great.
# If you're not keen to have it, just set the DISABLE_RENV env variable
# to True (not case sensitive).

if (!file.exists(file.path("renv", "library"))) {
  message("Setting up new project environment...")
  if (tolower(Sys.getenv(x="DISABLE_RENV", unset="false"))=="true"){
    message("renv is disabled")
  } else {
    renv::restore()
  }
}

# Also, please don't delete the lock file!

# -----------------// READING IN ENV VARIABLES //-----------------

# The `.Renviron` is actually loaded on the start of every session
# This just ensures that we always have the latest copy
# in case we may edit it in the middle of our session
readRenviron(".Renviron")

# Read in the variables (it's best practice to also set a default and to cast)
# It's also best practice to have an example text file so that users can
# get an idea of the details they need to set up. 
MY_COOL_API_KEY = as.character(Sys.getenv("MY_COOL_API_KEY", unset=""))

# NOTE: The actual best practice is to never save the very sensitive
# things as variables in the session. If you do, don't save the .RData to git

# ~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~