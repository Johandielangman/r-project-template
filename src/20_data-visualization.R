# ~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~
#      /\_/\
#     ( o.o )
#      > ^ <
#
# Author: Johan Hanekom
# Date: July 2024
#
# ~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~

message("Data visualization...")

# -----------------// READ IN PROCESSED DATA //-----------------


categorical_counts <- load_from_processed("02_categorical_counts.rds")


# -----------------// CATEGORY PLOTS //-----------------

category_plot <- categorical_counts %>%
  filter(type == "category") %>%
  head(20) %>%
  mutate(value = fct_reorder(value, n)) %>%
  ggplot(aes(value, n)) +
  geom_col(fill=color_red) +
  coord_flip() +
  my_custom_theme() +
  labs(
    title = "Top Board Games",
    subtitle = "Top 20 by Category",
    y = "Number of Board Games",
    x = "Categories"
  ) +
  pretty_y_scale_continuous

process_plot(category_plot, "01_category_plot")

# ~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~