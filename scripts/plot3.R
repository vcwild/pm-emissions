nei <- as_tibble(nei)

pm_type_baltimore <- nei %>% 
    filter(fips == "24510") %>% 
    group_by(type, year) %>%
    summarize(
        emissions = sum(Emissions)
    ) %>% 
    arrange(year, type)

ggplot(pm_type_baltimore, aes(year, emissions, group = type, color = type)) +
    geom_point(na.rm = TRUE) +
    geom_smooth() +
    labs(
        x = "Year",
        y = expression("Total PM"[2.5]*" emission (ton)"),
        color = "Type",
        title = "Emissions in Baltimore City",
        subtitle = "(1999-2008)",
        shape = ""
    ) +
    geom_smooth(
        method = "lm", 
        lty = 2, 
        se = FALSE,
        lwd = 0.2
    ) +
    theme_minimal()

dev.copy(png, "./images/plot3.png")
dev.off()