install.packages("flexdashboard", type = "source")

# Install Archived Zipcode Package
zipcode_url <- "https://cran.r-project.org/src/contrib/Archive/zipcode/zipcode_1.0.tar.gz"
install.packages(zipcode_url, repos=NULL, type="source")

install.packages("plotly", repos="http://cran.rstudio.com/", dependencies=TRUE)
install.packages(c("knitr", "rmarkdown"))
install.packages("aws.s3", repos = "https://cloud.R-project.org")
install.packages("dplyr")
install.packages("leaflet")
install.packages("leaflet.providers")
install.packages("sqldf")
