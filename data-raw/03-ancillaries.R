###########################################################
# UK CENSUS 2021 Lookups and Boundaries England and Wales #
###########################################################

Rfuns::load_pkgs(dmp = FALSE, 'data.table', 'readxl', 'rmapshaper', 'sf')

dbn <- 'uk_census_2022'
save_as_rda <- function(y, fn, db = TRUE){
  if(db) dd_dbm_do(dbn, 'w', substring(fn, 2), y)
  assign(fn, y)
  save( list = fn, file = file.path('data', paste0(fn, '.rda')), version = 3, compress = 'gzip' )
}

# Ancillary tables
save_as_rda(fread('./data-raw/ctables.csv'), 'ctables')
save_as_rda(fread('./data-raw/cvars.csv'), 'cvars')

# ZONES [1]
tmpf <- tempfile()
download.file('https://www.arcgis.com/sharing/rest/content/items/b7cdab1c2ee14a3ba48a9916bb3e7177/data', tmpf)
y <- read_xlsx(tmpf, sheet = grep('LAD', excel_sheets(tmpf), value = TRUE)) |> 
      as.data.table()
unlink(tmpf)
y <- unique(y[, grep('LAD|UTLA', names(y), value = TRUE), with = FALSE])
setnames(y, c('LAD', 'LADn', 'UTLA', 'UTLAn'))
ye <- fread('https://opendata.arcgis.com/api/v3/datasets/6a41affae7e345a7b2b86602408ea8a2_0/downloads/data?format=csv&spatialRefId=4326')
y <- ye[, .(LAD = LAD21CD, RGN = RGN21CD, RGNn = RGN21NM)][y, on = 'LAD']
y <- y[substr(LAD, 1, 1) %in% c('E', 'W')]
y[, c('CTRY', 'CTRYn') := .('E92000001', 'England')][substr(LAD, 1, 1) == 'W', c('CTRY', 'CTRYn') := .('W92000004', 'Wales')]

# LAD Boundaries
yb <- st_read('https://opendata.arcgis.com/api/v3/datasets/4f47ca74ff0a470cb4128905a38e1b35_0/downloads/data?format=kml&spatialRefId=4326') |> 
          subset(substr(LAD21CD, 1, 1) %in% c('E', 'W'), select = c('LAD21CD', 'LONG', 'LAT', 'Shape__Area')) |> 
          setnames(1:4, c('LAD', 'x_lon', 'y_lat', 'area')) |> 
          ms_simplify(0.2)
y <- setDT(yb |> st_drop_geometry())[y, on = 'LAD']
y[, area := area / 1e6]
yb <- yb |> subset(select = 'LAD')
save_as_rda(yb, 'LAD', FALSE)
st_write(yb, './data-raw/LAD.kml', delete_layer = TRUE)

# ZONES [2]
setcolorder(y, names(dd_dbm_do(dbn, 'q', strSQL = "SELECT * FROM zones LIMIT 0")))
setorderv(y, c('CTRYn', 'RGNn', 'UTLAn', 'LADn'))
save_as_rda(y, 'czones')
fwrite(y, './data-raw/zones.csv')

# UTLA Boundaries
ybu <- ms_dissolve(yb |> merge(y[, .(LAD, UTLA)]), 'UTLA')
save_as_rda(ybu, 'UTLA', FALSE)
st_write(ybu, './data-raw/UTLA.kml', delete_layer = TRUE)

# RGN Boundaries
ybr <- rbind(
        ms_dissolve(yb |> merge(y[, .(LAD, RGN)]) |> subset(!is.na(RGN)), 'RGN'),
        ms_dissolve(yb |> merge(y[, .(LAD, RGN)]) |> subset(substr(LAD, 1, 1) == 'W'), 'RGN')
)
save_as_rda(ybr, 'RGN', FALSE)
st_write(ybr, './data-raw/RGN.kml', delete_layer = TRUE)

# CLEAN & EXIT
rm(list = ls())
gc()

