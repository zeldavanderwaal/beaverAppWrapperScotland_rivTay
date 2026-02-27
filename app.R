# This is a Shiny web application to run the real package (beaverApp) from GitHub, along with custom regional data (also on gitHub)

#  the demo data backend 
options(beaverApp.data.pkg = "beaverAppDataScotlandRivTay")   #  data package for this deployment 
Sys.setenv(BEAVERAPP_DATA_PKG = "beaverAppDataScotlandRivTay", 
           APP_MODE="normal",    
           BEAVERAPP_VERBOSE =FALSE,
           APP_REGION="Scotland",
           APP_REGIONSUBSET= "rivTay",
           BEAVERAPP_TTLESUFF= "River Tay (case study)",
           BEAVERAPP_NREPS3= 30L,
           BEAVERAPP_NREPS4= 50L,
           BEAVERAPP_NREPS5= 100L,
           BEAVERAPP_STARTOBS= "2011")

app_password <<- Sys.getenv("BEAVERAPP_PASSWORD") 
 


cat("\n>>> collating territory obs records for River Tay >>>\n")
folder <- system.file("extdata",  package = "beaverAppDataScotlandRivTay")
stopifnot(nzchar(folder), dir.exists(folder))

shp <- paste0(folder,  "/TerrListAutomated_2012.shp")  
tay_terrAutomated_2012 <<- sf::st_read(shp, quiet = TRUE)

shp <- paste0(folder, "/tay2012_38TERRS_centroids4326.shp")  
tay_terrCentroids_2012 <<- sf::st_read(shp, quiet = TRUE)

folder <- system.file("extdata", package = "beaverAppDataScotlandRivTay") 
shp <- paste0(folder,"/TerrListAutomated_2018.shp")  
tay_terrAutomated_2018 <<- sf::st_read(shp, quiet = TRUE)

shp <- paste0(folder, "/tay2018_123centro27700.shp")  
tay_terrCentroids_2018 <<- sf::st_read(shp, quiet = TRUE)


ui_m_localdata <<- tagList( actionButton("tay_terrAutomated_2012", "packaged 2012 Tay survey (automated)"),
                     actionButton("tay_terrCentroids_2012", "packaged 2012 Tay survey - territories centroids") ,
                     p(""),
                     actionButton("tay_terrAutomated_2018", "packaged 2018 Tay survey (automated)"),
                     actionButton("tay_terrCentroids_2018", "packaged 2018 Tay survey - territories centroids") 
)

ui_c_localdata <<- tagList( actionButton("showtay_terrAutomated_2012", "packaged 2012 Tay survey (automated)"),
                            actionButton("showtay_terrCentroids_2012", "packaged 2012 Tay survey - territories centroids") ,
                            p(""),
                            actionButton("showtay_terrAutomated_2018", "packaged 2018 Tay survey (automated)"),
                            actionButton("showtay_terrCentroids_2018", "packaged 2018 Tay survey - territories centroids") 
)


cat("\n>>> launching beaverApp from Scotland (River Tay) wrapper >>>\n")
    
beaverApp::launch_app(run = FALSE)   

