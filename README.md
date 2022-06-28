## UK Census 2021

$R$ package that include data, boundaries, functionalities and a [Shiny]() app (to come) to visualize interactively the new preliminary results of the last 2021 UK Census.

If you're only interested in data or boundaries, just look into the `data-raw` folder:
 - `dataset.csv` all currently published data plus its historic since 1981
 - `zones.csv` the lookups between Local Authorithy Districts (LAD), Upper Tier Local Authorities (UTLA), Regions (RGN), Countries (CTRY)
 - `tables.csv` Codes and descriptions for the published tables
 - `vars.csv` Codes and descriptions for the variables included in each table
 - `LAD.kml`, `UTLA.kml` and `RGN.kml` are the boundaries in `kml` format and `WGS84` *CRS* for respectively Local Authorithy Districts, Upper Tier Local Authorities, Regions. 

As of June 2022, data only include *population* by *sex* and *age* in five-years classes plus *households*, with the lowest geographical detail being *Local Authority Districts* in England and Wales only.


### Resources
- [ONS Release Plans](https://www.ons.gov.uk/census/censustransformationprogramme/census2021outputs/releaseplans)
- [Lookups LAD-UTLA](https://geoportal.statistics.gov.uk/documents/ward-to-westminster-parliamentary-constituency-to-local-authority-district-to-upper-tier-local-authority-december-2021-lookup-in-the-united-kingdom/)
- [Boundaries LAD]()


### Attributions
- Contains OS data © Crown copyright and database rights [2022]
- Contains National Statistics data © Crown copyright and database rights [2022]
- Source: Office for National Statistics licensed under the Open Government Licence v.3.0
