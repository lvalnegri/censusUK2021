##################################################
# UK CENSUS 2021 Time series Census 1981 to 2011 #
##################################################
# https://www.ons.gov.uk/aboutus/whatwedo/statistics/requestingstatistics/alladhocs?sortBy=release_date&query=census

library('data.table')

dbn <- 'uk_census_2022'
yv <- fread('./data-raw/vars.csv')
yz <- fread('./data-raw/zones.csv')
yz <- unique(rbindlist(list(yz[, .(zone_id = LAD)], yz[, .(UTLA)], yz[!is.na(RGN), .(RGN)], yz[, .(CTRY)]), use.names = FALSE))[order(zone_id)]

down_files <- function(x1, x2, s = 2){
    tmpf <- tempfile()
    download.file(
        paste0(
          'https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/populationandmigration/populationestimates/adhocs/', 
          x1, x2, 'timeseriescensus1981to2011/', x2, 'timeseriescensus1981to2011.xlsx'
        ), 
        tmpf
    )
    y <- readxl::read_xlsx(tmpf, s) |> as.data.table() |> setnames(1, 'zone_id')
    unlink(tmpf)
    y <- y[, 2 := NULL][yz, on = 'zone_id']
    setnames(y, c('zone_id', 'var', seq(1981, 2011, 10)))
    y <- melt(y, id.vars = c('zone_id', 'var'), variable.factor = FALSE, variable.name = 'period')
    y[!is.na(value)]
}

# CT1214 - Sex
y1 <- down_files('14796', 'ct1214sex')
y1[var == 'Total: Sex', var := 'All Persons']
y1 <- yv[table_id == 'P01', .(var = label, var_id = id)][y1, on = 'var']

# CT1215 - Age
y2 <- down_files('14797', 'ct1215age')
y2 <- yv[table_id == 'P02' & historic >= 1, .(var = label, var_id = id)][y2, on = 'var']

# CT1216 - Sex by age
y31 <- down_files('14798', 'ct1216sexbyage')
y31 <- yv[table_id == 'P03' & historic >= 1, .(var = label, var_id = id)][y31, on = 'var']
y32 <- down_files('14798', 'ct1216sexbyage', 3)
y32 <- yv[table_id == 'P03' & historic >= 1, .(var = label, var_id = id)][y32, on = 'var']
y3 <- rbindlist(list(y31, y32))

# CT1217 - Population density
y4 <- down_files('14799', 'ct1217populationdensity')
y4[, var_id := 'P04001']

# CT???? - Households
# download.file('', tmpf)

# Regroup and save
y <- rbindlist(list( y1, y2, y31, y32, y4 ), use.names = TRUE)
y[, var := NULL]
setcolorder(y, c('period', 'zone_id', 'var_id'))
setorderv(y, c('period', 'zone_id', 'var_id'))
fwrite(y, './data-raw/historic.csv')

# Clean and Exit
rm(list = ls())
gc()
