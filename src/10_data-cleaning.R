# ~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~
#      /\_/\
#     ( o.o )
#      > ^ <
#
# Author: Johan Hanekom
# Date: July 2024
#
# ~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~

# -----------------// READ IN RAW FILE //-----------------

board_games_raw <- as_tibble(read.csv(file.path(DATA_RAW_DIR, "board_games.csv")))

# -----------------// CATEGORICAL VARIABLES //-----------------

categorical_variables <- board_games_raw %>%
  select(
    game_id,
    name,
    family,
    expansion,
    category,
    artist,
    designer
  ) %>%
  gather(
    key="type",
    value="value",
    -game_id,
    -name
  ) %>%
  filter(!is.na(value)) %>%
  separate_rows(value, sep=",") %>%
  arrange(game_id)

save_to_processed(categorical_variables, "01_caregtorical_variables.rds")

# -----------------// CATEGORICAL COUNTS //-----------------

categorical_counts <- categorical_variables %>%
  count(type, value, sort=TRUE)

save_to_processed(categorical_counts, "02_categorical_counts.rds")

# Save as csv
write_csv(categorical_counts, file.path(OUTPUT_DATA_DIR, "02_categorical_counts.csv"))

# ~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~