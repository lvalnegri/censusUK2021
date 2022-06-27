#############################################
# Create databases e tables in MySQL server #
#############################################

library(Rfuns)

dbn <- 'uk_census_2022'
dd_create_db(dbn)

## TABLE <lookups> --------------------
x <- "
    `LAD` CHAR(9) NOT NULL,
    `x_lon` DECIMAL(10,8) NOT NULL,
    `y_lat` DECIMAL(10,8) NOT NULL,
    `area` DECIMAL(9,5) NOT NULL,
    `LADn` VARCHAR(35) NOT NULL,
    `RGN` CHAR(9) NULL DEFAULT NULL,
    `RGNn` CHAR(25) NULL DEFAULT NULL,
    `CTRY` CHAR(9) NOT NULL,
    `CTRYn` CHAR(7) NOT NULL,
    PRIMARY KEY (`LAD`),
    KEY `RGN` (`RGN`),
    KEY `CTRY` (`CTRY`)
"
dd_create_dbtable('lookups', dbn, x)

## TABLE <population> -----------------
x <- "
    `LAD` CHAR(13) NOT NULL,
    `age` TINYINT UNSIGNED NOT NULL,
    `sex` CHAR(1) NOT NULL,
    `value` MEDIUMINT UNSIGNED NOT NULL,
    PRIMARY KEY (`LAD`, `age`, `sex`)
"
dd_create_dbtable('population', dbn, x)

## TABLE <households> -----------------
x <- "
    `LAD` CHAR(13) NOT NULL,
    `value` MEDIUMINT UNSIGNED NOT NULL,
    PRIMARY KEY (`LAD`)
"
dd_create_dbtable('households', dbn, x)

## END --------------------------------
rm(list = ls())
gc()
