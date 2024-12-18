## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(healthatlas)

## -----------------------------------------------------------------------------
ha_set("chicagohealthatlas.org")

## -----------------------------------------------------------------------------
ha_get()

## -----------------------------------------------------------------------------
topics <- ha_topics(progress = FALSE)
topics

## -----------------------------------------------------------------------------
subcategories <- ha_subcategories()
subcategories

## -----------------------------------------------------------------------------
ha_topics("diet-exercise")

## -----------------------------------------------------------------------------
coverage <- ha_coverage("HCSFVAP", progress = FALSE)
coverage

## -----------------------------------------------------------------------------
ease_of_access <- ha_data(
  topic_key = "HCSFVAP",
  population_key = "",
  period_key = "2022-2023",
  layer_key = "neighborhood"
)
ease_of_access

## -----------------------------------------------------------------------------
combinations_of_data <- ha_data(
  topic_key = c("POP", "UMP"),
  population_key = c("", "H"),
  period_key = c("2017-2021", "2018-2022", "invalid"),
  layer_key = "neighborhood"
)
combinations_of_data

## -----------------------------------------------------------------------------
library(tibble)
library(purrr)

# creating a table of data I want
metadata <- tribble(
  ~ topic_key, ~ population_key, ~ period_key, ~ layer_key,
  "POP",       "",               "2017-2021",  "neighborhood",
  "HCSFVAP",   "",               "2020-2021",  "neighborhood",
  "UMP",       "H",              "2017-2021",  "neighborhood",
)

metadata %>%
  pmap(ha_data)

## -----------------------------------------------------------------------------
layers <- ha_layers()
layers

## -----------------------------------------------------------------------------
community_areas <- ha_layer("neighborhood")
community_areas

## -----------------------------------------------------------------------------
ease_of_access <- ha_data(
  topic_key = "HCSFVAP",
  population_key = "",
  period_key = "2022-2023",
  layer_key = "neighborhood",
  geometry = TRUE
)
ease_of_access

## -----------------------------------------------------------------------------
library(ggplot2)

plot <- ggplot(ease_of_access) +
  geom_sf(aes(fill = value), alpha = 0.7) +
  scale_fill_distiller(palette = "GnBu", direction = 1) +
  labs(
    title = "Easy Access to Fruits and Vegetables within Chicago",
    fill = "Percent of adults who reported\nthat it is very easy for them to\nget fresh fruits and vegetables."
  ) +
  theme_minimal()
plot

## -----------------------------------------------------------------------------
point_layers <- ha_point_layers()
point_layers

## -----------------------------------------------------------------------------
grocery_stores <- ha_point_layer("7d9caf3c-75e6-4382-8c97-069696a3efbf")

## -----------------------------------------------------------------------------
plot +
  geom_sf(data = grocery_stores, size = 0.5)

