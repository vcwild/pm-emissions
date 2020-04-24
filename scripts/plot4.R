tscc <- as.tibble(scc)

scc_coal <- tscc %>% 
    filter(grepl("coal", Short.Name, ignore.case = TRUE))

total_coal <- nei %>% 
    filter(SCC %in% scc_coal$SCC) %>% 
    group_by(year, type) %>% 
    summarize(
        emissions = sum(Emissions)
    )

ggplot(total_coal, aes(year, emissions, group = type, color = type)) +
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
        y = "CCE (ton)",
        color = "Type",
        title = "Total Coal Emissions",
        subtitle = "(1999-2008)"
    ) +
    theme_minimal()


dev.copy(png, "./images/plot4.png")
dev.off()

