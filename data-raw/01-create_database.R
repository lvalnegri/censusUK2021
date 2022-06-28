#############################################
# Create databases e tables in MySQL server #
#############################################

library(Rfuns)

dbn <- 'uk_census_2022'
dd_create_db(dbn)

## TABLE <zones> --------------------
x <- "
    `LAD` CHAR(9) NOT NULL,
    `LADn` VARCHAR(35) NOT NULL,
    `UTLA` CHAR(9) NOT NULL,
    `UTLAn` VARCHAR(35) NOT NULL,
    `RGN` CHAR(9) NULL DEFAULT NULL,
    `RGNn` CHAR(25) NULL DEFAULT NULL,
    `CTRY` CHAR(9) NOT NULL,
    `CTRYn` CHAR(7) NOT NULL,
    `x_lon` DECIMAL(10,8) NOT NULL,
    `y_lat` DECIMAL(10,8) NOT NULL,
    `area` DECIMAL(9,5) NOT NULL,
    PRIMARY KEY (`LAD`),
    KEY `UTLA` (`UTLA`),
    KEY `RGN` (`RGN`),
    KEY `CTRY` (`CTRY`)
"
dd_create_dbtable('zones', dbn, x)

## TABLE <tables> -----------------
x <- "
    `id` CHAR(3) NOT NULL,
    `description` VARCHAR(75) NOT NULL,
    `lowest_geo` CHAR(4) NOT NULL,
    `countries` CHAR(4) NOT NULL,
    PRIMARY KEY (`id`)
"
dd_create_dbtable('tables', dbn, x)

## TABLE <vars> -----------------
x <- "
    `id` CHAR(6) NOT NULL,
    `table_id` CHAR(3) NOT NULL,
    `description` VARCHAR(75) NOT NULL,
    `slabel` CHAR(15) NOT NULL,
    `label` CHAR(15) NOT NULL,
    `reference` CHAR(6) NULL DEFAULT NULL,
    `historic` TINYINT UNSIGNED NOT NULL COMMENT '0- current only, 1- both current and historic,
2- historic only. To query current: <= 1, to query both: >= 1.',
    `ordering` TINYINT UNSIGNED NOT NULL,
    PRIMARY KEY (`id`),
    KEY `table_id` (`table_id`),
    KEY `reference` (`reference`),
    KEY `historic` (`historic`),
    KEY `ordering` (`ordering`)
"
dd_create_dbtable('vars', dbn, x)

## TABLE <dataset> -----------------
x <- "
    `var_id` CHAR(6) NOT NULL,
    `zone_id` CHAR(9) NOT NULL,
    `period` SMALLINT UNSIGNED NOT NULL,
    `value` MEDIUMINT UNSIGNED NOT NULL,
    PRIMARY KEY (`var_id`, `zone_id`, `period`)
"
dd_create_dbtable('dataset', dbn, x)

## END --------------------------------
rm(list = ls())
gc()
