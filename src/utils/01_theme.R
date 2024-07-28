# ~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~
#      /\_/\
#     ( o.o )
#      > ^ <
#
# Author: Johan Hanekom
# Date: July 2024
#
# ~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~

# -----------------// FONT //-----------------

google_font <- "Lato"
font_add_google(google_font, google_font)
showtext_auto()

# -----------------// COLOR PALETTE //-----------------

color_blue <- "#273b8d"
color_light_blue <- "#02acba"
color_red <- "#be1e2d"
color_light_grey <- "#c0c5cb"
color_dark_grey <- "#3F3A34"

color_palette <- c(
  color_blue, color_light_blue, color_red, color_light_grey, color_dark_grey,
  "#D8C472", "#4A4ACC", "#B3EFB2", "#AA78A6", "#41E1D2",
  "#9a8c98", "#E8E288", "#1D3461", "#F7C1BB", "#7280D9",
  "#EDD4B2", "#FD5345", "#BFB6BB", "#306B34", "#D499B9",
  "#C7F0BD", "#DDA448", "#F2542D", "#43AA8B", "#95B8D1"
)

# -----------------// CUSTOM SCALES //-----------------

pretty_x_scale_continuous <- scale_x_continuous(
  breaks = scales::pretty_breaks(),
  expand = expansion(mult = c(0.02, 0.05)),
  labels = scales::label_comma(big.mark = " ")
)

pretty_y_scale_continuous <- scale_y_continuous(
  breaks = scales::pretty_breaks(),
  expand = expansion(mult = c(0.02, 0.05)),
  labels = scales::label_comma(big.mark = " ")
)


# -----------------// CUSTOM THEME //-----------------

my_custom_theme <- function() {
  current_year <- format(Sys.Date(), "%Y")
  company_name <- "Johan"

  theme <- theme_minimal() +
    theme(
      text = element_text(
        family = google_font,
        face = "plain",
        colour = "black",
        size = 15
      ),
      plot.title = element_text(
        family = google_font,
        face = "plain",
        colour = "black",
        size = 22,
        hjust = 0,  # Left-aligned
        vjust = 0.5,
        angle = 0,
        lineheight = 1.2
      ),
      plot.subtitle = element_text(
        family = google_font,
        face = "italic",
        colour = "black",
        size = 16,
        hjust = 0,  # Left-aligned
        vjust = 0.5,
        angle = 0,
        lineheight = 1.2
      ),
      plot.title.position = "plot",
      legend.margin = margin(r = 0),
      plot.caption = element_text(
        color = "#3F3A34",
        face = "italic",
        family = google_font,
        size = 12,
        hjust = 1,  # Right-aligned
        vjust = 0.5,
        angle = 0,
        lineheight = 1.2
      )
    )
  
  color_scale <- scale_color_manual(values = color_palette)
  fill_scale <- scale_fill_manual(values = color_palette)
  basic_labs <- labs(
    caption = paste("©", current_year, company_name)
  )
  
  list(
    theme,
    color_scale,
    fill_scale,
    basic_labs
  )
}

# -----------------// LOGO ON PLOT //-----------------


add_logo <- function(
    plot_path,
    logo_path = file.path("src", "resources", "logo.png"),
    logo_size = 0.2,
    position = c("top", "right")
) {
  # Validate the position argument
  valid_positions <- list(
    top = c("left", "center", "right"),
    center = c("left", "center", "right"),
    bottom = c("left", "center", "right")
  )
  
  if (!(position[1] %in% names(valid_positions)) || !(position[2] %in% valid_positions[[position[1]]])) {
    stop("Invalid position argument. Possible values are: 
         c('top', 'left'), c('top', 'center'), c('top', 'right'),
         c('center', 'left'), c('center', 'center'), c('center', 'right'),
         c('bottom', 'left'), c('bottom', 'center'), c('bottom', 'right').")
  }
  
  logo <- image_read(logo_path)
  plot_image <- image_read(plot_path)
  
  calculate_position <- function(pos) {
    x <- switch(
      pos[2],
      "left" = 0,
      "center" = 0.5,
      "right" = 1
    )
    
    y <- switch(
      pos[1],
      "top" = 1,
      "center" = 0.5,
      "bottom" = 0
    )
    
    hjust <- switch(
      pos[2],
      "left" = 0,
      "center" = 0.5,
      "right" = 1
    )
    vjust <- switch(
      pos[1],
      "top" = 1,
      "center" = 0.5,
      "bottom" = 0
    )
    
    list(x = x, y = y, hjust = hjust, vjust = vjust)
  }
  
  pos <- calculate_position(position)
  
  logo_plot <- ggdraw() +
    draw_image(
      logo,
      x = pos$x,
      y = pos$y,
      hjust = pos$hjust,
      vjust = pos$vjust,
      width = logo_size,
      height = logo_size
    )
  
  # Combine the plot image and the logo using cowplot
  combined_plot <- ggdraw() +
    draw_image(plot_image) +
    draw_image(
      logo,
      x = pos$x - (logo_size * pos$hjust),
      y = pos$y - (logo_size * pos$vjust),
      width = logo_size,
      height = logo_size
    )
  return(combined_plot)
}

# -----------------// DEFAULT SAVE PLOT //-----------------

save_plot <- function(
    plot,
    name,
    dir = OUTPUT_PLOTS_DIR,
    type = "png",
    quality = 400,
    ...
) {
  file_name <- paste0(name, ".", type)
  file_path <- file.path(dir, file_name)
  
  message("Saving plot to: ", file_path)
  ggsave(
    file_path,
    plot = plot,
    width = 1280,
    height = 960,
    dpi = quality,
    units = "px",
    bg = "white",
    ...
  )
}


process_plot <- function(
    plot,
    name,
    include_logo = TRUE,
    type = "png",
    logo_path = file.path("src", "resources", "logo.png"),
    logo_size = 0.1,
    logo_position = c("top", "right"),
    ...
) {
  if (include_logo){
    # Reason for saving before adding the logo:
    # R has a strange bug where it would increase the axis margin as soon as
    # a logo was added upon saving. The solution was to first save, then load
    # it back in and then save it again.

    temp_plot_path <- file.path(tempdir(), paste0(name, "_temp.", type))
    
    save_plot(plot, name = paste0(name, "_temp"), dir = tempdir(), type = type, ...)
    
    plot_with_logo <- add_logo(
      temp_plot_path,
      logo_path = logo_path,
      logo_size = logo_size,
      position = logo_position
    )
    
    save_plot(plot_with_logo, name, type = type, ...)
    
    file.remove(temp_plot_path)
    message("Removed temporary plot file: ", temp_plot_path)
  } else {
    save_plot(plot, name, type = type, ...)
  }
}

