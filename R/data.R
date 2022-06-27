#' @importFrom data.table data.table
NULL

#' lookups
#'
#' List of all Local Authority Districts in England and wales, with correspondent Region
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
'lookups'


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
