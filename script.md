Untitled
================

## Title

The overall goal of this project is to explore the National Emissions
Inventory database and see what it say about fine particulate matter
pollution in the United states over the 10-year period 1999–2008.

### Steps

Pick libraries to use in the project

``` r
library(ggplot2)
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
library(readr)
```

Download and extract data set from EPA National Emissions Inventory
(USA)

``` r
#download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "mydata.zip")
#unzip("mydata.zip", exdir = "./data")
#file.remove("mydata.zip")
```

Read tables into the Environment

``` r
# National Emissions Inventory (NEI)
nei <- read_rds("./data/summarySCC_PM25.rds")
# Source Classification Code (SCC)
scc <- read_rds("./data/Source_Classification_Code.rds")
```

See a glimpse of the content

``` r
glimpse(nei)
```

    ## Rows: 6,497,651
    ## Columns: 6
    ## $ fips      <chr> "09001", "09001", "09001", "09001", "09001", "09001", "0900…
    ## $ SCC       <chr> "10100401", "10100404", "10100501", "10200401", "10200504",…
    ## $ Pollutant <chr> "PM25-PRI", "PM25-PRI", "PM25-PRI", "PM25-PRI", "PM25-PRI",…
    ## $ Emissions <dbl> 15.714, 234.178, 0.128, 2.036, 0.388, 1.490, 0.200, 0.081, …
    ## $ type      <chr> "POINT", "POINT", "POINT", "POINT", "POINT", "POINT", "POIN…
    ## $ year      <int> 1999, 1999, 1999, 1999, 1999, 1999, 1999, 1999, 1999, 1999,…

``` r
glimpse(scc)
```

    ## Rows: 11,717
    ## Columns: 15
    ## $ SCC                 <fct> 10100101, 10100102, 10100201, 10100202, 10100203,…
    ## $ Data.Category       <fct> Point, Point, Point, Point, Point, Point, Point, …
    ## $ Short.Name          <fct> "Ext Comb /Electric Gen /Anthracite Coal /Pulveri…
    ## $ EI.Sector           <fct> Fuel Comb - Electric Generation - Coal, Fuel Comb…
    ## $ Option.Group        <fct> , , , , , , , , , , , , , , , , , , , , , , , , , 
    ## $ Option.Set          <fct> , , , , , , , , , , , , , , , , , , , , , , , , , 
    ## $ SCC.Level.One       <fct> External Combustion Boilers, External Combustion …
    ## $ SCC.Level.Two       <fct> Electric Generation, Electric Generation, Electri…
    ## $ SCC.Level.Three     <fct> Anthracite Coal, Anthracite Coal, Bituminous/Subb…
    ## $ SCC.Level.Four      <fct> "Pulverized Coal", "Traveling Grate (Overfeed) St…
    ## $ Map.To              <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
    ## $ Last.Inventory.Year <int> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N…
    ## $ Created_Date        <fct> , , , , , , , , , , , , , , , , , , , 6/6/2003 0:…
    ## $ Revised_Date        <fct> , , , , , , , , , , , , , , , , , , , , , , , , , 
    ## $ Usage.Notes         <fct> , , , , , , , , , , , , , , , , , , , , , , , , ,

### Questions:

#### Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

Look for years tracked in inventory

``` r
unique(nei$year)
```

    ## [1] 1999 2002 2005 2008

Filter total emissions for each year

``` r
total_emissions <- nei %>% 
    group_by(year) %>% 
    summarize(
        sum_emissions = sum(Emissions)
    )

total_emissions
```

    ## # A tibble: 4 x 2
    ##    year sum_emissions
    ##   <int>         <dbl>
    ## 1  1999      7332967.
    ## 2  2002      5635780.
    ## 3  2005      5454703.
    ## 4  2008      3464206.

Change column *sum\_emissions* to integer

``` r
total_emissions <- total_emissions %>% 
    mutate_at(vars(sum_emissions), as.integer)
total_emissions
```

    ## # A tibble: 4 x 2
    ##    year sum_emissions
    ##   <int>         <int>
    ## 1  1999       7332966
    ## 2  2002       5635780
    ## 3  2005       5454703
    ## 4  2008       3464205

``` r
par(mfrow = c(1, 1))
barplot(total_emissions$sum_emissions, names.arg = total_emissions$year, col = "slategray2")
```

![](script_files/figure-gfm/unnamed-chunk-9-1.png)<!-- -->

#### Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips==“24510”) from 1999 to 2008?
