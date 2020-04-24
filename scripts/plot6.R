# Section 01 --------------------------------------------------------------

total_vehicles_ba_la <- nei %>% 
    filter(SCC %in% scc_vehicle$SCC, fips == c("24510", "06037")) %>% 
    group_by(fips, year, type) %>% 
    summarize(
        emissions = sum(Emissions)
    ) %>% 
    mutate(
        city = if_else(fips == "24510", "Baltimore", "Los Angeles")
    )

ggplot(total_vehicles_ba_la, aes(year, emissions, group = type, color = type)) +
    geom_point(na.rm = TRUE) +
    geom_line(aes(year, emissions)) +
    facet_grid(city ~ .) +
    geom_smooth(
        method = "lm", 
        lty = 2, 
        se = FALSE,
        color = "grey",
        lwd = .5
    ) +
    labs(
        x = "Year",
        y = expression("Total PM"[2.5]*" emission (ton)"),
        color = "Type",
        title = "Disaggregate Vehicle Emissions Baltimore x Los Angeles",
        subtitle = "(1999-2008)"
    )

dev.copy(png, "./images/plot6_1.png")
dev.off()


# Section 02 --------------------------------------------------------------

sum_vehicles_ba_la <- nei %>% 
    filter(SCC %in% scc_vehicle$SCC, fips == c("24510", "06037")) %>% 
    group_by(fips, year) %>% 
    summarize(
        emissions = sum(Emissions)
    ) %>% 
    mutate(
        city = if_else(fips == "24510", "Baltimore", "Los Angeles")
    ) %>% 
    arrange(year)

ggplot(sum_vehicles_ba_la, aes(year, emissions, group = city, color = city)) +
    geom_point(na.rm = TRUE) +
    geom_smooth(aes(year, emissions)) +
    geom_smooth(
        method = "lm", 
        lty = 2, 
        se = FALSE,
        color = "grey",
        lwd = .5
    ) +
    labs(
        x = "Year",
        y = expression("Total PM"[2.5]*" emission (ton)"),
        color = "County",
        title = "Total Vehicle Emissions Baltimore x Los Angeles",
        subtitle = "(1999-2008)"
    ) +
    theme_minimal()

dev.copy(png, "./images/plot6_2.png")
dev.off()
