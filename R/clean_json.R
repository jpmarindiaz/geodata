# library(geojsonio)
# library(readr)
# library(dplyr)
# library(ggplot2)
# library(jsonlite)
#
#
#
# # arreglo topojson --------------------------------------------------------
#
#  json_file <- read_json('BARRIOS.json')
#
# leng_json <- length(json_file$objects$BARRIOS$geometries)
# for(i in 1:leng_json){
#   json_file$objects$BARRIOS$geometries[[i]]$id <- json_file$objects$BARRIOS$geometries[[i]]$properties$CODBARRIO
#   json_file$objects$BARRIOS$geometries[[i]]$properties <- json_file$objects$BARRIOS$geometries[[i]]$properties[c('NOMBRE', 'NOMDIS')]
#   names(json_file$objects$BARRIOS$geometries[[i]]$properties) <- c('name', 'distrito')
#   json_file
# }
#
# json_file <- rjson::toJSON(json_file)
#
# writeLines(json_file,'inst/geodata/esp/madrid-barrios.topojson')
#
# library(tidyverse)
# library(geojsonio)
#
# tj <- rgdal::readOGR("inst/geodata/esp/madrid-barrios.topojson")
# nms <- as.data.frame(topojson_read("inst/geodata/esp/madrid-barrios.topojson"))
# nms <- nms %>%
#   select(-geometry) %>%
#   dplyr::mutate(.id = 0:(nrow(.)-1))
#
# data_map <- fortify(tj) %>%
#   dplyr::mutate(.id = as.numeric(id)) %>%
#   dplyr::select(-id)
#
#
# info_cent <- data_map %>% group_by( .id) %>% summarise(lat = median(lat), lon = median(long))
# data_centroide <- nms %>% left_join(info_cent)
# data_centroide <- data_centroide[,c("id", "name", "distrito",  "lat", "lon")]
# write_csv(data_centroide, "inst/geodata/esp/madrid-barrios.csv")





# # Test --------------------------------------------------------------------
#
# topoData <- readLines("inst/geodata/esp/esp-municipalities.topojson") %>% paste(collapse = "\n")
# library(leaflet)
# lf <- leaflet() %>%
#   leaflet(options = leafletOptions(zoomControl = TRUE))
#
# lf %>%
#   addTopoJSON(topoData,
#               weight = 1,
#               color = '#000000',
#               fill = FALSE)


# shapefile ---------------------------------------------------------------

# library(sf)
# s.sf <- read_sf(dsn = "BARRIOS/BARRIOS.shp", layer = "BARRIOS")
#
# st_crs(s.sf)
# # shapefile  --------------------------------------------------------------
# s.sf.gcs <- st_transform(s.sf, "+proj=longlat +datum=WGS84")
# st_crs(s.sf.gcs)
#
# s.sp <- as(s.sf.gcs, "Spatial")
#
# raster::shapefile(s.sp, "BARRIOS.shp")
# library(leaflet)
# leaflet(s.sf.gcs) %>%
#   addPolygons() %>%
#   addTiles()
