#' @importFrom data.table data.table
NULL

#' zones
#'
#' List of all zones in England and Wales included in "dataset", displayed as a lookup table
#' 
#' @format A data.table with the following columns:
#' \describe{
#'   \item{\code{ LAD }}{ ONS code for Local Authority Districts }
#'   \item{\code{ x_lon }}{ Longitude of the geometric centroid for Local Authority Districts }
#'   \item{\code{ y_lat }}{ Latitude of the geometric centroid for Local Authority Districts }
#'   \item{\code{ area }}{ Area for Local Authority Districts }
#'   \item{\code{ LADn }}{ ONS description for Local Authority Districts}
#'   \item{\code{ UTLA }}{ ONS code for Upper Tier Local Authority }
#'   \item{\code{ UTLAn }}{ ONS description for Upper Tier Local Authority }
#'   \item{\code{ RGN }}{ ONS code for Region (England only) }
#'   \item{\code{ RGNn  }}{ ONS description for Region (England only) }
#'   \item{\code{ CTRY  }}{ ONS code for Country }
#'   \item{\code{ CTRYn  }}{ ONS description for Country }
#' }
#'
#' For more details, consult the website \url{https://geoportal.statistics.gov.uk/}
#'
'zones'

#' dataset
#'
#' Data for Local Authority Districts (and up) in England and Wales for the Census from 1981 to 2021, 
#' 
#' @format A data.table with the following columns:
#' \describe{
#'   \item{\code{ period }}{ Year of Census: 1981 to 2021 }
#'   \item{\code{ zone_id }}{ ONS code for the zone (see table `zones`) }
#'   \item{\code{ var_id }}{ Code for the variable (see column `id` in table `vars`) }
#'   \item{\code{ value }}{ Value for the variable at those zone and year  }
#' }
#'
#' For more details, consult the website \url{https://www.ons.gov.uk/peoplepopulationandcommunity/populationandmigration/populationestimates/bulletins/populationandhouseholdestimatesenglandandwales/census2021}
#'
'dataset'

#' tables
#'
#' List of the tables disseminated with preliminary results from ONS for Census 2021 (28-Jun-2022)
#' 
#' @format A data.table with the following columns:
#' \describe{
#'   \item{\code{ id }}{ ONS code for the table }
#'   \item{\code{ description }}{ Description of the content of the table }
#'   \item{\code{ lowest_geo }}{ Minimum geographic level for the data (see table `zones`) }
#'   \item{\code{ countries }}{ Countries to which data for each table are related }
#' }
#'
#' For more details, consult the website \url{https://www.ons.gov.uk/releases/initialfindingsfromthe2021censusinenglandandwales}
#'
'tables'

#' vars
#'
#' List of the variables disseminated with preliminary results from ONS for Census 2021 (28-Jun-2022)
#' 
#' @format A data.table with the following columns:
#' \describe{
#'   \item{\code{ id }}{ Code for the variable }
#'   \item{\code{ table_id }}{ Identifier for the table the var is included into (see column `id` in table `table`) }
#'   \item{\code{ description }}{ Long Description for the variable }
#'   \item{\code{ slabel }}{ Short Label for Chart and Plots }
#'   \item{\code{ label }}{ Label for Chart and Plots }
#'   \item{\code{ reference }}{ Reference variable id for rates and proportions }
#'   \item{\code{ historic }}{ For query the correct variables depending on current only or historic trend:
#'                              0- current only, 
#'                              1- both current and historic,
#'                              2- historic only. 
#'                              To query current: <= 1, to query both: >= 1.    
#'    }
#'   \item{\code{ ordering }}{ Columns to reference for ordering the variables in the same table  }
#' }
#'
#' For more details, consult the website \url{https://www.ons.gov.uk/releases/initialfindingsfromthe2021censusinenglandandwales}
#'
'vars'


#' @import sf
NULL

#' LAD 
#'
#' Geographic Boundaries in \code{sf} format for Local Authority Districts in England and Wales (last update: May 2021). 
#'
#' More information can be found in the table \code{lookups}.
#'
#' For more details, consult the website \url{https://geoportal.statistics.gov.uk/}
#'
'LAD'

#' UTLA 
#'
#' Geographic Boundaries in \code{sf} format for Upper Tier Local Authority in England and Wales (last update: Dec 2021). 
#'
#' More information can be found in the table \code{lookups}.
#'
#' For more details, consult the website \url{https://geoportal.statistics.gov.uk/}
#'
'UTLA'

#' RGN 
#'
#' Geographic Boundaries in \code{sf} format for Regions in England (last update: May 2021). 
#'
#' More information can be found in the table \code{lookups}.
#'
#' For more details, consult the website \url{https://geoportal.statistics.gov.uk/}
#'
'RGN'
