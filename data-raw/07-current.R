#########################################################
# UK CENSUS 2021 Preliminary data for England and Wales #
#########################################################
# https://www.ons.gov.uk/releases/initialfindingsfromthe2021censusinenglandandwales
# https://www.ons.gov.uk/peoplepopulationandcommunity/populationandmigration/populationestimates/bulletins/populationandhouseholdestimatesenglandandwales/census2021

Rfuns::load_pkgs(dmp = FALSE, 'data.table', 'readxl')

tmpf <- tempfile()
download.file('https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/populationandmigration/populationestimates/datasets/populationandhouseholdestimatesenglandandwalescensus2021/census2021/census2021firstresultsenglandwales1.xlsx', tmpf)
yv <- fread('./data-raw/vars.csv')[historic <= 1]
yz <- fread('./data-raw/zones.csv')
yz <- unique(rbindlist(list(yz[, .(LAD)], yz[, .(UTLA)], yz[!is.na(RGN), .(RGN)], yz[, .(CTRY)]), use.names = FALSE))[order(LAD)]
dts <- data.table()
for(sh in grep('^P|H', excel_sheets(tmpf), value = TRUE)){
    yd <- read_xlsx(tmpf, sheet = sh) |> as.data.table() |> setnames(1, 'X')
    yd <- yd[, 2 := NULL][yz[, .(LAD)], on = c(X = 'LAD')]
    names(yd) <- c('zone_id', yv[table_id == sh, id])
    dts <- rbindlist(list( dts, melt(yd, id.vars = 'zone_id', variable.name = 'var_id', variable.factor = FALSE) ))
}
unlink(tmpf)
dts <- dts[!is.na(value)]
dts[, period := 2021]
setcolorder(dts, 'period')

dts <- rbindlist(list( dts, fread('./data-raw/historic.csv') ))
dts[, value := as.integer(round(as.numeric(value)))]
setorderv(dts, c('period', 'zone_id', 'var_id'))

dd_dbm_do('uk_census_2022', 'w', 'dataset', dts)
fn <- 'cdata'
assign(fn, dts)
save( list = fn, file = file.path('data', paste0(fn, '.rda')), version = 3, compress = 'gzip' )
fwrite(dts, './data-raw/dataset.csv')
fst::write_fst(dts, './data-raw/dataset')

rm(list = ls())
gc()
