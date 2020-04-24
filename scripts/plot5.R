scc_vehicle <- tscc %>% 
    filter(grepl("vehicle", SCC.Level.Two, ignore.case = TRUE))

total_vehicles_baltimore <- nei %>% 
    filter(SCC %in% scc_vehicle$SCC, fips == "24510") %>% 
    group_by(year, type) %>% 
    summarize(
        emissions = sum(Emissions)
    )

ggplot(total_vehicles_baltimore, aes(year, emissions, group = type, color = type)) +
    geom_point(na.rm = TRUE) +
    geom_smooth(
        method = "lm", 
        lty = 2, 
        se = FALSE,
        color = "grey",
        lwd = .5
    ) +
    geom_smooth() +
    labs(
        x = "Year",
        y = expression("Total PM"[2.5]*" emission (ton)"),
        color = "Type",
        title = "Total Vehicle Emissions in Baltimore City",
        subtitle = "(1999-2008)"
    ) +
    theme_minimal()


dev.copy(png, "./images/plot5.png")
dev.off()