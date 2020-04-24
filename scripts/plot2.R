nei_baltimore <- nei %>% 
    filter(fips == "24510") %>% 
    group_by(year) %>% 
    summarize(
        sum_emissions = sum(Emissions)
    )

par(mfrow = c(1, 1))
plot(
    x = nei_baltimore$year, 
    y = nei_baltimore$sum_emissions, 
    type = "l", 
    lwd = 2, 
    col = "green", 
    ylim = c(0, 3500),
    xlab = "Year",
    ylab = expression("Total PM"[2.5]*" emission (ton)"),
    main = "Particulate Matter Emissions in Baltimore"
)
abline(
    lm(
        data = nei_baltimore, 
        formula = sum_emissions ~ year
    ),
    lty = 2
)

dev.copy(png, "./images/plot2.png")
dev.off()