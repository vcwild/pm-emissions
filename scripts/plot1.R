library(tidyverse)
library(purl)

download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "mydata.zip")
unzip("mydata.zip", exdir = "./data")
file.remove("mydata.zip")

# National Emissions Inventory (NEI)
nei <- read_rds("./data/summarySCC_PM25.rds")
# Source Classification Code (SCC)
scc <- read_rds("./data/Source_Classification_Code.rds")

total_emissions <- nei %>% 
    group_by(year) %>% 
    summarize(
        sum_emissions = sum(Emissions)
    )

total_emissions <- total_emissions %>% 
    mutate_at(vars(sum_emissions), as.integer)

par(mfrow = c(1, 1))
plot(
    x = total_emissions$year, 
    y = total_emissions$sum_emissions, 
    type = "l", 
    lwd = 2, 
    col = "blue", 
    ylim = c(0, 8e06),
    xlab = "Year",
    ylab = expression("Total PM"[2.5]*" emission (ton)"),
    main = "Particulate Matter Emissions"
)
abline(
    lm(
        data = total_emissions, 
        formula = sum_emissions ~ year
    ),
    lty = 2
)

dev.copy(png, "./images/plot1.png")
dev.off()