#########################################################
# UK CENSUS 2021 Preliminary data for England and Wales #
#########################################################

library(data.table)
library(sf)

save_as_rda <- function(y, fn){
  assign(fn, y)
  save( list = fn, file = file.path('data', paste0(fn, '.rda')), version = 3, compress = 'gzip' )
}

# LOOKUPS
ye <- fread('https://opendata.arcgis.com/api/v3/datasets/6a41affae7e345a7b2b86602408ea8a2_0/downloads/data?format=csv&spatialRefId=4326')
yu <- fread('https://opendata.arcgis.com/api/v3/datasets/7df3fe50816e4cb6b3147a9d91572106_0/downloads/data?format=csv&spatialRefId=4326')
y <- rbindlist(list( ye[, FID := NULL], yu[substr(CTRY21CD, 1, 1) == 'W', .(LAD21CD, LAD21NM)] ), use.names = TRUE, fill = TRUE)
y[, c('CTRY', 'CTRYn') := .('E92000001', 'England')][substr(LAD21CD, 1, 1) == 'W', c('CTRY', 'CTRYn') := .('W92000004', 'Wales')]
setnames(y, c('LAD', 'LADn', 'RGN', 'RGNn', 'CTRY', 'CTRYn'))
setorder(y, 'LAD')

# LAD Boundaries
yb <- st_read('https://opendata.arcgis.com/api/v3/datasets/4f47ca74ff0a470cb4128905a38e1b35_0/downloads/data?format=kml&spatialRefId=4326') |> 
          subset(substr(LAD21CD, 1, 1) %in% c('E', 'W'), select = c('LAD21CD', 'LONG', 'LAT', 'Shape__Area')) |> 
          setnames(1:4, c('LAD', 'x_lon', 'y_lat', 'area')) |> 
          rmapshaper::ms_simplify(0.2)
y <- setDT(yb |> st_drop_geometry())[y, on = 'LAD']
y[, area := area / 1e6]
yb <- yb |> subset(select = 'LAD')
save_as_rda(yb, 'LAD')
save_as_rda(y, 'lookups')
Rfuns::dd_dbm_do('uk_census_2022', 'w', 'lookups', y)

# RGN Boundaries
ybr <- rbind(
        rmapshaper::ms_dissolve(yb |> merge(y[, .(LAD, RGN)]) |> subset(!is.na(RGN)), 'RGN'),
        rmapshaper::ms_dissolve(yb |> merge(y[, .(LAD, RGN)]) |> subset(substr(LAD, 1, 1) == 'W'), 'RGN')
)
save_as_rda(ybr, 'RGN')

# Population




# Households



rm(list = ls())
gc()

